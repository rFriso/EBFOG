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

#include "fouling.H"
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
Foam::fouling<CloudType>::fouling
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
            FatalErrorIn("fouling(const dictionary&, CloudType&)")
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
Foam::fouling<CloudType>::fouling
(
    const fouling<CloudType>& pim
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
Foam::fouling<CloudType>::~fouling()
{}


// * * * * * * * * * * * * * * Member Functions  * * * * * * * * * * * * * * //

template<class CloudType>
Foam::volScalarField& Foam::fouling<CloudType>::massEscape()
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
Foam::volScalarField& Foam::fouling<CloudType>::massStick()
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
bool Foam::fouling<CloudType>::correct
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
                    massEscape().boundaryFieldRef()[pI][fI] += dm;
                }
                break;
            }
            case PatchInteractionModel<CloudType>::itStick:
            {

//	 	Pout << "Particle Hitting the surface\n" << endl;

                scalar dm = p.mass()*p.nParticle();
                keepParticle = true;

		scalar  A  = 0.897;
		scalar  C1 = 2.51e-5;
		scalar  C2 = 3026.975;

		scalar  T   = p.T();
//	 	Pout << "Tcond"<< Tcond << "\n" << endl;
                vector  nw;
                vector  Up;
                scalar  dx,dy,dz;
                scalar 	d=p.d();
				scalar  rho=p.rho();
                vector 	xyz=p.position();
		scalar  Sp;
                this->owner().patchData(p, pp, trackFraction, tetIs, nw, Up);

		const fvMesh& mesh   = this->owner().mesh();
		
                // Calculate motion relative to patch velocity
                U -= Up;

                scalar Un = U & nw;
                vector Ut = U - Un*nw;
		
                    label fI = pp.whichFace(p.face());


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


//                Random  rndGen.scalar01(Sp/2.0*1.0*Sp*1234567.0);
				Random&  rnd=this->owner().rndGen();
				scalar   dum=rnd.sample01<scalar>();



                if ((dum <= Sp ) && (Sp>0.0))
		{


			// Need to find the global face label in order to transform it into another
			// patch. 

			label globalFaceId = pp.start() + fI;


			//HardCoded patch for erosion/deposition
			label patchID = mesh.boundaryMesh().findPatchID("blade");

			Pout << "The particle with temperature" << T << endl;
			Pout << "sticks to face" << fI << endl;

			//need a seed for random number generation to be different for
			//every time step

			//int 	seed = mesh.time().value()*Un*79247319;
			//Info << "dummyValue Created: seed " << seed << endl;
			//const scalar dummy(dum.scalar01());
			#include "Displacement.H"
			
			#include "MeshGrowth.H"


			


			if (Sp>0.01)
			{
			std::ofstream outfile;
			outfile.open("Sticking_Statistics.txt", std::ios_base::app);
  			outfile << p.origId() << "\t" <<1 << "\t"  << xyz.x() << "\t" << xyz.y() << "\t" << xyz.z() << "\t" 
				<< p.T() << "\t" << Un << "\t" << U.x() << "\t" << U.y() << "\t" << U.z() 
				<< "\t" << p.d() << "\t" << nw.x() << "\t" << nw.y() << "\t" << nw.z() << "\t" << Sp << "\n" ; 
			outfile.close();
			}
           		U = vector::zero;
   	    		nStick_[patchI]++;
            		massStick_[patchI] += dm;
            		if (writeFields_)
            		{
            		    label pI = pp.index();
            		    label fI = pp.whichFace(p.face());
            		    massStick().boundaryFieldRef()[pI][fI] += dm;
            		}

        		p.active(false);
            		break;
		}
	 	else	
		{
		        p.active(true);
			if (Un >= 0)
	        	{
	        	    U -= (1.0 + patchData_[patchI].e())*Un*nw;
//	        	    U -= 1.0 *Un*nw;
	        	}

	        	//U -= patchData_[patchI].mu()*Ut;
	        	U -= patchData_[patchI].mu()*Ut;

	        	// Return velocity to global space
	        	U += Up;


			if (Sp>0.01)
			{
			std::ofstream outfile;

                        outfile.open("Sticking_Statistics.txt", std::ios_base::app);
                        outfile << p.origId() << "\t"  << 0 << "\t" << xyz.x() << "\t" << xyz.y() << "\t" << xyz.z() << "\t"
                                << p.T() << "\t" << Un << "\t" << U.x() << "\t" << U.y() << "\t" << U.z()
                                << "\t" << p.d() << "\t" << nw.x() << "\t" << nw.y() << "\t" << nw.z() << "\t" << Sp << "\n" ;

                        outfile.close();
			}
		}
    		break;

    		}

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


//				string patchName = pp.name();	
//				if ((patchName == "WALL_UP") || (patchName == "WALL_DOWN"))
//				{
//				std::ofstream outfile;
//
//			  	outfile.open("endwall_rebound.txt", std::ios_base::app);
//  				outfile << "Data" << "\t" << p.origId() << "\t" << p.T() << "\t" << Un << "\t" << Ut.x() << "\t" << Ut.y() << "\t" << Ut.z() << "\t" << p.d() << "\n" ;
//				outfile.close(); 
//				}
//

                break;
            }
            default:
            {
                FatalErrorIn
                (
                    "bool fouling<CloudType>::correct"
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
void Foam::fouling<CloudType>::info(Ostream& os)
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

    if (this->writeTime())
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
