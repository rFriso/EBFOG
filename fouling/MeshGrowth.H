labelList       facePoints = mesh.boundaryMesh()[patchID].localFaces()[fI];

pointVectorField &PointDisplacement=    const_cast<pointVectorField&>(mesh.lookupObject<pointVectorField>("pointDisplacement"));

//Get the vectorField of the patch
//ctorField     &pDisp=refCast<vectorField>(PointDisplacement.boundaryField()[patchID]);

//Relevant size of the vector and declare a vectorField of the same dimensions:
//int Psize=pDisp.size();
//
//vectorField dispVals(Psize);
//
//Create a pointer equal to PointDisplacement
vectorField &PointPointer = refCast<vectorField>(PointDisplacement.boundaryFieldRef()[patchID]);

//vectorField PointNormalVector= mesh.boundaryMesh()[patchID].pointNormals();

//forAll (dispVals,index)
//{
//    dispVals[index].x()=PointPointer[index].x();
//    dispVals[index].y()=PointPointer[index].y();
//    dispVals[index].z()=PointPointer[index].z();
//
//}

forAll (facePoints,index)
{
	Info << "point" << facePoints[index] << "   " << "\n" ;
//	Info << "normal vector" << PointNormalVector[facePoints[index]] << "\n";

    PointPointer[facePoints[index]].x()+=dx;
    PointPointer[facePoints[index]].y()+=dy;
    PointPointer[facePoints[index]].z()+=dz;

//	Info << "displacement" << PointDisplacement.boundaryField()[patchID[facePoints[index]]] << "\n";
}

PointDisplacement.boundaryFieldRef()[patchID] = PointPointer;


