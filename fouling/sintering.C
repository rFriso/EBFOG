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

#include "sintering.H"
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

#include <iterator> 
// * * * * * * * * * * * * * * * Constructors  * * * * * * * * * * * * * * * //

template<class CloudType>
Foam::sintering<CloudType>::sintering
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
            FatalErrorIn("sintering(const dictionary&, CloudType&)")
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
Foam::sintering<CloudType>::sintering
(
    const sintering<CloudType>& pim
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
Foam::sintering<CloudType>::~sintering()
{}


// * * * * * * * * * * * * * * Member Functions  * * * * * * * * * * * * * * //

template<class CloudType>
Foam::volScalarField& Foam::sintering<CloudType>::massEscape()
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
Foam::volScalarField& Foam::sintering<CloudType>::massStick()
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
bool Foam::sintering<CloudType>::correct
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
                p.active(false);
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

		Info << "Particle Hitting the surface\n" << endl;

                scalar dm = p.mass()*p.nParticle();
                keepParticle = true;
 	

                scalar  A   = 0.897;
                scalar  C1  = 2.51e-5;
                scalar  C2  = 3026.975;
		scalar  T   = p.T();

		scalar  Sp;
                vector  nw;
                vector  Up;
                scalar  dx,dy,dz;
                scalar 	d=p.d();
		scalar  rho=p.rho();
                vector 	xyz=p.position();

                this->owner().patchData(p, pp, trackFraction, tetIs, nw, Up);

		const fvMesh& mesh   = this->owner().mesh();
		
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


		//Bounding between 0 and 1
	    	Sp = max(Sp,0.0);
	    	Sp = min(Sp,1.0);


		//Metropolis selection: random number (uniform value between 0 and 1) 



		Info << "position of the particle" << xyz ;
		Info << "Sticking Probability of the  particle" << Sp;

		p.active(true);
        	label fI = pp.whichFace(p.face());

		// Need to find the global face label in order to transform it into another
		// patch. 

		label globalFaceId = pp.start() + fI;


		//HardCoded patch for erosion/deposition
		label patchID = mesh.boundaryMesh().findPatchID("Blade");
		
		Info << "The particle which diameter is" << d << endl;
		Info << "Hits face" << fI << endl;

		
		labelList	facePoints = mesh.boundaryMesh()[patchID].localFaces()[fI];

		// Displacement is defined in such a way that the volume is conserved
		// faceAreas returns a vector, to transform it in a scalar

		Info << "Points of Face" << fI << "\t gathered"<< endl;

		//need a seed for random number generation to be different for
		//every time step

		int 	seed = mesh.time().value()*Un*79247319;
		Info << "dummyValue Created: seed " << seed << endl;
		Random  dum(seed);
		const scalar dummy(dum.scalar01());


		// the entity of the displacement depends on wether the particles sticks or not.
		// pointer allocation is the same for all the cases, and it will be done here
		// not to rewrite the code 3 times

		//Reference to the location of pointDisplacement field
		//pointVectorField& PointDisplacement= const_cast<pointVectorField&>
		//(
		//	mesh.lookupObject<pointVectorField>("pointDisplacement")
		//);

		////Get the vectorField of the patch
		//vectorField 	&pDisp=refCast<vectorField>(PointDisplacement.boundaryField()[patchID]);

		////Relevant size of the vector and declare a vectorField of the same dimensions:
		//int	Psize=pDisp.size();
	
		//vectorField dispVals(Psize);

		////Create a pointer equal to PointDisplacement
		//vectorField	&PointPointer = refCast<vectorField>(PointDisplacement.boundaryField()[patchID]);


		//vectorField	PointNormalVector= mesh.boundaryMesh()[patchID].pointNormals();



		//forAll (dispVals,index)
		//{
		//	
		//	dispVals[index].x()=PointPointer[index].x(); 
		//	dispVals[index].y()=PointPointer[index].y();
		//	dispVals[index].z()=PointPointer[index].z();

		//}
	
		//Particle sticks
		if ((dummy <= Sp ) && (Sp>0.0))
		{

	           U = vector::zero;
		   Info << "point" << facePoints[0] << "	" << "\n" ;
//		   Info << "normal vector" << PointNormalVector[facePoints[0]] << "\n";
		  

		   // It will grow the vertex closer to the impact point

		   pointField  points=pp.localPoints();

// 		   scalarField	distList(facePoints.size());

		   Info << "position	 "<< xyz<< endl;

//		   label nodeNumber	=0;

 	 	   //Pass to the porosity part

		   #include "depositAge.H"

//              	    Info << "minimum distance   "	<< distList[0] << "node   "<< facePoints[nodeNumber];
//
//		    Info << "coordinate of point chosen" << points[facePoints[nodeNumber]];

		    // Displacement: In case of cold deposition there is not a spread of the particle
		    // on the cell. By the moment the displacement is still tought of as for conserving
		    // the volume when the spread equals the cell size

//		    #include"baseArea.H"

//		    vector normalPoints = pp.pointNormals()[facePoints[nodeNumber]];
//              	    Info << "Area computed and point normal evaluated "	<< PointNormalVector[facePoints[nodeNumber]] << "node   "<< facePoints[nodeNumber];

//		    scalar dh;
//
//		    dh=p.mass()/rho/baseArea*3;
//
//		    Info << " displacement evaluated:\t "<< dh << endl ;
//		    
//		     
//		    // The sign - because the normal vector points outward the surface.
//		    dx=-PointNormalVector[facePoints[nodeNumber]].x()*dh;
//		    dy=-PointNormalVector[facePoints[nodeNumber]].y()*dh;
//		    dz=-PointNormalVector[facePoints[nodeNumber]].z()*dh;
//
//                    Info << " normal displacement  evaluated:\t "<< dx <<"\t"<< dy <<"\t" <<dz    << endl ;
// 
//
//		    dispVals[facePoints[nodeNumber]].x()+=dx; 
//		    dispVals[facePoints[nodeNumber]].y()+=dy;
//		    dispVals[facePoints[nodeNumber]].z()+=dz;
//		   
//                    Info << " value passed to the pointer "<< dispVals[facePoints[nodeNumber]]  << endl ;
//
//		    //Pass the value to pointDisplacement boundary field
//		    //the update of the values is done only at the end.
//		    PointDisplacement.boundaryField()[patchID]==dispVals; 

		    label fI = pp.whichFace(p.face());
//                        label pI = pp.index();
//                      label patchID = mesh.boundaryMesh().findPatchID(patchData_[patchI].patchName());
                    label patchID = mesh.boundaryMesh().findPatchID("blade");

                    Info << "The particle which diameter is" << d << endl;
                    Info << "Sticks to face" << fI << endl;

                    labelList        facePoints = mesh.boundaryMesh()[patchID].localFaces()[fI];

                //      labelList               IDpoints =   mesh.boundaryMesh()[patchID].meshPoints();

                // I'll deffine the displacement in such a way that the volume is conserved
                // faceAreas returns a vector, I must transform it in a scalar
                    vector   areaV;
 
                    areaV=mesh.boundaryMesh()[patchID].faceAreas()[fI];
 
                    scalar  area;
 
                    area= mag(areaV);
 
                // displacement
                        scalar dh;



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
                    vectorField     &pDisp=refCast<vectorField>(PointDisplacement.boundaryField()[patchID]);

                //Relevant size of the vector and declare a vectorField of the same dimensions:
                    int     Psize=pDisp.size();

                    vectorField dispVals(Psize);

                //Create a pointer equal to PointDisplacement
                    vectorField     &PointPointer = refCast<vectorField>(PointDisplacement.boundaryField()[patchID]);


                    vectorField     PointNormalVector= mesh.boundaryMesh()[patchID].pointNormals();

                    Info << "ispVals assingement" << endl;

                    forAll (dispVals,index)
                    {


                            dispVals[index].x()=PointPointer[index].x();
                            dispVals[index].y()=PointPointer[index].y();
                            dispVals[index].z()=PointPointer[index].z();

                    }

		    forAll (facePoints,index)
                    {

                                Info << "point" << facePoints[index] << "       " << "\n" ;
//                              Info << "ID" << IDpoints[facePoints[index]] << "        " << "\n" ;
        //                      Info << "index" << mesh.findNearestCell(xyz)<< "        " << "\n" ;
        //                      label id = mesh.findCell(xyz);

                                Info << "normal vector" << PointNormalVector[facePoints[index]] << "\n";

                                        dispVals[facePoints[index]].x()+=dx;
                                        dispVals[facePoints[index]].y()+=dy;
                                        dispVals[facePoints[index]].z()+=dz;

                                Info << "displacement" << dispVals[facePoints[index]] << "\n";


                    }


                    //Pass the value to pointDisplacement boundary field
                    PointDisplacement.boundaryField()[patchID]==dispVals;


		    // Write down the height of the deposit in oder to make it easier to read the height

		    scalar faceHeight =  0.;

		    forAll(facePoints,index)
		    {

			faceHeight += mag(dispVals[facePoints[index]]);
			
		    }

		    faceHeight = faceHeight/4;

		    std::string infileName14 = "Height" + std::to_string(globalFaceId) ;

		    std::string outfileName14 = "Height" + std::to_string(globalFaceId) + ".tmp" ;
		    ofstream outfile14(infileName14.c_str()) ;
		    
		    outfile14  << faceHeight ;
		    outfile14.close() ;
		    
		    remove( infileName14.c_str());
		    rename( outfileName14.c_str(),infileName14.c_str());

            	    nStick_[patchI]++;
	            massStick_[patchI] += dm;
	            if (writeFields_)
	            {
	                label pI = pp.index();
	                label fI = pp.whichFace(p.face());
	                massStick().boundaryField()[pI][fI] += dm;
	            }
	
                p.active(false);
//	            break;
		}

		
		//Particle Rebound 
		if ((dummy >  Sp ) && (Sp>0) && (Un >0))
		{
	                p.active(true);
			Info << "The particle which diameter is" << d << endl;
			Info << "Hits the face" << fI << " and don't stick" << endl;
	
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

		// All the non-considered cases:rebound
		//else
		//{
            
                //active = true;


                //if ((Un >= 0) |  (Sp>0))
                //{
                //    U -= (1.0 + patchData_[patchI].e())*Un*nw;
                //}

                //U -= patchData_[patchI].mu()*Ut;

                //// Return velocity to global space
                //U += Up;

                //break;
		//}

            break;
            }

/******************************************************************************/

            case PatchInteractionModel<CloudType>::itRebound:
            {
                keepParticle = true;
                p.active(true);

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
                    "bool sintering<CloudType>::correct"
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
void Foam::sintering<CloudType>::info(Ostream& os)
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
