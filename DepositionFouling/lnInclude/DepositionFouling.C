/*---------------------------------------------------------------------------*\
  =========                 |
  \\      /  F ield         | OpenFOAM: The Open Source CFD Toolbox
   \\    /   O peration     |
    \\  /    A nd           | Copyright (C) 2011-2014 OpenFOAM Foundation
     \\/     M anipulation  |
-------------------------------------------------------------------------------
License
    This file is part of OpenFOAM.

    OpenFOAM is free software: you can redistribute it and/or modify it
    under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    OpenFOAM is distributed in the hope that it will be useful, but WITHOUT
    ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
    FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License
    for more details.

    You should have received a copy of the GNU General Public License
    along with OpenFOAM.  If not, see <http://www.gnu.org/licenses/>.

\*---------------------------------------------------------------------------*/

#include "DepositionFouling.H"
#include "Random.H"
#include "fvMesh.H"
#include "OSstream.H"
#include "fvCFD.H"
#include "Time.H"
#include "meshSearchMeshObject.H"
#include "meshSearch.H"
#include "polyMesh.H"
#include "primitiveMesh.H"
#include "point.H"
#include "uniformDimensionedFields.H"
#include "cellPointWeight.H"

// * * * * * * * * * * * * * * * Constructors  * * * * * * * * * * * * * * * //

template<class CloudType>
Foam::DepositionFouling<CloudType>::DepositionFouling
(
    const dictionary& dict,
    CloudType& cloud
)
:
    PatchInteractionModel<CloudType>(dict, cloud, typeName),
    patchData_(cloud.mesh(), this->coeffDict()),
    nEscape_(patchData_.size(), 0),
    massEscape_(patchData_.size(), 0.0),
    nStick_(patchData_.size(), 0),
    massStick_(patchData_.size(), 0.0),
    writeFields_(this->coeffDict().lookupOrDefault("writeFields", false)),
    massEscapePtr_(NULL),
    massStickPtr_(NULL)
{
    if (writeFields_)
    {
        word massEscapeName(this->owner().name() + ":massEscape");
        word massStickName(this->owner().name() + ":massStick");
        Info<< "    Interaction fields will be written to " << massEscapeName
            << " and " << massStickName << endl;

        (void)massEscape();
        (void)massStick();
    }
    else
    {
        Info<< "    Interaction fields will not be written" << endl;
    }

    // check that interactions are valid/specified
    forAll(patchData_, patchI)
    {
        const word& interactionTypeName =
            patchData_[patchI].interactionTypeName();
        const typename PatchInteractionModel<CloudType>::interactionType& it =
            this->wordToInteractionType(interactionTypeName);

        if (it == PatchInteractionModel<CloudType>::itOther)
        {
            const word& patchName = patchData_[patchI].patchName();
            FatalErrorIn("DepositionFouling(const dictionary&, CloudType&)")
                << "Unknown patch interaction type "
                << interactionTypeName << " for patch " << patchName
                << ". Valid selections are:"
                << this->PatchInteractionModel<CloudType>::interactionTypeNames_
                << nl << exit(FatalError);
        }
    }
}



//template <class Type>
//	const Foam::objectRegistry& Foam::fvPatchField<Type>::db const
//	{
//		return patch_.boundaryMesh().mesh();
//	}

template<class CloudType>
Foam::DepositionFouling<CloudType>::DepositionFouling
(
    const DepositionFouling<CloudType>& pim
)
:
    PatchInteractionModel<CloudType>(pim),
    patchData_(pim.patchData_),
    nEscape_(pim.nEscape_),
    massEscape_(pim.massEscape_),
    nStick_(pim.nStick_),
    massStick_(pim.massStick_),
    writeFields_(pim.writeFields_),
    massEscapePtr_(NULL),
    massStickPtr_(NULL)
{}


// * * * * * * * * * * * * * * * * Destructor  * * * * * * * * * * * * * * * //

template<class CloudType>
Foam::DepositionFouling<CloudType>::~DepositionFouling()
{}


// * * * * * * * * * * * * * * Member Functions  * * * * * * * * * * * * * * //

template<class CloudType>
Foam::volScalarField& Foam::DepositionFouling<CloudType>::massEscape()
{
    if (!massEscapePtr_.valid())
    {
        const fvMesh& mesh = this->owner().mesh();

        massEscapePtr_.reset
        (
            new volScalarField
            (
                IOobject
                (
                    this->owner().name() + ":massEscape",
                    mesh.time().timeName(),
                    mesh,
                    IOobject::READ_IF_PRESENT,
                    IOobject::AUTO_WRITE
                ),
                mesh,
                dimensionedScalar("zero", dimMass, 0.0)
            )
        );
    }

    return massEscapePtr_();
}


template<class CloudType>
Foam::volScalarField& Foam::DepositionFouling<CloudType>::massStick()
{
    if (!massStickPtr_.valid())
    {
        const fvMesh& mesh = this->owner().mesh();

        massStickPtr_.reset
        (
            new volScalarField
            (
                IOobject
                (
                    this->owner().name() + ":massStick",
                    mesh.time().timeName(),
                    mesh,
                    IOobject::READ_IF_PRESENT,
                    IOobject::AUTO_WRITE
                ),
                mesh,
                dimensionedScalar("zero", dimMass, 0.0)
            )
        );
    }

    return massStickPtr_();
}


template<class CloudType>
bool Foam::DepositionFouling<CloudType>::correct
(
    typename CloudType::parcelType& p,
    const polyPatch& pp,
    bool& keepParticle,
    const scalar trackFraction,
    const tetIndices& tetIs
)
{


    label patchI = patchData_.applyToPatch(pp.index());

//    if (isA<wallPolyPatch>(pp))
    if (patchI >= 0)
    {
        vector& U = p.U();
        bool& active = p.active();

        typename PatchInteractionModel<CloudType>::interactionType it =
            this->wordToInteractionType
            (
                patchData_[patchI].interactionTypeName()
            );

        switch (it)
        {
            case PatchInteractionModel<CloudType>::itEscape:
            {
                scalar dm = p.mass()*p.nParticle();

                keepParticle = false;
                active = false;
                U = vector::zero;
                nEscape_[patchI]++;
                massEscape_[patchI] += dm;
                if (writeFields_)
                {
                    label pI = pp.index();
                    label fI = pp.whichFace(p.face());
                    massEscape().boundaryField()[pI][fI] += dm;
                }
                break;
            }
//            case PatchInteractionModel<CloudType>::itStick:
//            {
//                scalar dm = p.mass()*p.nParticle();
//
//                keepParticle = true;
//                active = false;
//                U = vector::zero;
//                nStick_[patchI]++;
//                massStick_[patchI] += dm;
//                if (writeFields_)
//                {
//                    label pI = pp.index();
//                    label fI = pp.whichFace(p.face());
//                    massStick().boundaryField()[pI][fI] += dm;
//                }
//                break;
//            }
            case PatchInteractionModel<CloudType>::itStick:
            {

                scalar dm = p.mass()*p.nParticle();
                keepParticle = true;

		//The following values are hard-coded for Volcanic ash.
		//The equation to be implemented is Sp=A*exp(-C1/(0.5*mp*vpn^2*(1+3027T/T*)))

                scalar  A   = 0.897;
                scalar  C1  = 2.51e-5;
                scalar  C2  = 3026.975;	
		scalar  T   = p.T();	
//		T   = 1423.0;	
		scalar  dum;	
		scalar  Sp;
                vector  nw;
                vector  Up;
                float  dx,dy,dz;
                scalar 	d=p.d();
		scalar  rho=p.rho();
                vector 	xyz=p.position();

                this->owner().patchData(p, pp, trackFraction, tetIs, nw, Up);

		const fvMesh& mesh   = this->owner().mesh();
		
//		const fvMesh& initialMesh   = this->owner().initialMesh();
//		const fvMesh& points = this->owner().meshPoints();


                // Calculate motion relative to patch velocity
                U -= Up;

                scalar Un = U & nw;
                vector Ut = U - Un*nw;

		C2=1.0+C2*T/1000.0;
	
		C2=0.5*Un*Un*p.mass()*C2;

		if (C2 != 0.0)
		{

			Sp = A*exp(-C1/C2);
		}
		else
		{
			Sp=0.0;
		}

		Sp = max(Sp,0.0);
		Sp = min(Sp,1.0);
		//Metropolis selection: random number (uniform value) 

	
		Info << "Sticking probability: " << Sp << "\n";

		Pout << "Sticking probability: " << Sp << "\n";

		Info << "T" << T << "	Un	"<< Un << "	pmass	"<< p.mass() << endl;

		Pout << "T" << T << "	Un	"<< Un << "	pmass	"<< p.mass() << endl;

		Random  rndGen(Sp/2.0*1.0*Sp*1234567.0);

		dum=rndGen.GaussNormal();

		if (dum <=0.0)
		{
			dum = -dum ;
		}

		if (dum >= 1.0)
		{
			dum = dum/2.0 ;
		}


//		Info << "Sp of particle: " << Sp << "threshold:   " << dum << "\n";
		Info << "dummy value " << dum << "\n";
		Pout << "dummy value " << dum << "\n";

		if ((dum <= Sp ) && (Sp>0.0))
		{
	
			Info << "position of the particle" << xyz ;

			active = false;
                	label fI = pp.whichFace(p.face());
//      	          label pI = pp.index();
//			label patchID = mesh.boundaryMesh().findPatchID(patchData_[patchI].patchName());
			label patchID = mesh.boundaryMesh().findPatchID("blade");
			

			Info << "The particle which diameter is" << d << endl;
			Info << "Sticks to face" << fI << endl;


//			x=mesh.boundaryMesh()[pI].faceCentres()[fI].x();
//			y=mesh.boundaryMesh()[pI].faceCentres()[fI].y();
//			z=mesh.boundaryMesh()[pI].faceCentres()[fI].z();



			labelList		facePoints = mesh.boundaryMesh()[patchID].localFaces()[fI];

		//	labelList		IDpoints =   mesh.boundaryMesh()[patchID].meshPoints();

		// I'll deffine the displacement in such a way that the volume is conserved
		// faceAreas returns a vector, I must transform it in a scalar
		 	vector	 areaV;

			areaV=mesh.boundaryMesh()[patchID].faceAreas()[fI];

			scalar	area;
	
			area= mag(areaV);

		// displacement
			scalar dh;
	
//			dh=p.mass()/rho/area;
		//Since the average cell size is equal to 100 times the spread factor: 
		//The volume is 100 times bigger (We can say that the displacement is equal to the one due
		// to the arrival of 100 particles): To keep the balance just divide the incoming concentration by 100
		//To mantain the statistical independence let's say multiply by ten
			

			dh=p.mass()/rho/area*10;

		// The sign - because the normal vector points outward the surface.

			dx=-nw.x()*dh;
			dy=-nw.y()*dh;
			dz=-nw.z()*dh;

		//Reference to the location of pointDisplacement field
			pointVectorField& PointDisplacement= const_cast<pointVectorField&>
			(
				mesh.lookupObject<pointVectorField>("pointDisplacement")
			);

		//Get the vectorField of the patch
			vectorField 	&pDisp=refCast<vectorField>(PointDisplacement.boundaryField()[patchID]);

		//Relevant size of the vector and declare a vectorField of the same dimensions:
			int	Psize=pDisp.size();
	
			vectorField dispVals(Psize);

		//Create a pointer equal to PointDisplacement
			vectorField	&PointPointer = refCast<vectorField>(PointDisplacement.boundaryField()[patchID]);

	
			vectorField	PointNormalVector= mesh.boundaryMesh()[patchID].pointNormals();

			Info << "ispVals assingement" << endl;

			forAll (dispVals,index)
			{
				
				
				dispVals[index].x()=PointPointer[index].x(); 
				dispVals[index].y()=PointPointer[index].y();
				dispVals[index].z()=PointPointer[index].z();
	
			}



			forAll (facePoints,index)
			{
	
				Info << "point" << facePoints[index] << "	" << "\n" ;
//				Info << "ID" << IDpoints[facePoints[index]] << "	" << "\n" ;
	
	//			Info << "index" << mesh.findNearestCell(xyz)<< "	" << "\n" ;
	
	//			label id = mesh.findCell(xyz);
	//		
	//
				Info << "normal vector" << PointNormalVector[facePoints[index]] << "\n";
				
					dispVals[facePoints[index]].x()+=dx; 
					dispVals[facePoints[index]].y()+=dy;
					dispVals[facePoints[index]].z()+=dz;
		
				Info << "displacement" << dispVals[facePoints[index]] << "\n";
	
	
			}
			
	
			//Pass the value to pointDisplacement boundary field
			
			PointDisplacement.boundaryField()[patchID]==dispVals;
	
	
	                U = vector::zero;
	                nStick_[patchI]++;
	                massStick_[patchI] += dm;
	                if (writeFields_)
	                {
	                    label pI = pp.index();
	                    label fI = pp.whichFace(p.face());
	                    massStick().boundaryField()[pI][fI] += dm;
	                }
	                break;
		}

		if ((dum >  Sp ) && (Sp>0) && (Un >0))
		{
	
			Info << "position of the particle" << xyz ;
	
	                label fI = pp.whichFace(p.face());
//			label patchID = mesh.boundaryMesh().findPatchID(patchData_[patchI].patchName());
			label patchID = mesh.boundaryMesh().findPatchID("blade");

			Info << "The particle which diameter is" << d << endl;
			Info << "Hits the face" << fI << " and erode" << endl;
	
			labelList		facePoints = mesh.boundaryMesh()[patchID].localFaces()[fI];
//			labelList		IDpoints =   mesh.boundaryMesh()[patchID].meshPoints();
	
			// I'll deffine the displacement in such a way that the volume is conserved
			// faceAreas returns a vector, I must transform it in a scalar
		 	vector	 areaV;
	
			areaV=mesh.boundaryMesh()[patchID].faceAreas()[fI];
	
			scalar	area;
		
			area= mag(areaV);

			// displacement
			
			scalar dh;
		
			dh=p.mass()/rho/area;
	
			// The sign - because the normal vector points outward the surface.
	
			dx=nw.x()*dh;
			dy=nw.y()*dh;
			dz=nw.z()*dh;
	
			//Reference to the location of pointDisplacement field
			pointVectorField& PointDisplacement= const_cast<pointVectorField&>
			(
				mesh.lookupObject<pointVectorField>("pointDisplacement")
			);
	
			//Get the vectorField of the patch
		
			vectorField 	&pDisp=refCast<vectorField>(PointDisplacement.boundaryField()[patchID]);
	
			//Relevant size of the vector and declare a vectorField of the same dimensions:
	
	
			int	Psize=pDisp.size();
	
			vectorField dispVals(Psize);
	
			//Create a pointer equal to PointDisplacement
	
			vectorField	&PointPointer = refCast<vectorField>(PointDisplacement.boundaryField()[patchID]);
	
		
			vectorField	PointNormalVector= mesh.boundaryMesh()[patchID].pointNormals();
	
			forAll (dispVals,index)
			{
				
				
				dispVals[index].x()=PointPointer[index].x(); 
				dispVals[index].y()=PointPointer[index].y();
				dispVals[index].z()=PointPointer[index].z();
	
			}
	
	
	
//			forAll (facePoints,index)
//			{
	
				Info << "point" << facePoints[1] 		<< "	" << "\n" ;
//				Info << "ID"    << IDpoints[facePoints[1]] 	<< "	" << "\n" ;
	
	//			Info << "index" << mesh.findNearestCell(xyz)<< "	" << "\n" ;
	//			label id = mesh.findCell(xyz);
	
//				Info << "normal vector" << PointNormalVector[facePoints[index]] << "\n";
	
	
//				Info << "boundary ...." << dispVals[index].x() << "  " << dispVals[index].y() << dispVals[index].z() << "\n";
	
				if ((dispVals[1].x() ==0) && (dispVals[1].y()==0)  && (dispVals[1].z()==0))
				{	
	
	
					
					Info << "Particle has hit a clean area of the blade and thus it erodes the metal" << endl; 
					
					//model for the hot erosion of the metal
					//Tabakoff model: effect of particle size distribution on particle dynamics and blade erosion
					//in axial flow turbine ASME 1990
					if(Un==0)
					{
					        Un = 1.0e-10;	
					}
					if(mag(Ut)==0)
					{
					        Ut.x() = 1.0e-10;	
					        Ut.y() = 1.0e-10;	
					}

					float	Beta1= atan(Un/mag(Ut));

				 	scalar  Beta1deg=Beta1*90.0/3.1415;
//					Info << "Beta1"	<< Beta1deg << "degrees"<< endl;
	
					scalar	k1=1.505101e-6;
	
					scalar	k12=0.296077;
	
					scalar	k3=5.0e-12;
	
					float	Beta0deg=75.0;
	
					scalar	Ck;
	
					if (Beta1deg < 2.0*Beta0deg) 
					{
						Ck=1.0;
					}
					else
					{	
						Ck=0.0;
					}
	 
					scalar Rt=1.0-0.0016*mag(U)*sin(Beta1);

					scalar	mer;
		
					mer=k1*pow((1.0+Ck*(k12*sin((90.0/Beta0deg*Beta1deg)))),2);

					mer *= mag(U)*mag(U)*cos(Beta1)*cos(Beta1)*(1.0-Rt*Rt);
	
					mer += k3 * pow(U*sin(Beta1),4);
	
					Info << "mer"	<< mer 	    << endl;
					//Once evaluated mer, we should pass to actual mass of material taken away:
					//mer = eroded mass of target material/mass of impinging particle
				
//					Info << "eroded mass fraction evaluated " << endl;
					mer *= p.mass();
					
					//Passing to the linear displacement in normal to the surface direction;
	
					scalar Ver=mer/7800;
	
					scalar dher=Ver/area;
	
	
	              			dx=nw.x()*dher;
	              	        	dy=nw.y()*dher;
					dz=nw.z()*dher;
					
					Info << "dher" << endl;
	
					forAll (facePoints,index)
					{
						dispVals[facePoints[index]].x()+=dx; 
						dispVals[facePoints[index]].y()+=dy;
						dispVals[facePoints[index]].z()+=dz;
					}
					//The rebound of the particle is different if it bounce against the metal or against the 
					//deposit

					//Case of rebound against clean blade
			                active = true;
			
			
			                if ((Un >= 0) &&  ( Beta1deg < Beta0deg))
			                {
					
  	 					Info << "Velocity Before rebound 	" 	<< U << " impact angle " << Beta1 ;

						scalar Betar;

						Betar=	Beta1*(1.0-0.38746*Beta1+0.51422*pow(Beta1,2)+0.45094*pow(Beta1,3));

						scalar Vpr;

//						Vpr=(1.0-0.90847*Beta1+0.3072*pow(Beta1,2)+0.05695*pow(Beta1,3))*mag(U);
						Vpr=mag(U)*(1.0-0.90847*Beta1+0.3072*pow(Beta1,2)+0.05695*pow(Beta1,3));

						vector Vprt= Ut*Vpr/mag(U)*cos(Betar)/cos(Beta1);

						vector Vprn= -Un*nw*Vpr/mag(U)*sin(Betar)/sin(Beta1);

						U=Vprt+Vprn;

			                    	//U -= 1.0 *Un*nw;
				                //U -=Ut;
						//U= -Vprn*nw/sin(Betar);

						Info << "Velocity after rebound 	"	 << U+Up 	<< "Angle after rebound " << Betar <<endl ;
						Info << "COR	 "				 << Betar/Beta1 << endl ;

			                }
					else
			                {
			                    //U -= (1.0 + patchData_[patchI].e())*Un*nw;
  	 					Info << "Velocity Before rebound 	" 	<< U;
			                    	U -= 1.0 *Un*nw;
				                U -=Ut;
  	 					Info << "Velocity after rebound 	" 	<< U+Up;
						Info << "COR	 " 				<< 1;
			                }

			                // Return velocity to global space
			                U += Up;

				}
			
				else
				{
					//model for the erosion of the build up ( now asportation of material of the same size of
					//the incoming particle
	
					Info << "Particle has it the deposit" << endl; 
				
	
					forAll (facePoints,index)
					{
						dispVals[facePoints[index]].x()+=dx; 
						dispVals[facePoints[index]].y()+=dy;
						dispVals[facePoints[index]].z()+=dz;
					}
					//Case of rebound against deposit: no correlation found, simple rebound
					
			                active = true;

	
        			        if (Un >= 0)
			                {
			                    //U -= (1.0 + patchData_[patchI].e())*Un*nw;
			                    U -= 1.0 *Un*nw;
			                }

			                //U -= patchData_[patchI].mu()*Ut;
			                U -=Ut;

			                // Return velocity to global space
			                U += Up;

				}
	
//			}
	
	
//			Info << "displacement" << dispVals[facePoints[index]] << "\n";

		

			//Pass the value to pointDisplacement boundary field
		
			PointDisplacement.boundaryField()[patchID]==dispVals;


	                break;
		}



		// All the non-considered cases:rebound
		else
		{
            
                active = true;


                if ((Un >= 0) |  (Sp>0))
                {
                    U -= (1.0 + patchData_[patchI].e())*Un*nw;
                }

                U -= patchData_[patchI].mu()*Ut;

                // Return velocity to global space
                U += Up;

                break;
		}
            }

/******************************************************************************/

            case PatchInteractionModel<CloudType>::itRebound:
            {
                keepParticle = true;
                active = true;

                vector nw;
                vector Up;

                this->owner().patchData(p, pp, trackFraction, tetIs, nw, Up);

                // Calculate motion relative to patch velocity
                U -= Up;

                scalar Un = U & nw;
                vector Ut = U - Un*nw;

                if (Un > 0)
                {
                    U -= (1.0 + patchData_[patchI].e())*Un*nw;
                }

                U -= patchData_[patchI].mu()*Ut;

                // Return velocity to global space
                U += Up;

                break;
            }
            default:
            {
                FatalErrorIn
                (
                    "bool DepositionFouling<CloudType>::correct"
                    "("
                        "typename CloudType::parcelType&, "
                        "const polyPatch&, "
                        "bool&, "
                        "const scalar, "
                        "const tetIndices&"
                    ") const"
                )   << "Unknown interaction type "
                    << patchData_[patchI].interactionTypeName()
                    << "(" << it << ") for patch "
                    << patchData_[patchI].patchName()
                    << ". Valid selections are:" << this->interactionTypeNames_
                    << endl << abort(FatalError);
            }
        }

        return true;
    }

    return false;
}


template<class CloudType>
void Foam::DepositionFouling<CloudType>::info(Ostream& os)
{
    // retrieve any stored data
    labelList npe0(patchData_.size(), 0);
    this->getModelProperty("nEscape", npe0);

    scalarList mpe0(patchData_.size(), 0.0);
    this->getModelProperty("massEscape", mpe0);

    labelList nps0(patchData_.size(), 0);
    this->getModelProperty("nStick", nps0);

    scalarList mps0(patchData_.size(), 0.0);
    this->getModelProperty("massStick", mps0);

    // accumulate current data
    labelList npe(nEscape_);
    Pstream::listCombineGather(npe, plusEqOp<label>());
    npe = npe + npe0;

    scalarList mpe(massEscape_);
    Pstream::listCombineGather(mpe, plusEqOp<scalar>());
    mpe = mpe + mpe0;

    labelList nps(nStick_);
    Pstream::listCombineGather(nps, plusEqOp<label>());
    nps = nps + nps0;

    scalarList mps(massStick_);
    Pstream::listCombineGather(mps, plusEqOp<scalar>());
    mps = mps + mps0;


    forAll(patchData_, i)
    {
        os  << "    Parcel fate (number, mass)      : patch "
            <<  patchData_[i].patchName() << nl
            << "      - escape                      = " << npe[i]
            << ", " << mpe[i] << nl
            << "      - stick                       = " << nps[i]
            << ", " << mps[i] << nl;
    }

    if (this->outputTime())
    {
        this->setModelProperty("nEscape", npe);
        nEscape_ = 0;

        this->setModelProperty("massEscape", mpe);
        massEscape_ = 0.0;

        this->setModelProperty("nStick", nps);
        nStick_ = 0;

        this->setModelProperty("massStick", mps);
        massStick_ = 0.0;
    }
}


// ************************************************************************* //
