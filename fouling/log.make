wmake libso (synbiose2)
wmakeLnInclude: linking include files to ./lnInclude
Making dependency list for source file synbiose2.C
g++ -std=c++11 -m64 -DOPENFOAM_PLUS=1712 -Dlinux64 -DWM_ARCH_OPTION=64 -DWM_DP -DWM_LABEL_SIZE=32 -Wall -Wextra -Wold-style-cast -Wnon-virtual-dtor -Wno-unused-parameter -Wno-invalid-offsetof -Wno-attributes -O3  -DNoRepository -ftemplate-depth-100 -I/home/software/OpenFOAM/OpenFOAM-v1712/src/lagrangian/basic/lnInclude -I/home/software/OpenFOAM/OpenFOAM-v1712/src/lagrangian/intermediate/lnInclude -I/home/software/OpenFOAM/OpenFOAM-v1712/src/lagrangian/distributionModels/lnInclude -I/home/software/OpenFOAM/OpenFOAM-v1712/src/transportModels/compressible/lnInclude -I/home/software/OpenFOAM/OpenFOAM-v1712/src/thermophysicalModels/specie/lnInclude -I/home/software/OpenFOAM/OpenFOAM-v1712/src/thermophysicalModels/basic/lnInclude -I/home/software/OpenFOAM/OpenFOAM-v1712/src/thermophysicalModels/thermophysicalProperties/lnInclude -I/home/software/OpenFOAM/OpenFOAM-v1712/src/thermophysicalModels/reactionThermo/lnInclude -I/home/software/OpenFOAM/OpenFOAM-v1712/src/thermophysicalModels/SLGThermo/lnInclude -I/home/software/OpenFOAM/OpenFOAM-v1712/src/thermophysicalModels/radiation/lnInclude -I/home/software/OpenFOAM/OpenFOAM-v1712/src/transportModels -I/home/software/OpenFOAM/OpenFOAM-v1712/src/regionModels/regionModel/lnInclude -I/home/software/OpenFOAM/OpenFOAM-v1712/src/regionModels/surfaceFilmModels/lnInclude -I/home/software/OpenFOAM/OpenFOAM-v1712/src/dynamicMesh/lnInclude -I/home/software/OpenFOAM/OpenFOAM-v1712/src/dynamicFvMesh/lnInclude -I/home/software/OpenFOAM/OpenFOAM-v1712/src/sampling/lnInclude -I/home/software/OpenFOAM/OpenFOAM-v1712/src/surfMesh/lnInclude -I/home/software/OpenFOAM/OpenFOAM-v1712/src/finiteVolume/lnInclude -I/home/software/OpenFOAM/OpenFOAM-v1712/src/meshTools/lnInclude -IlnInclude -I. -I/home/software/OpenFOAM/OpenFOAM-v1712/src/OpenFOAM/lnInclude -I/home/software/OpenFOAM/OpenFOAM-v1712/src/OSspecific/POSIX/lnInclude   -fPIC -c synbiose2.C -o Make/linux64GccDPInt32Opt/./synbiose2.o
In file included from /home/software/OpenFOAM/OpenFOAM-v1712/src/finiteVolume/lnInclude/fvMesh.H:58:0,
                 from /home/software/OpenFOAM/OpenFOAM-v1712/src/lagrangian/intermediate/lnInclude/PatchInteractionModel.C:27,
                 from /home/software/OpenFOAM/OpenFOAM-v1712/src/lagrangian/intermediate/lnInclude/PatchInteractionModel.H:222,
                 from synbiose2.H:35,
                 from synbiose2.C:26:
/home/software/OpenFOAM/OpenFOAM-v1712/src/OpenFOAM/lnInclude/DimensionedField.H: In instantiation of ‘class Foam::DimensionedField<Foam::Vector<double>, Foam::pointMesh>’:
/home/software/OpenFOAM/OpenFOAM-v1712/src/OpenFOAM/lnInclude/GeometricField.H:81:7:   required from ‘class Foam::GeometricField<Foam::Vector<double>, Foam::pointPatchField, Foam::pointMesh>’
MeshGrowth.H:14:72:   required from here
/home/software/OpenFOAM/OpenFOAM-v1712/src/OpenFOAM/lnInclude/DimensionedField.H:84:40: error: invalid use of incomplete type ‘class Foam::pointMesh’
         typedef typename GeoMesh::Mesh Mesh;
                                        ^
In file included from /home/software/OpenFOAM/OpenFOAM-v1712/src/finiteVolume/lnInclude/fvMesh.H:61:0,
                 from /home/software/OpenFOAM/OpenFOAM-v1712/src/lagrangian/intermediate/lnInclude/PatchInteractionModel.C:27,
                 from /home/software/OpenFOAM/OpenFOAM-v1712/src/lagrangian/intermediate/lnInclude/PatchInteractionModel.H:222,
                 from synbiose2.H:35,
                 from synbiose2.C:26:
/home/software/OpenFOAM/OpenFOAM-v1712/src/OpenFOAM/lnInclude/pointFieldsFwd.H:46:7: error: forward declaration of ‘class Foam::pointMesh’
 class pointMesh;
       ^
In file included from /home/software/OpenFOAM/OpenFOAM-v1712/src/OpenFOAM/lnInclude/DimensionedField.H:398:0,
                 from /home/software/OpenFOAM/OpenFOAM-v1712/src/finiteVolume/lnInclude/fvMesh.H:58,
                 from /home/software/OpenFOAM/OpenFOAM-v1712/src/lagrangian/intermediate/lnInclude/PatchInteractionModel.C:27,
                 from /home/software/OpenFOAM/OpenFOAM-v1712/src/lagrangian/intermediate/lnInclude/PatchInteractionModel.H:222,
                 from synbiose2.H:35,
                 from synbiose2.C:26:
/home/software/OpenFOAM/OpenFOAM-v1712/src/OpenFOAM/lnInclude/DimensionedFieldI.H:38:1: error: invalid use of incomplete type ‘class Foam::pointMesh’
 Foam::DimensionedField<Type, GeoMesh>::mesh() const
 ^
In file included from /home/software/OpenFOAM/OpenFOAM-v1712/src/finiteVolume/lnInclude/fvMesh.H:61:0,
                 from /home/software/OpenFOAM/OpenFOAM-v1712/src/lagrangian/intermediate/lnInclude/PatchInteractionModel.C:27,
                 from /home/software/OpenFOAM/OpenFOAM-v1712/src/lagrangian/intermediate/lnInclude/PatchInteractionModel.H:222,
                 from synbiose2.H:35,
                 from synbiose2.C:26:
/home/software/OpenFOAM/OpenFOAM-v1712/src/OpenFOAM/lnInclude/pointFieldsFwd.H:46:7: error: forward declaration of ‘class Foam::pointMesh’
 class pointMesh;
       ^
In file included from /home/software/OpenFOAM/OpenFOAM-v1712/src/OpenFOAM/lnInclude/GeometricScalarField.H:38:0,
                 from /home/software/OpenFOAM/OpenFOAM-v1712/src/OpenFOAM/lnInclude/GeometricFields.H:34,
                 from /home/software/OpenFOAM/OpenFOAM-v1712/src/finiteVolume/lnInclude/volFields.H:37,
                 from /home/software/OpenFOAM/OpenFOAM-v1712/src/lagrangian/intermediate/lnInclude/PatchInteractionModel.C:29,
                 from /home/software/OpenFOAM/OpenFOAM-v1712/src/lagrangian/intermediate/lnInclude/PatchInteractionModel.H:222,
                 from synbiose2.H:35,
                 from synbiose2.C:26:
/home/software/OpenFOAM/OpenFOAM-v1712/src/OpenFOAM/lnInclude/GeometricField.H: In instantiation of ‘class Foam::GeometricField<Foam::Vector<double>, Foam::pointPatchField, Foam::pointMesh>’:
MeshGrowth.H:14:72:   required from here
/home/software/OpenFOAM/OpenFOAM-v1712/src/OpenFOAM/lnInclude/GeometricField.H:99:40: error: invalid use of incomplete type ‘class Foam::pointMesh’
         typedef typename GeoMesh::Mesh Mesh;
                                        ^
In file included from /home/software/OpenFOAM/OpenFOAM-v1712/src/finiteVolume/lnInclude/fvMesh.H:61:0,
                 from /home/software/OpenFOAM/OpenFOAM-v1712/src/lagrangian/intermediate/lnInclude/PatchInteractionModel.C:27,
                 from /home/software/OpenFOAM/OpenFOAM-v1712/src/lagrangian/intermediate/lnInclude/PatchInteractionModel.H:222,
                 from synbiose2.H:35,
                 from synbiose2.C:26:
/home/software/OpenFOAM/OpenFOAM-v1712/src/OpenFOAM/lnInclude/pointFieldsFwd.H:46:7: error: forward declaration of ‘class Foam::pointMesh’
 class pointMesh;
       ^
In file included from /home/software/OpenFOAM/OpenFOAM-v1712/src/OpenFOAM/lnInclude/GeometricScalarField.H:38:0,
                 from /home/software/OpenFOAM/OpenFOAM-v1712/src/OpenFOAM/lnInclude/GeometricFields.H:34,
                 from /home/software/OpenFOAM/OpenFOAM-v1712/src/finiteVolume/lnInclude/volFields.H:37,
                 from /home/software/OpenFOAM/OpenFOAM-v1712/src/lagrangian/intermediate/lnInclude/PatchInteractionModel.C:29,
                 from /home/software/OpenFOAM/OpenFOAM-v1712/src/lagrangian/intermediate/lnInclude/PatchInteractionModel.H:222,
                 from synbiose2.H:35,
                 from synbiose2.C:26:
/home/software/OpenFOAM/OpenFOAM-v1712/src/OpenFOAM/lnInclude/GeometricField.H:103:48: error: invalid use of incomplete type ‘class Foam::pointMesh’
         typedef typename GeoMesh::BoundaryMesh BoundaryMesh;
                                                ^
In file included from /home/software/OpenFOAM/OpenFOAM-v1712/src/finiteVolume/lnInclude/fvMesh.H:61:0,
                 from /home/software/OpenFOAM/OpenFOAM-v1712/src/lagrangian/intermediate/lnInclude/PatchInteractionModel.C:27,
                 from /home/software/OpenFOAM/OpenFOAM-v1712/src/lagrangian/intermediate/lnInclude/PatchInteractionModel.H:222,
                 from synbiose2.H:35,
                 from synbiose2.C:26:
/home/software/OpenFOAM/OpenFOAM-v1712/src/OpenFOAM/lnInclude/pointFieldsFwd.H:46:7: error: forward declaration of ‘class Foam::pointMesh’
 class pointMesh;
       ^
In file included from synbiose2.C:289:0,
                 from synbiose2.H:146,
                 from synbiose2.C:26:
MeshGrowth.H: In member function ‘virtual bool Foam::synbiose2<CloudType>::correct(typename CloudType::parcelType&, const Foam::polyPatch&, bool&, Foam::scalar, const Foam::tetIndices&)’:
MeshGrowth.H:38:47: error: no match for ‘operator==’ (operand types are ‘Foam::pointPatchField<Foam::Vector<double> >’ and ‘Foam::vectorField {aka Foam::Field<Foam::Vector<double> >}’)
 PointDisplacement.boundaryFieldRef()[patchID] == PointPointer;
                                               ^
MeshGrowth.H:38:47: note: candidates are:
In file included from /home/software/OpenFOAM/OpenFOAM-v1712/src/OpenFOAM/lnInclude/objectMap.H:115:0,
                 from /home/software/OpenFOAM/OpenFOAM-v1712/src/OpenFOAM/lnInclude/mapPolyMesh.H:143,
                 from /home/software/OpenFOAM/OpenFOAM-v1712/src/finiteVolume/lnInclude/MRFZone.H:50,
                 from /home/software/OpenFOAM/OpenFOAM-v1712/src/finiteVolume/lnInclude/MRFZoneList.H:41,
                 from /home/software/OpenFOAM/OpenFOAM-v1712/src/finiteVolume/lnInclude/IOMRFZoneList.H:56,
                 from /home/software/OpenFOAM/OpenFOAM-v1712/src/finiteVolume/lnInclude/constrainPressure.H:39,
                 from /home/software/OpenFOAM/OpenFOAM-v1712/src/finiteVolume/lnInclude/fvCFD.H:19,
                 from synbiose2.C:30,
                 from synbiose2.H:146,
                 from synbiose2.C:26:
/home/software/OpenFOAM/OpenFOAM-v1712/src/OpenFOAM/lnInclude/objectMapI.H:93:13: note: bool Foam::operator==(const Foam::objectMap&, const Foam::objectMap&)
 inline bool operator==(const objectMap& a, const objectMap& b)
             ^
/home/software/OpenFOAM/OpenFOAM-v1712/src/OpenFOAM/lnInclude/objectMapI.H:93:13: note:   no known conversion for argument 1 from ‘Foam::pointPatchField<Foam::Vector<double> >’ to ‘const Foam::objectMap&’
In file included from /home/software/OpenFOAM/OpenFOAM-v1712/src/finiteVolume/lnInclude/fvMatrix.H:1090:0,
                 from /home/software/OpenFOAM/OpenFOAM-v1712/src/finiteVolume/lnInclude/ddtScheme.C:29,
                 from /home/software/OpenFOAM/OpenFOAM-v1712/src/finiteVolume/lnInclude/ddtScheme.H:351,
                 from /home/software/OpenFOAM/OpenFOAM-v1712/src/finiteVolume/lnInclude/fvcDdt.C:28,
                 from /home/software/OpenFOAM/OpenFOAM-v1712/src/finiteVolume/lnInclude/fvcDdt.H:205,
                 from /home/software/OpenFOAM/OpenFOAM-v1712/src/finiteVolume/lnInclude/fvc.H:44,
                 from /home/software/OpenFOAM/OpenFOAM-v1712/src/finiteVolume/lnInclude/fvCFD.H:8,
                 from synbiose2.C:30,
                 from synbiose2.H:146,
                 from synbiose2.C:26:
/home/software/OpenFOAM/OpenFOAM-v1712/src/finiteVolume/lnInclude/fvMatrix.C:1632:33: note: template<class Type> Foam::tmp<Foam::fvMatrix<Type> > Foam::operator==(const Foam::tmp<Foam::fvMatrix<Type> >&, const Foam::zero&)
 Foam::tmp<Foam::fvMatrix<Type>> Foam::operator==
                                 ^
/home/software/OpenFOAM/OpenFOAM-v1712/src/finiteVolume/lnInclude/fvMatrix.C:1632:33: note:   template argument deduction/substitution failed:
In file included from synbiose2.C:289:0,
                 from synbiose2.H:146,
                 from synbiose2.C:26:
MeshGrowth.H:38:50: note:   ‘Foam::pointPatchField<Foam::Vector<double> >’ is not derived from ‘const Foam::tmp<Foam::fvMatrix<Type> >’
 PointDisplacement.boundaryFieldRef()[patchID] == PointPointer;
                                                  ^
In file included from /home/software/OpenFOAM/OpenFOAM-v1712/src/finiteVolume/lnInclude/fvMatrix.H:1090:0,
                 from /home/software/OpenFOAM/OpenFOAM-v1712/src/finiteVolume/lnInclude/ddtScheme.C:29,
                 from /home/software/OpenFOAM/OpenFOAM-v1712/src/finiteVolume/lnInclude/ddtScheme.H:351,
                 from /home/software/OpenFOAM/OpenFOAM-v1712/src/finiteVolume/lnInclude/fvcDdt.C:28,
                 from /home/software/OpenFOAM/OpenFOAM-v1712/src/finiteVolume/lnInclude/fvcDdt.H:205,
                 from /home/software/OpenFOAM/OpenFOAM-v1712/src/finiteVolume/lnInclude/fvc.H:44,
                 from /home/software/OpenFOAM/OpenFOAM-v1712/src/finiteVolume/lnInclude/fvCFD.H:8,
                 from synbiose2.C:30,
                 from synbiose2.H:146,
                 from synbiose2.C:26:
/home/software/OpenFOAM/OpenFOAM-v1712/src/finiteVolume/lnInclude/fvMatrix.C:1621:33: note: template<class Type> Foam::tmp<Foam::fvMatrix<Type> > Foam::operator==(const Foam::fvMatrix<Type>&, const Foam::zero&)
 Foam::tmp<Foam::fvMatrix<Type>> Foam::operator==
                                 ^
/home/software/OpenFOAM/OpenFOAM-v1712/src/finiteVolume/lnInclude/fvMatrix.C:1621:33: note:   template argument deduction/substitution failed:
In file included from synbiose2.C:289:0,
                 from synbiose2.H:146,
                 from synbiose2.C:26:
MeshGrowth.H:38:50: note:   ‘Foam::pointPatchField<Foam::Vector<double> >’ is not derived from ‘const Foam::fvMatrix<Type>’
 PointDisplacement.boundaryFieldRef()[patchID] == PointPointer;
                                                  ^
In file included from /home/software/OpenFOAM/OpenFOAM-v1712/src/finiteVolume/lnInclude/fvMatrix.H:1090:0,
                 from /home/software/OpenFOAM/OpenFOAM-v1712/src/finiteVolume/lnInclude/ddtScheme.C:29,
                 from /home/software/OpenFOAM/OpenFOAM-v1712/src/finiteVolume/lnInclude/ddtScheme.H:351,
                 from /home/software/OpenFOAM/OpenFOAM-v1712/src/finiteVolume/lnInclude/fvcDdt.C:28,
                 from /home/software/OpenFOAM/OpenFOAM-v1712/src/finiteVolume/lnInclude/fvcDdt.H:205,
                 from /home/software/OpenFOAM/OpenFOAM-v1712/src/finiteVolume/lnInclude/fvc.H:44,
                 from /home/software/OpenFOAM/OpenFOAM-v1712/src/finiteVolume/lnInclude/fvCFD.H:8,
                 from synbiose2.C:30,
                 from synbiose2.H:146,
                 from synbiose2.C:26:
/home/software/OpenFOAM/OpenFOAM-v1712/src/finiteVolume/lnInclude/fvMatrix.C:1608:33: note: template<class Type> Foam::tmp<Foam::fvMatrix<Type> > Foam::operator==(const Foam::tmp<Foam::fvMatrix<Type> >&, const Foam::dimensioned<Type>&)
 Foam::tmp<Foam::fvMatrix<Type>> Foam::operator==
                                 ^
/home/software/OpenFOAM/OpenFOAM-v1712/src/finiteVolume/lnInclude/fvMatrix.C:1608:33: note:   template argument deduction/substitution failed:
In file included from synbiose2.C:289:0,
                 from synbiose2.H:146,
                 from synbiose2.C:26:
MeshGrowth.H:38:50: note:   ‘Foam::pointPatchField<Foam::Vector<double> >’ is not derived from ‘const Foam::tmp<Foam::fvMatrix<Type> >’
 PointDisplacement.boundaryFieldRef()[patchID] == PointPointer;
                                                  ^
In file included from /home/software/OpenFOAM/OpenFOAM-v1712/src/finiteVolume/lnInclude/fvMatrix.H:1090:0,
                 from /home/software/OpenFOAM/OpenFOAM-v1712/src/finiteVolume/lnInclude/ddtScheme.C:29,
                 from /home/software/OpenFOAM/OpenFOAM-v1712/src/finiteVolume/lnInclude/ddtScheme.H:351,
                 from /home/software/OpenFOAM/OpenFOAM-v1712/src/finiteVolume/lnInclude/fvcDdt.C:28,
                 from /home/software/OpenFOAM/OpenFOAM-v1712/src/finiteVolume/lnInclude/fvcDdt.H:205,
                 from /home/software/OpenFOAM/OpenFOAM-v1712/src/finiteVolume/lnInclude/fvc.H:44,
                 from /home/software/OpenFOAM/OpenFOAM-v1712/src/finiteVolume/lnInclude/fvCFD.H:8,
                 from synbiose2.C:30,
                 from synbiose2.H:146,
                 from synbiose2.C:26:
/home/software/OpenFOAM/OpenFOAM-v1712/src/finiteVolume/lnInclude/fvMatrix.C:1595:33: note: template<class Type> Foam::tmp<Foam::fvMatrix<Type> > Foam::operator==(const Foam::fvMatrix<Type>&, const Foam::dimensioned<Type>&)
 Foam::tmp<Foam::fvMatrix<Type>> Foam::operator==
                                 ^
/home/software/OpenFOAM/OpenFOAM-v1712/src/finiteVolume/lnInclude/fvMatrix.C:1595:33: note:   template argument deduction/substitution failed:
In file included from synbiose2.C:289:0,
                 from synbiose2.H:146,
                 from synbiose2.C:26:
MeshGrowth.H:38:50: note:   ‘Foam::pointPatchField<Foam::Vector<double> >’ is not derived from ‘const Foam::fvMatrix<Type>’
 PointDisplacement.boundaryFieldRef()[patchID] == PointPointer;
                                                  ^
In file included from /home/software/OpenFOAM/OpenFOAM-v1712/src/finiteVolume/lnInclude/fvMatrix.H:1090:0,
                 from /home/software/OpenFOAM/OpenFOAM-v1712/src/finiteVolume/lnInclude/ddtScheme.C:29,
                 from /home/software/OpenFOAM/OpenFOAM-v1712/src/finiteVolume/lnInclude/ddtScheme.H:351,
                 from /home/software/OpenFOAM/OpenFOAM-v1712/src/finiteVolume/lnInclude/fvcDdt.C:28,
                 from /home/software/OpenFOAM/OpenFOAM-v1712/src/finiteVolume/lnInclude/fvcDdt.H:205,
                 from /home/software/OpenFOAM/OpenFOAM-v1712/src/finiteVolume/lnInclude/fvc.H:44,
                 from /home/software/OpenFOAM/OpenFOAM-v1712/src/finiteVolume/lnInclude/fvCFD.H:8,
                 from synbiose2.C:30,
                 from synbiose2.H:146,
                 from synbiose2.C:26:
/home/software/OpenFOAM/OpenFOAM-v1712/src/finiteVolume/lnInclude/fvMatrix.C:1581:33: note: template<class Type> Foam::tmp<Foam::fvMatrix<Type> > Foam::operator==(const Foam::tmp<Foam::fvMatrix<Type> >&, const Foam::tmp<Foam::GeometricField<Type, Foam::fvPatchField, Foam::volMesh> >&)
 Foam::tmp<Foam::fvMatrix<Type>> Foam::operator==
                                 ^
/home/software/OpenFOAM/OpenFOAM-v1712/src/finiteVolume/lnInclude/fvMatrix.C:1581:33: note:   template argument deduction/substitution failed:
In file included from synbiose2.C:289:0,
                 from synbiose2.H:146,
                 from synbiose2.C:26:
MeshGrowth.H:38:50: note:   ‘Foam::pointPatchField<Foam::Vector<double> >’ is not derived from ‘const Foam::tmp<Foam::fvMatrix<Type> >’
 PointDisplacement.boundaryFieldRef()[patchID] == PointPointer;
                                                  ^
In file included from /home/software/OpenFOAM/OpenFOAM-v1712/src/finiteVolume/lnInclude/fvMatrix.H:1090:0,
                 from /home/software/OpenFOAM/OpenFOAM-v1712/src/finiteVolume/lnInclude/ddtScheme.C:29,
                 from /home/software/OpenFOAM/OpenFOAM-v1712/src/finiteVolume/lnInclude/ddtScheme.H:351,
                 from /home/software/OpenFOAM/OpenFOAM-v1712/src/finiteVolume/lnInclude/fvcDdt.C:28,
                 from /home/software/OpenFOAM/OpenFOAM-v1712/src/finiteVolume/lnInclude/fvcDdt.H:205,
                 from /home/software/OpenFOAM/OpenFOAM-v1712/src/finiteVolume/lnInclude/fvc.H:44,
                 from /home/software/OpenFOAM/OpenFOAM-v1712/src/finiteVolume/lnInclude/fvCFD.H:8,
                 from synbiose2.C:30,
                 from synbiose2.H:146,
                 from synbiose2.C:26:
/home/software/OpenFOAM/OpenFOAM-v1712/src/finiteVolume/lnInclude/fvMatrix.C:1567:33: note: template<class Type> Foam::tmp<Foam::fvMatrix<Type> > Foam::operator==(const Foam::tmp<Foam::fvMatrix<Type> >&, const Foam::tmp<Foam::DimensionedField<Type, Foam::volMesh> >&)
 Foam::tmp<Foam::fvMatrix<Type>> Foam::operator==
                                 ^
/home/software/OpenFOAM/OpenFOAM-v1712/src/finiteVolume/lnInclude/fvMatrix.C:1567:33: note:   template argument deduction/substitution failed:
In file included from synbiose2.C:289:0,
                 from synbiose2.H:146,
                 from synbiose2.C:26:
MeshGrowth.H:38:50: note:   ‘Foam::pointPatchField<Foam::Vector<double> >’ is not derived from ‘const Foam::tmp<Foam::fvMatrix<Type> >’
 PointDisplacement.boundaryFieldRef()[patchID] == PointPointer;
                                                  ^
In file included from /home/software/OpenFOAM/OpenFOAM-v1712/src/finiteVolume/lnInclude/fvMatrix.H:1090:0,
                 from /home/software/OpenFOAM/OpenFOAM-v1712/src/finiteVolume/lnInclude/ddtScheme.C:29,
                 from /home/software/OpenFOAM/OpenFOAM-v1712/src/finiteVolume/lnInclude/ddtScheme.H:351,
                 from /home/software/OpenFOAM/OpenFOAM-v1712/src/finiteVolume/lnInclude/fvcDdt.C:28,
                 from /home/software/OpenFOAM/OpenFOAM-v1712/src/finiteVolume/lnInclude/fvcDdt.H:205,
                 from /home/software/OpenFOAM/OpenFOAM-v1712/src/finiteVolume/lnInclude/fvc.H:44,
                 from /home/software/OpenFOAM/OpenFOAM-v1712/src/finiteVolume/lnInclude/fvCFD.H:8,
                 from synbiose2.C:30,
                 from synbiose2.H:146,
                 from synbiose2.C:26:
/home/software/OpenFOAM/OpenFOAM-v1712/src/finiteVolume/lnInclude/fvMatrix.C:1554:33: note: template<class Type> Foam::tmp<Foam::fvMatrix<Type> > Foam::operator==(const Foam::tmp<Foam::fvMatrix<Type> >&, const Foam::DimensionedField<Type, Foam::volMesh>&)
 Foam::tmp<Foam::fvMatrix<Type>> Foam::operator==
                                 ^
/home/software/OpenFOAM/OpenFOAM-v1712/src/finiteVolume/lnInclude/fvMatrix.C:1554:33: note:   template argument deduction/substitution failed:
In file included from synbiose2.C:289:0,
                 from synbiose2.H:146,
                 from synbiose2.C:26:
MeshGrowth.H:38:50: note:   ‘Foam::pointPatchField<Foam::Vector<double> >’ is not derived from ‘const Foam::tmp<Foam::fvMatrix<Type> >’
 PointDisplacement.boundaryFieldRef()[patchID] == PointPointer;
                                                  ^
In file included from /home/software/OpenFOAM/OpenFOAM-v1712/src/finiteVolume/lnInclude/fvMatrix.H:1090:0,
                 from /home/software/OpenFOAM/OpenFOAM-v1712/src/finiteVolume/lnInclude/ddtScheme.C:29,
                 from /home/software/OpenFOAM/OpenFOAM-v1712/src/finiteVolume/lnInclude/ddtScheme.H:351,
                 from /home/software/OpenFOAM/OpenFOAM-v1712/src/finiteVolume/lnInclude/fvcDdt.C:28,
                 from /home/software/OpenFOAM/OpenFOAM-v1712/src/finiteVolume/lnInclude/fvcDdt.H:205,
                 from /home/software/OpenFOAM/OpenFOAM-v1712/src/finiteVolume/lnInclude/fvc.H:44,
                 from /home/software/OpenFOAM/OpenFOAM-v1712/src/finiteVolume/lnInclude/fvCFD.H:8,
                 from synbiose2.C:30,
                 from synbiose2.H:146,
                 from synbiose2.C:26:
/home/software/OpenFOAM/OpenFOAM-v1712/src/finiteVolume/lnInclude/fvMatrix.C:1540:33: note: template<class Type> Foam::tmp<Foam::fvMatrix<Type> > Foam::operator==(const Foam::fvMatrix<Type>&, const Foam::tmp<Foam::GeometricField<Type, Foam::fvPatchField, Foam::volMesh> >&)
 Foam::tmp<Foam::fvMatrix<Type>> Foam::operator==
                                 ^
/home/software/OpenFOAM/OpenFOAM-v1712/src/finiteVolume/lnInclude/fvMatrix.C:1540:33: note:   template argument deduction/substitution failed:
In file included from synbiose2.C:289:0,
                 from synbiose2.H:146,
                 from synbiose2.C:26:
MeshGrowth.H:38:50: note:   ‘Foam::pointPatchField<Foam::Vector<double> >’ is not derived from ‘const Foam::fvMatrix<Type>’
 PointDisplacement.boundaryFieldRef()[patchID] == PointPointer;
                                                  ^
In file included from /home/software/OpenFOAM/OpenFOAM-v1712/src/finiteVolume/lnInclude/fvMatrix.H:1090:0,
                 from /home/software/OpenFOAM/OpenFOAM-v1712/src/finiteVolume/lnInclude/ddtScheme.C:29,
                 from /home/software/OpenFOAM/OpenFOAM-v1712/src/finiteVolume/lnInclude/ddtScheme.H:351,
                 from /home/software/OpenFOAM/OpenFOAM-v1712/src/finiteVolume/lnInclude/fvcDdt.C:28,
                 from /home/software/OpenFOAM/OpenFOAM-v1712/src/finiteVolume/lnInclude/fvcDdt.H:205,
                 from /home/software/OpenFOAM/OpenFOAM-v1712/src/finiteVolume/lnInclude/fvc.H:44,
                 from /home/software/OpenFOAM/OpenFOAM-v1712/src/finiteVolume/lnInclude/fvCFD.H:8,
                 from synbiose2.C:30,
                 from synbiose2.H:146,
                 from synbiose2.C:26:
/home/software/OpenFOAM/OpenFOAM-v1712/src/finiteVolume/lnInclude/fvMatrix.C:1526:33: note: template<class Type> Foam::tmp<Foam::fvMatrix<Type> > Foam::operator==(const Foam::fvMatrix<Type>&, const Foam::tmp<Foam::DimensionedField<Type, Foam::volMesh> >&)
 Foam::tmp<Foam::fvMatrix<Type>> Foam::operator==
                                 ^
/home/software/OpenFOAM/OpenFOAM-v1712/src/finiteVolume/lnInclude/fvMatrix.C:1526:33: note:   template argument deduction/substitution failed:
In file included from synbiose2.C:289:0,
                 from synbiose2.H:146,
                 from synbiose2.C:26:
MeshGrowth.H:38:50: note:   ‘Foam::pointPatchField<Foam::Vector<double> >’ is not derived from ‘const Foam::fvMatrix<Type>’
 PointDisplacement.boundaryFieldRef()[patchID] == PointPointer;
                                                  ^
In file included from /home/software/OpenFOAM/OpenFOAM-v1712/src/finiteVolume/lnInclude/fvMatrix.H:1090:0,
                 from /home/software/OpenFOAM/OpenFOAM-v1712/src/finiteVolume/lnInclude/ddtScheme.C:29,
                 from /home/software/OpenFOAM/OpenFOAM-v1712/src/finiteVolume/lnInclude/ddtScheme.H:351,
                 from /home/software/OpenFOAM/OpenFOAM-v1712/src/finiteVolume/lnInclude/fvcDdt.C:28,
                 from /home/software/OpenFOAM/OpenFOAM-v1712/src/finiteVolume/lnInclude/fvcDdt.H:205,
                 from /home/software/OpenFOAM/OpenFOAM-v1712/src/finiteVolume/lnInclude/fvc.H:44,
                 from /home/software/OpenFOAM/OpenFOAM-v1712/src/finiteVolume/lnInclude/fvCFD.H:8,
                 from synbiose2.C:30,
                 from synbiose2.H:146,
                 from synbiose2.C:26:
/home/software/OpenFOAM/OpenFOAM-v1712/src/finiteVolume/lnInclude/fvMatrix.C:1513:33: note: template<class Type> Foam::tmp<Foam::fvMatrix<Type> > Foam::operator==(const Foam::fvMatrix<Type>&, const Foam::DimensionedField<Type, Foam::volMesh>&)
 Foam::tmp<Foam::fvMatrix<Type>> Foam::operator==
                                 ^
/home/software/OpenFOAM/OpenFOAM-v1712/src/finiteVolume/lnInclude/fvMatrix.C:1513:33: note:   template argument deduction/substitution failed:
In file included from synbiose2.C:289:0,
                 from synbiose2.H:146,
                 from synbiose2.C:26:
MeshGrowth.H:38:50: note:   ‘Foam::pointPatchField<Foam::Vector<double> >’ is not derived from ‘const Foam::fvMatrix<Type>’
 PointDisplacement.boundaryFieldRef()[patchID] == PointPointer;
                                                  ^
In file included from /home/software/OpenFOAM/OpenFOAM-v1712/src/finiteVolume/lnInclude/fvMatrix.H:1090:0,
                 from /home/software/OpenFOAM/OpenFOAM-v1712/src/finiteVolume/lnInclude/ddtScheme.C:29,
                 from /home/software/OpenFOAM/OpenFOAM-v1712/src/finiteVolume/lnInclude/ddtScheme.H:351,
                 from /home/software/OpenFOAM/OpenFOAM-v1712/src/finiteVolume/lnInclude/fvcDdt.C:28,
                 from /home/software/OpenFOAM/OpenFOAM-v1712/src/finiteVolume/lnInclude/fvcDdt.H:205,
                 from /home/software/OpenFOAM/OpenFOAM-v1712/src/finiteVolume/lnInclude/fvc.H:44,
                 from /home/software/OpenFOAM/OpenFOAM-v1712/src/finiteVolume/lnInclude/fvCFD.H:8,
                 from synbiose2.C:30,
                 from synbiose2.H:146,
                 from synbiose2.C:26:
/home/software/OpenFOAM/OpenFOAM-v1712/src/finiteVolume/lnInclude/fvMatrix.C:1502:33: note: template<class Type> Foam::tmp<Foam::fvMatrix<Type> > Foam::operator==(const Foam::tmp<Foam::fvMatrix<Type> >&, const Foam::tmp<Foam::fvMatrix<Type> >&)
 Foam::tmp<Foam::fvMatrix<Type>> Foam::operator==
                                 ^
/home/software/OpenFOAM/OpenFOAM-v1712/src/finiteVolume/lnInclude/fvMatrix.C:1502:33: note:   template argument deduction/substitution failed:
In file included from synbiose2.C:289:0,
                 from synbiose2.H:146,
                 from synbiose2.C:26:
MeshGrowth.H:38:50: note:   ‘Foam::pointPatchField<Foam::Vector<double> >’ is not derived from ‘const Foam::tmp<Foam::fvMatrix<Type> >’
 PointDisplacement.boundaryFieldRef()[patchID] == PointPointer;
                                                  ^
In file included from /home/software/OpenFOAM/OpenFOAM-v1712/src/finiteVolume/lnInclude/fvMatrix.H:1090:0,
                 from /home/software/OpenFOAM/OpenFOAM-v1712/src/finiteVolume/lnInclude/ddtScheme.C:29,
                 from /home/software/OpenFOAM/OpenFOAM-v1712/src/finiteVolume/lnInclude/ddtScheme.H:351,
                 from /home/software/OpenFOAM/OpenFOAM-v1712/src/finiteVolume/lnInclude/fvcDdt.C:28,
                 from /home/software/OpenFOAM/OpenFOAM-v1712/src/finiteVolume/lnInclude/fvcDdt.H:205,
                 from /home/software/OpenFOAM/OpenFOAM-v1712/src/finiteVolume/lnInclude/fvc.H:44,
                 from /home/software/OpenFOAM/OpenFOAM-v1712/src/finiteVolume/lnInclude/fvCFD.H:8,
                 from synbiose2.C:30,
                 from synbiose2.H:146,
                 from synbiose2.C:26:
/home/software/OpenFOAM/OpenFOAM-v1712/src/finiteVolume/lnInclude/fvMatrix.C:1491:33: note: template<class Type> Foam::tmp<Foam::fvMatrix<Type> > Foam::operator==(const Foam::fvMatrix<Type>&, const Foam::tmp<Foam::fvMatrix<Type> >&)
 Foam::tmp<Foam::fvMatrix<Type>> Foam::operator==
                                 ^
/home/software/OpenFOAM/OpenFOAM-v1712/src/finiteVolume/lnInclude/fvMatrix.C:1491:33: note:   template argument deduction/substitution failed:
In file included from synbiose2.C:289:0,
                 from synbiose2.H:146,
                 from synbiose2.C:26:
MeshGrowth.H:38:50: note:   ‘Foam::pointPatchField<Foam::Vector<double> >’ is not derived from ‘const Foam::fvMatrix<Type>’
 PointDisplacement.boundaryFieldRef()[patchID] == PointPointer;
                                                  ^
In file included from /home/software/OpenFOAM/OpenFOAM-v1712/src/finiteVolume/lnInclude/fvMatrix.H:1090:0,
                 from /home/software/OpenFOAM/OpenFOAM-v1712/src/finiteVolume/lnInclude/ddtScheme.C:29,
                 from /home/software/OpenFOAM/OpenFOAM-v1712/src/finiteVolume/lnInclude/ddtScheme.H:351,
                 from /home/software/OpenFOAM/OpenFOAM-v1712/src/finiteVolume/lnInclude/fvcDdt.C:28,
                 from /home/software/OpenFOAM/OpenFOAM-v1712/src/finiteVolume/lnInclude/fvcDdt.H:205,
                 from /home/software/OpenFOAM/OpenFOAM-v1712/src/finiteVolume/lnInclude/fvc.H:44,
                 from /home/software/OpenFOAM/OpenFOAM-v1712/src/finiteVolume/lnInclude/fvCFD.H:8,
                 from synbiose2.C:30,
                 from synbiose2.H:146,
                 from synbiose2.C:26:
/home/software/OpenFOAM/OpenFOAM-v1712/src/finiteVolume/lnInclude/fvMatrix.C:1480:33: note: template<class Type> Foam::tmp<Foam::fvMatrix<Type> > Foam::operator==(const Foam::tmp<Foam::fvMatrix<Type> >&, const Foam::fvMatrix<Type>&)
 Foam::tmp<Foam::fvMatrix<Type>> Foam::operator==
                                 ^
/home/software/OpenFOAM/OpenFOAM-v1712/src/finiteVolume/lnInclude/fvMatrix.C:1480:33: note:   template argument deduction/substitution failed:
In file included from synbiose2.C:289:0,
                 from synbiose2.H:146,
                 from synbiose2.C:26:
MeshGrowth.H:38:50: note:   ‘Foam::pointPatchField<Foam::Vector<double> >’ is not derived from ‘const Foam::tmp<Foam::fvMatrix<Type> >’
 PointDisplacement.boundaryFieldRef()[patchID] == PointPointer;
                                                  ^
In file included from /home/software/OpenFOAM/OpenFOAM-v1712/src/finiteVolume/lnInclude/fvMatrix.H:1090:0,
                 from /home/software/OpenFOAM/OpenFOAM-v1712/src/finiteVolume/lnInclude/ddtScheme.C:29,
                 from /home/software/OpenFOAM/OpenFOAM-v1712/src/finiteVolume/lnInclude/ddtScheme.H:351,
                 from /home/software/OpenFOAM/OpenFOAM-v1712/src/finiteVolume/lnInclude/fvcDdt.C:28,
                 from /home/software/OpenFOAM/OpenFOAM-v1712/src/finiteVolume/lnInclude/fvcDdt.H:205,
                 from /home/software/OpenFOAM/OpenFOAM-v1712/src/finiteVolume/lnInclude/fvc.H:44,
                 from /home/software/OpenFOAM/OpenFOAM-v1712/src/finiteVolume/lnInclude/fvCFD.H:8,
                 from synbiose2.C:30,
                 from synbiose2.H:146,
                 from synbiose2.C:26:
/home/software/OpenFOAM/OpenFOAM-v1712/src/finiteVolume/lnInclude/fvMatrix.C:1469:33: note: template<class Type> Foam::tmp<Foam::fvMatrix<Type> > Foam::operator==(const Foam::fvMatrix<Type>&, const Foam::fvMatrix<Type>&)
 Foam::tmp<Foam::fvMatrix<Type>> Foam::operator==
                                 ^
/home/software/OpenFOAM/OpenFOAM-v1712/src/finiteVolume/lnInclude/fvMatrix.C:1469:33: note:   template argument deduction/substitution failed:
In file included from synbiose2.C:289:0,
                 from synbiose2.H:146,
                 from synbiose2.C:26:
MeshGrowth.H:38:50: note:   ‘Foam::pointPatchField<Foam::Vector<double> >’ is not derived from ‘const Foam::fvMatrix<Type>’
 PointDisplacement.boundaryFieldRef()[patchID] == PointPointer;
                                                  ^
In file included from /home/software/OpenFOAM/OpenFOAM-v1712/src/OpenFOAM/lnInclude/septernion.H:206:0,
                 from /home/software/OpenFOAM/OpenFOAM-v1712/src/OpenFOAM/lnInclude/transformField.H:40,
                 from /home/software/OpenFOAM/OpenFOAM-v1712/src/OpenFOAM/lnInclude/mapDistributeTemplates.C:30,
                 from /home/software/OpenFOAM/OpenFOAM-v1712/src/OpenFOAM/lnInclude/mapDistribute.H:652,
                 from /home/software/OpenFOAM/OpenFOAM-v1712/src/OpenFOAM/lnInclude/globalMeshDataTemplates.C:28,
                 from /home/software/OpenFOAM/OpenFOAM-v1712/src/OpenFOAM/lnInclude/globalMeshData.H:627,
                 from /home/software/OpenFOAM/OpenFOAM-v1712/src/OpenFOAM/lnInclude/GeometricBoundaryField.C:28,
                 from /home/software/OpenFOAM/OpenFOAM-v1712/src/OpenFOAM/lnInclude/GeometricField.C:1363,
                 from /home/software/OpenFOAM/OpenFOAM-v1712/src/OpenFOAM/lnInclude/GeometricField.H:664,
                 from /home/software/OpenFOAM/OpenFOAM-v1712/src/OpenFOAM/lnInclude/GeometricScalarField.H:38,
                 from /home/software/OpenFOAM/OpenFOAM-v1712/src/OpenFOAM/lnInclude/GeometricFields.H:34,
                 from /home/software/OpenFOAM/OpenFOAM-v1712/src/finiteVolume/lnInclude/volFields.H:37,
                 from /home/software/OpenFOAM/OpenFOAM-v1712/src/lagrangian/intermediate/lnInclude/PatchInteractionModel.C:29,
                 from /home/software/OpenFOAM/OpenFOAM-v1712/src/lagrangian/intermediate/lnInclude/PatchInteractionModel.H:222,
                 from synbiose2.H:35,
                 from synbiose2.C:26:
/home/software/OpenFOAM/OpenFOAM-v1712/src/OpenFOAM/lnInclude/septernionI.H:168:13: note: bool Foam::operator==(const Foam::septernion&, const Foam::septernion&)
 inline bool Foam::operator==(const septernion& tr1, const septernion& tr2)
             ^
/home/software/OpenFOAM/OpenFOAM-v1712/src/OpenFOAM/lnInclude/septernionI.H:168:13: note:   no known conversion for argument 1 from ‘Foam::pointPatchField<Foam::Vector<double> >’ to ‘const Foam::septernion&’
In file included from /home/software/OpenFOAM/OpenFOAM-v1712/src/OpenFOAM/lnInclude/quaternion.H:304:0,
                 from /home/software/OpenFOAM/OpenFOAM-v1712/src/OpenFOAM/lnInclude/transformField.H:39,
                 from /home/software/OpenFOAM/OpenFOAM-v1712/src/OpenFOAM/lnInclude/mapDistributeTemplates.C:30,
                 from /home/software/OpenFOAM/OpenFOAM-v1712/src/OpenFOAM/lnInclude/mapDistribute.H:652,
                 from /home/software/OpenFOAM/OpenFOAM-v1712/src/OpenFOAM/lnInclude/globalMeshDataTemplates.C:28,
                 from /home/software/OpenFOAM/OpenFOAM-v1712/src/OpenFOAM/lnInclude/globalMeshData.H:627,
                 from /home/software/OpenFOAM/OpenFOAM-v1712/src/OpenFOAM/lnInclude/GeometricBoundaryField.C:28,
                 from /home/software/OpenFOAM/OpenFOAM-v1712/src/OpenFOAM/lnInclude/GeometricField.C:1363,
                 from /home/software/OpenFOAM/OpenFOAM-v1712/src/OpenFOAM/lnInclude/GeometricField.H:664,
                 from /home/software/OpenFOAM/OpenFOAM-v1712/src/OpenFOAM/lnInclude/GeometricScalarField.H:38,
                 from /home/software/OpenFOAM/OpenFOAM-v1712/src/OpenFOAM/lnInclude/GeometricFields.H:34,
                 from /home/software/OpenFOAM/OpenFOAM-v1712/src/finiteVolume/lnInclude/volFields.H:37,
                 from /home/software/OpenFOAM/OpenFOAM-v1712/src/lagrangian/intermediate/lnInclude/PatchInteractionModel.C:29,
                 from /home/software/OpenFOAM/OpenFOAM-v1712/src/lagrangian/intermediate/lnInclude/PatchInteractionModel.H:222,
                 from synbiose2.H:35,
                 from synbiose2.C:26:
/home/software/OpenFOAM/OpenFOAM-v1712/src/OpenFOAM/lnInclude/quaternionI.H:617:13: note: bool Foam::operator==(const Foam::quaternion&, const Foam::quaternion&)
 inline bool Foam::operator==(const quaternion& q1, const quaternion& q2)
             ^
/home/software/OpenFOAM/OpenFOAM-v1712/src/OpenFOAM/lnInclude/quaternionI.H:617:13: note:   no known conversion for argument 1 from ‘Foam::pointPatchField<Foam::Vector<double> >’ to ‘const Foam::quaternion&’
In file included from /home/software/OpenFOAM/OpenFOAM-v1712/src/OpenFOAM/lnInclude/vectorTensorTransform.H:248:0,
                 from /home/software/OpenFOAM/OpenFOAM-v1712/src/OpenFOAM/lnInclude/mapDistribute.H:138,
                 from /home/software/OpenFOAM/OpenFOAM-v1712/src/OpenFOAM/lnInclude/globalMeshDataTemplates.C:28,
                 from /home/software/OpenFOAM/OpenFOAM-v1712/src/OpenFOAM/lnInclude/globalMeshData.H:627,
                 from /home/software/OpenFOAM/OpenFOAM-v1712/src/OpenFOAM/lnInclude/GeometricBoundaryField.C:28,
                 from /home/software/OpenFOAM/OpenFOAM-v1712/src/OpenFOAM/lnInclude/GeometricField.C:1363,
                 from /home/software/OpenFOAM/OpenFOAM-v1712/src/OpenFOAM/lnInclude/GeometricField.H:664,
                 from /home/software/OpenFOAM/OpenFOAM-v1712/src/OpenFOAM/lnInclude/GeometricScalarField.H:38,
                 from /home/software/OpenFOAM/OpenFOAM-v1712/src/OpenFOAM/lnInclude/GeometricFields.H:34,
                 from /home/software/OpenFOAM/OpenFOAM-v1712/src/finiteVolume/lnInclude/volFields.H:37,
                 from /home/software/OpenFOAM/OpenFOAM-v1712/src/lagrangian/intermediate/lnInclude/PatchInteractionModel.C:29,
                 from /home/software/OpenFOAM/OpenFOAM-v1712/src/lagrangian/intermediate/lnInclude/PatchInteractionModel.H:222,
                 from synbiose2.H:35,
                 from synbiose2.C:26:
/home/software/OpenFOAM/OpenFOAM-v1712/src/OpenFOAM/lnInclude/vectorTensorTransformI.H:243:13: note: bool Foam::operator==(const Foam::vectorTensorTransform&, const Foam::vectorTensorTransform&)
 inline bool Foam::operator==
             ^
/home/software/OpenFOAM/OpenFOAM-v1712/src/OpenFOAM/lnInclude/vectorTensorTransformI.H:243:13: note:   no known conversion for argument 1 from ‘Foam::pointPatchField<Foam::Vector<double> >’ to ‘const Foam::vectorTensorTransform&’
In file included from /home/software/OpenFOAM/OpenFOAM-v1712/src/OpenFOAM/lnInclude/lduAddressing.H:101:0,
                 from /home/software/OpenFOAM/OpenFOAM-v1712/src/OpenFOAM/lnInclude/lduMesh.H:36,
                 from /home/software/OpenFOAM/OpenFOAM-v1712/src/finiteVolume/lnInclude/fvMesh.H:51,
                 from /home/software/OpenFOAM/OpenFOAM-v1712/src/lagrangian/intermediate/lnInclude/PatchInteractionModel.C:27,
                 from /home/software/OpenFOAM/OpenFOAM-v1712/src/lagrangian/intermediate/lnInclude/PatchInteractionModel.H:222,
                 from synbiose2.H:35,
                 from synbiose2.C:26:
/home/software/OpenFOAM/OpenFOAM-v1712/src/OpenFOAM/lnInclude/Tuple2.H:156:13: note: template<class Type1, class Type2> bool Foam::operator==(const Foam::Tuple2<Type1, Type2>&, const Foam::Tuple2<Type1, Type2>&)
 inline bool operator==
             ^
/home/software/OpenFOAM/OpenFOAM-v1712/src/OpenFOAM/lnInclude/Tuple2.H:156:13: note:   template argument deduction/substitution failed:
In file included from synbiose2.C:289:0,
                 from synbiose2.H:146,
                 from synbiose2.C:26:
MeshGrowth.H:38:50: note:   ‘Foam::pointPatchField<Foam::Vector<double> >’ is not derived from ‘const Foam::Tuple2<Type1, Type2>’
 PointDisplacement.boundaryFieldRef()[patchID] == PointPointer;
                                                  ^
In file included from /home/software/OpenFOAM/OpenFOAM-v1712/src/OpenFOAM/lnInclude/triFace.H:303:0,
                 from /home/software/OpenFOAM/OpenFOAM-v1712/src/OpenFOAM/lnInclude/tetIndices.H:62,
                 from /home/software/OpenFOAM/OpenFOAM-v1712/src/lagrangian/intermediate/lnInclude/PatchInteractionModel.H:47,
                 from synbiose2.H:35,
                 from synbiose2.C:26:
/home/software/OpenFOAM/OpenFOAM-v1712/src/OpenFOAM/lnInclude/triFaceI.H:387:13: note: bool Foam::operator==(const Foam::triFace&, const Foam::triFace&)
 inline bool Foam::operator==(const triFace& a, const triFace& b)
             ^
/home/software/OpenFOAM/OpenFOAM-v1712/src/OpenFOAM/lnInclude/triFaceI.H:387:13: note:   no known conversion for argument 1 from ‘Foam::pointPatchField<Foam::Vector<double> >’ to ‘const Foam::triFace&’
In file included from /home/software/OpenFOAM/OpenFOAM-v1712/src/OpenFOAM/lnInclude/cellShapeList.H:35:0,
                 from /home/software/OpenFOAM/OpenFOAM-v1712/src/OpenFOAM/lnInclude/primitiveMesh.H:58,
                 from /home/software/OpenFOAM/OpenFOAM-v1712/src/OpenFOAM/lnInclude/polyMesh.H:45,
                 from /home/software/OpenFOAM/OpenFOAM-v1712/src/OpenFOAM/lnInclude/tetIndices.H:61,
                 from /home/software/OpenFOAM/OpenFOAM-v1712/src/lagrangian/intermediate/lnInclude/PatchInteractionModel.H:47,
                 from synbiose2.H:35,
                 from synbiose2.C:26:
/home/software/OpenFOAM/OpenFOAM-v1712/src/OpenFOAM/lnInclude/cellShape.H:169:21: note: bool Foam::operator==(const Foam::cellShape&, const Foam::cellShape&)
         friend bool operator==(const cellShape& a, const cellShape& b);
                     ^
/home/software/OpenFOAM/OpenFOAM-v1712/src/OpenFOAM/lnInclude/cellShape.H:169:21: note:   no known conversion for argument 1 from ‘Foam::pointPatchField<Foam::Vector<double> >’ to ‘const Foam::cellShape&’
In file included from /home/software/OpenFOAM/OpenFOAM-v1712/src/OpenFOAM/lnInclude/cellModel.H:257:0,
                 from /home/software/OpenFOAM/OpenFOAM-v1712/src/OpenFOAM/lnInclude/cellShape.H:46,
                 from /home/software/OpenFOAM/OpenFOAM-v1712/src/OpenFOAM/lnInclude/cellShapeList.H:35,
                 from /home/software/OpenFOAM/OpenFOAM-v1712/src/OpenFOAM/lnInclude/primitiveMesh.H:58,
                 from /home/software/OpenFOAM/OpenFOAM-v1712/src/OpenFOAM/lnInclude/polyMesh.H:45,
                 from /home/software/OpenFOAM/OpenFOAM-v1712/src/OpenFOAM/lnInclude/tetIndices.H:61,
                 from /home/software/OpenFOAM/OpenFOAM-v1712/src/lagrangian/intermediate/lnInclude/PatchInteractionModel.H:47,
                 from synbiose2.H:35,
                 from synbiose2.C:26:
/home/software/OpenFOAM/OpenFOAM-v1712/src/OpenFOAM/lnInclude/cellModelI.H:124:13: note: bool Foam::operator==(const Foam::cellModel&, const Foam::cellModel&)
 inline bool Foam::operator==(const cellModel& lhs, const cellModel& rhs)
             ^
/home/software/OpenFOAM/OpenFOAM-v1712/src/OpenFOAM/lnInclude/cellModelI.H:124:13: note:   no known conversion for argument 1 from ‘Foam::pointPatchField<Foam::Vector<double> >’ to ‘const Foam::cellModel&’
In file included from /home/software/OpenFOAM/OpenFOAM-v1712/src/OpenFOAM/lnInclude/cellList.H:53:0,
                 from /home/software/OpenFOAM/OpenFOAM-v1712/src/OpenFOAM/lnInclude/primitiveMesh.H:57,
                 from /home/software/OpenFOAM/OpenFOAM-v1712/src/OpenFOAM/lnInclude/polyMesh.H:45,
                 from /home/software/OpenFOAM/OpenFOAM-v1712/src/OpenFOAM/lnInclude/tetIndices.H:61,
                 from /home/software/OpenFOAM/OpenFOAM-v1712/src/lagrangian/intermediate/lnInclude/PatchInteractionModel.H:47,
                 from synbiose2.H:35,
                 from synbiose2.C:26:
/home/software/OpenFOAM/OpenFOAM-v1712/src/OpenFOAM/lnInclude/cell.H:135:6: note: bool Foam::operator==(const Foam::cell&, const Foam::cell&)
 bool operator==(const cell& a, const cell& b);
      ^
/home/software/OpenFOAM/OpenFOAM-v1712/src/OpenFOAM/lnInclude/cell.H:135:6: note:   no known conversion for argument 1 from ‘Foam::pointPatchField<Foam::Vector<double> >’ to ‘const Foam::cell&’
In file included from /home/software/OpenFOAM/OpenFOAM-v1712/src/OpenFOAM/lnInclude/triangle.C:28:0,
                 from /home/software/OpenFOAM/OpenFOAM-v1712/src/OpenFOAM/lnInclude/triangle.H:365,
                 from /home/software/OpenFOAM/OpenFOAM-v1712/src/OpenFOAM/lnInclude/triPointRef.H:35,
                 from /home/software/OpenFOAM/OpenFOAM-v1712/src/OpenFOAM/lnInclude/tetrahedron.H:48,
                 from /home/software/OpenFOAM/OpenFOAM-v1712/src/OpenFOAM/lnInclude/tetPointRef.H:35,
                 from /home/software/OpenFOAM/OpenFOAM-v1712/src/OpenFOAM/lnInclude/tetIndices.H:59,
                 from /home/software/OpenFOAM/OpenFOAM-v1712/src/lagrangian/intermediate/lnInclude/PatchInteractionModel.H:47,
                 from synbiose2.H:35,
                 from synbiose2.C:26:
/home/software/OpenFOAM/OpenFOAM-v1712/src/OpenFOAM/lnInclude/plane.H:228:6: note: bool Foam::operator==(const Foam::plane&, const Foam::plane&)
 bool operator==(const plane& a, const plane& b);
      ^
/home/software/OpenFOAM/OpenFOAM-v1712/src/OpenFOAM/lnInclude/plane.H:228:6: note:   no known conversion for argument 1 from ‘Foam::pointPatchField<Foam::Vector<double> >’ to ‘const Foam::plane&’
In file included from /home/software/OpenFOAM/OpenFOAM-v1712/src/OpenFOAM/lnInclude/treeBoundBox.H:361:0,
                 from /home/software/OpenFOAM/OpenFOAM-v1712/src/OpenFOAM/lnInclude/triPoints.H:39,
                 from /home/software/OpenFOAM/OpenFOAM-v1712/src/OpenFOAM/lnInclude/triangleI.H:28,
                 from /home/software/OpenFOAM/OpenFOAM-v1712/src/OpenFOAM/lnInclude/triangle.H:360,
                 from /home/software/OpenFOAM/OpenFOAM-v1712/src/OpenFOAM/lnInclude/triPointRef.H:35,
                 from /home/software/OpenFOAM/OpenFOAM-v1712/src/OpenFOAM/lnInclude/tetrahedron.H:48,
                 from /home/software/OpenFOAM/OpenFOAM-v1712/src/OpenFOAM/lnInclude/tetPointRef.H:35,
                 from /home/software/OpenFOAM/OpenFOAM-v1712/src/OpenFOAM/lnInclude/tetIndices.H:59,
                 from /home/software/OpenFOAM/OpenFOAM-v1712/src/lagrangian/intermediate/lnInclude/PatchInteractionModel.H:47,
                 from synbiose2.H:35,
                 from synbiose2.C:26:
/home/software/OpenFOAM/OpenFOAM-v1712/src/OpenFOAM/lnInclude/treeBoundBoxI.H:348:13: note: bool Foam::operator==(const Foam::treeBoundBox&, const Foam::treeBoundBox&)
 inline bool Foam::operator==(const treeBoundBox& a, const treeBoundBox& b)
             ^
/home/software/OpenFOAM/OpenFOAM-v1712/src/OpenFOAM/lnInclude/treeBoundBoxI.H:348:13: note:   no known conversion for argument 1 from ‘Foam::pointPatchField<Foam::Vector<double> >’ to ‘const Foam::treeBoundBox&’
In file included from /home/software/OpenFOAM/OpenFOAM-v1712/src/OpenFOAM/lnInclude/boundBox.H:310:0,
                 from /home/software/OpenFOAM/OpenFOAM-v1712/src/OpenFOAM/lnInclude/treeBoundBox.H:64,
                 from /home/software/OpenFOAM/OpenFOAM-v1712/src/OpenFOAM/lnInclude/triPoints.H:39,
                 from /home/software/OpenFOAM/OpenFOAM-v1712/src/OpenFOAM/lnInclude/triangleI.H:28,
                 from /home/software/OpenFOAM/OpenFOAM-v1712/src/OpenFOAM/lnInclude/triangle.H:360,
                 from /home/software/OpenFOAM/OpenFOAM-v1712/src/OpenFOAM/lnInclude/triPointRef.H:35,
                 from /home/software/OpenFOAM/OpenFOAM-v1712/src/OpenFOAM/lnInclude/tetrahedron.H:48,
                 from /home/software/OpenFOAM/OpenFOAM-v1712/src/OpenFOAM/lnInclude/tetPointRef.H:35,
                 from /home/software/OpenFOAM/OpenFOAM-v1712/src/OpenFOAM/lnInclude/tetIndices.H:59,
                 from /home/software/OpenFOAM/OpenFOAM-v1712/src/lagrangian/intermediate/lnInclude/PatchInteractionModel.H:47,
                 from synbiose2.H:35,
                 from synbiose2.C:26:
/home/software/OpenFOAM/OpenFOAM-v1712/src/OpenFOAM/lnInclude/boundBoxI.H:282:13: note: bool Foam::operator==(const Foam::boundBox&, const Foam::boundBox&)
 inline bool Foam::operator==(const boundBox& a, const boundBox& b)
             ^
/home/software/OpenFOAM/OpenFOAM-v1712/src/OpenFOAM/lnInclude/boundBoxI.H:282:13: note:   no known conversion for argument 1 from ‘Foam::pointPatchField<Foam::Vector<double> >’ to ‘const Foam::boundBox&’
In file included from /home/software/OpenFOAM/OpenFOAM-v1712/src/OpenFOAM/lnInclude/face.H:442:0,
                 from /home/software/OpenFOAM/OpenFOAM-v1712/src/OpenFOAM/lnInclude/primitivePatch.H:36,
                 from /home/software/OpenFOAM/OpenFOAM-v1712/src/OpenFOAM/lnInclude/polyPatch.H:43,
                 from /home/software/OpenFOAM/OpenFOAM-v1712/src/lagrangian/intermediate/lnInclude/PatchInteractionModel.H:45,
                 from synbiose2.H:35,
                 from synbiose2.C:26:
/home/software/OpenFOAM/OpenFOAM-v1712/src/OpenFOAM/lnInclude/faceI.H:159:13: note: bool Foam::operator==(const Foam::face&, const Foam::face&)
 inline bool Foam::operator==(const face& a, const face& b)
             ^
/home/software/OpenFOAM/OpenFOAM-v1712/src/OpenFOAM/lnInclude/faceI.H:159:13: note:   no known conversion for argument 1 from ‘Foam::pointPatchField<Foam::Vector<double> >’ to ‘const Foam::face&’
In file included from /home/software/OpenFOAM/OpenFOAM-v1712/src/OpenFOAM/lnInclude/PrimitivePatch.H:60:0,
                 from /home/software/OpenFOAM/OpenFOAM-v1712/src/OpenFOAM/lnInclude/primitivePatch.H:35,
                 from /home/software/OpenFOAM/OpenFOAM-v1712/src/OpenFOAM/lnInclude/polyPatch.H:43,
                 from /home/software/OpenFOAM/OpenFOAM-v1712/src/lagrangian/intermediate/lnInclude/PatchInteractionModel.H:45,
                 from synbiose2.H:35,
                 from synbiose2.C:26:
/home/software/OpenFOAM/OpenFOAM-v1712/src/OpenFOAM/lnInclude/objectHit.H:125:13: note: bool Foam::operator==(const Foam::objectHit&, const Foam::objectHit&)
 inline bool operator==(const objectHit& a, const objectHit& b)
             ^
/home/software/OpenFOAM/OpenFOAM-v1712/src/OpenFOAM/lnInclude/objectHit.H:125:13: note:   no known conversion for argument 1 from ‘Foam::pointPatchField<Foam::Vector<double> >’ to ‘const Foam::objectHit&’
In file included from /home/software/OpenFOAM/OpenFOAM-v1712/src/OpenFOAM/lnInclude/edge.H:332:0,
                 from /home/software/OpenFOAM/OpenFOAM-v1712/src/OpenFOAM/lnInclude/edgeList.H:53,
                 from /home/software/OpenFOAM/OpenFOAM-v1712/src/OpenFOAM/lnInclude/PrimitivePatch.H:56,
                 from /home/software/OpenFOAM/OpenFOAM-v1712/src/OpenFOAM/lnInclude/primitivePatch.H:35,
                 from /home/software/OpenFOAM/OpenFOAM-v1712/src/OpenFOAM/lnInclude/polyPatch.H:43,
                 from /home/software/OpenFOAM/OpenFOAM-v1712/src/lagrangian/intermediate/lnInclude/PatchInteractionModel.H:45,
                 from synbiose2.H:35,
                 from synbiose2.C:26:
/home/software/OpenFOAM/OpenFOAM-v1712/src/OpenFOAM/lnInclude/edgeI.H:469:13: note: bool Foam::operator==(const Foam::edge&, const Foam::edge&)
 inline bool Foam::operator==(const edge& a, const edge& b)
             ^
/home/software/OpenFOAM/OpenFOAM-v1712/src/OpenFOAM/lnInclude/edgeI.H:469:13: note:   no known conversion for argument 1 from ‘Foam::pointPatchField<Foam::Vector<double> >’ to ‘const Foam::edge&’
In file included from /home/software/OpenFOAM/OpenFOAM-v1712/src/OpenFOAM/lnInclude/labelPair.H:61:0,
                 from /home/software/OpenFOAM/OpenFOAM-v1712/src/OpenFOAM/lnInclude/edge.H:48,
                 from /home/software/OpenFOAM/OpenFOAM-v1712/src/OpenFOAM/lnInclude/edgeList.H:53,
                 from /home/software/OpenFOAM/OpenFOAM-v1712/src/OpenFOAM/lnInclude/PrimitivePatch.H:56,
                 from /home/software/OpenFOAM/OpenFOAM-v1712/src/OpenFOAM/lnInclude/primitivePatch.H:35,
                 from /home/software/OpenFOAM/OpenFOAM-v1712/src/OpenFOAM/lnInclude/polyPatch.H:43,
                 from /home/software/OpenFOAM/OpenFOAM-v1712/src/lagrangian/intermediate/lnInclude/PatchInteractionModel.H:45,
                 from synbiose2.H:35,
                 from synbiose2.C:26:
/home/software/OpenFOAM/OpenFOAM-v1712/src/OpenFOAM/lnInclude/Pair.H:140:6: note: template<class T> bool Foam::operator==(const Foam::Pair<T>&, const Foam::Pair<T>&)
 bool operator==(const Pair<T>& a, const Pair<T>& b)
      ^
/home/software/OpenFOAM/OpenFOAM-v1712/src/OpenFOAM/lnInclude/Pair.H:140:6: note:   template argument deduction/substitution failed:
In file included from synbiose2.C:289:0,
                 from synbiose2.H:146,
                 from synbiose2.C:26:
MeshGrowth.H:38:50: note:   ‘Foam::pointPatchField<Foam::Vector<double> >’ is not derived from ‘const Foam::Pair<T>’
 PointDisplacement.boundaryFieldRef()[patchID] == PointPointer;
                                                  ^
In file included from /home/software/OpenFOAM/OpenFOAM-v1712/src/OpenFOAM/lnInclude/VectorSpace.H:230:0,
                 from /home/software/OpenFOAM/OpenFOAM-v1712/src/OpenFOAM/lnInclude/Vector2D.H:40,
                 from /home/software/OpenFOAM/OpenFOAM-v1712/src/OpenFOAM/lnInclude/vector2D.H:39,
                 from /home/software/OpenFOAM/OpenFOAM-v1712/src/OpenFOAM/lnInclude/PstreamReduceOps.H:36,
                 from /home/software/OpenFOAM/OpenFOAM-v1712/src/OpenFOAM/lnInclude/exchange.C:31,
                 from /home/software/OpenFOAM/OpenFOAM-v1712/src/OpenFOAM/lnInclude/Pstream.H:387,
                 from /home/software/OpenFOAM/OpenFOAM-v1712/src/OpenFOAM/lnInclude/IOobjectTemplates.C:30,
                 from /home/software/OpenFOAM/OpenFOAM-v1712/src/OpenFOAM/lnInclude/IOobject.H:505,
                 from /home/software/OpenFOAM/OpenFOAM-v1712/src/OpenFOAM/lnInclude/regIOobject.H:41,
                 from /home/software/OpenFOAM/OpenFOAM-v1712/src/OpenFOAM/lnInclude/baseIOdictionary.H:44,
                 from /home/software/OpenFOAM/OpenFOAM-v1712/src/OpenFOAM/lnInclude/IOdictionary.H:42,
                 from /home/software/OpenFOAM/OpenFOAM-v1712/src/lagrangian/intermediate/lnInclude/PatchInteractionModel.H:42,
                 from synbiose2.H:35,
                 from synbiose2.C:26:
/home/software/OpenFOAM/OpenFOAM-v1712/src/OpenFOAM/lnInclude/VectorSpaceI.H:754:13: note: template<class Form, class Cmpt, unsigned char Ncmpts> bool Foam::operator==(const Foam::VectorSpace<Form, Cmpt, Ncmpts>&, const Foam::VectorSpace<Form, Cmpt, Ncmpts>&)
 inline bool operator==
             ^
/home/software/OpenFOAM/OpenFOAM-v1712/src/OpenFOAM/lnInclude/VectorSpaceI.H:754:13: note:   template argument deduction/substitution failed:
In file included from synbiose2.C:289:0,
                 from synbiose2.H:146,
                 from synbiose2.C:26:
MeshGrowth.H:38:50: note:   ‘Foam::pointPatchField<Foam::Vector<double> >’ is not derived from ‘const Foam::VectorSpace<Form, Cmpt, Ncmpts>’
 PointDisplacement.boundaryFieldRef()[patchID] == PointPointer;
                                                  ^
In file included from /home/software/OpenFOAM/OpenFOAM-v1712/src/OpenFOAM/lnInclude/instantList.H:35:0,
                 from /home/software/OpenFOAM/OpenFOAM-v1712/src/OpenFOAM/lnInclude/fileOperation.H:45,
                 from /home/software/OpenFOAM/OpenFOAM-v1712/src/OpenFOAM/lnInclude/IOobjectTemplates.C:27,
                 from /home/software/OpenFOAM/OpenFOAM-v1712/src/OpenFOAM/lnInclude/IOobject.H:505,
                 from /home/software/OpenFOAM/OpenFOAM-v1712/src/OpenFOAM/lnInclude/regIOobject.H:41,
                 from /home/software/OpenFOAM/OpenFOAM-v1712/src/OpenFOAM/lnInclude/baseIOdictionary.H:44,
                 from /home/software/OpenFOAM/OpenFOAM-v1712/src/OpenFOAM/lnInclude/IOdictionary.H:42,
                 from /home/software/OpenFOAM/OpenFOAM-v1712/src/lagrangian/intermediate/lnInclude/PatchInteractionModel.H:42,
                 from synbiose2.H:35,
                 from synbiose2.C:26:
/home/software/OpenFOAM/OpenFOAM-v1712/src/OpenFOAM/lnInclude/instant.H:140:6: note: bool Foam::operator==(const Foam::instant&, const Foam::instant&)
 bool operator==(const instant& a, const instant& b);
      ^
/home/software/OpenFOAM/OpenFOAM-v1712/src/OpenFOAM/lnInclude/instant.H:140:6: note:   no known conversion for argument 1 from ‘Foam::pointPatchField<Foam::Vector<double> >’ to ‘const Foam::instant&’
In file included from /home/software/OpenFOAM/OpenFOAM-v1712/src/OpenFOAM/lnInclude/UList.C:29:0,
                 from /home/software/OpenFOAM/OpenFOAM-v1712/src/OpenFOAM/lnInclude/UList.H:609,
                 from /home/software/OpenFOAM/OpenFOAM-v1712/src/OpenFOAM/lnInclude/List.H:43,
                 from /home/software/OpenFOAM/OpenFOAM-v1712/src/OpenFOAM/lnInclude/HashTable.C:30,
                 from /home/software/OpenFOAM/OpenFOAM-v1712/src/OpenFOAM/lnInclude/Istream.H:184,
                 from /home/software/OpenFOAM/OpenFOAM-v1712/src/OpenFOAM/lnInclude/token.H:621,
                 from /home/software/OpenFOAM/OpenFOAM-v1712/src/OpenFOAM/lnInclude/UILListIO.C:28,
                 from /home/software/OpenFOAM/OpenFOAM-v1712/src/OpenFOAM/lnInclude/UILList.C:91,
                 from /home/software/OpenFOAM/OpenFOAM-v1712/src/OpenFOAM/lnInclude/UILList.H:383,
                 from /home/software/OpenFOAM/OpenFOAM-v1712/src/OpenFOAM/lnInclude/ILList.H:39,
                 from /home/software/OpenFOAM/OpenFOAM-v1712/src/OpenFOAM/lnInclude/IDLList.H:35,
                 from /home/software/OpenFOAM/OpenFOAM-v1712/src/OpenFOAM/lnInclude/entry.H:45,
                 from /home/software/OpenFOAM/OpenFOAM-v1712/src/OpenFOAM/lnInclude/dictionary.H:88,
                 from /home/software/OpenFOAM/OpenFOAM-v1712/src/OpenFOAM/lnInclude/baseIOdictionary.H:43,
                 from /home/software/OpenFOAM/OpenFOAM-v1712/src/OpenFOAM/lnInclude/IOdictionary.H:42,
                 from /home/software/OpenFOAM/OpenFOAM-v1712/src/lagrangian/intermediate/lnInclude/PatchInteractionModel.H:42,
                 from synbiose2.H:35,
                 from synbiose2.C:26:
/home/software/OpenFOAM/OpenFOAM-v1712/src/OpenFOAM/lnInclude/labelRange.H:275:13: note: bool Foam::operator==(const Foam::labelRange&, const Foam::labelRange&)
 inline bool operator==(const labelRange& a, const labelRange& b)
             ^
/home/software/OpenFOAM/OpenFOAM-v1712/src/OpenFOAM/lnInclude/labelRange.H:275:13: note:   no known conversion for argument 1 from ‘Foam::pointPatchField<Foam::Vector<double> >’ to ‘const Foam::labelRange&’
synbiose2.C: At global scope:
synbiose2.C:44:1: error: redefinition of ‘Foam::synbiose2<CloudType>::synbiose2(const Foam::dictionary&, CloudType&)’
 Foam::synbiose2<CloudType>::synbiose2
 ^
In file included from synbiose2.H:146:0,
                 from synbiose2.C:26:
synbiose2.C:44:1: error: ‘Foam::synbiose2<CloudType>::synbiose2(const Foam::dictionary&, CloudType&)’ previously declared here
 Foam::synbiose2<CloudType>::synbiose2
 ^
synbiose2.C:105:1: error: redefinition of ‘Foam::synbiose2<CloudType>::synbiose2(const Foam::synbiose2<CloudType>&)’
 Foam::synbiose2<CloudType>::synbiose2
 ^
In file included from synbiose2.H:146:0,
                 from synbiose2.C:26:
synbiose2.C:105:1: error: ‘Foam::synbiose2<CloudType>::synbiose2(const Foam::synbiose2<CloudType>&)’ previously declared here
 Foam::synbiose2<CloudType>::synbiose2
 ^
synbiose2.C:125:1: error: redefinition of ‘Foam::synbiose2<CloudType>::~synbiose2()’
 Foam::synbiose2<CloudType>::~synbiose2()
 ^
In file included from synbiose2.H:146:0,
                 from synbiose2.C:26:
synbiose2.C:125:1: error: ‘virtual Foam::synbiose2<CloudType>::~synbiose2()’ previously declared here
 Foam::synbiose2<CloudType>::~synbiose2()
 ^
synbiose2.C:132:23: error: redefinition of ‘Foam::volScalarField& Foam::synbiose2<CloudType>::massEscape()’
 Foam::volScalarField& Foam::synbiose2<CloudType>::massEscape()
                       ^
In file included from synbiose2.H:146:0,
                 from synbiose2.C:26:
synbiose2.C:132:23: error: ‘Foam::volScalarField& Foam::synbiose2<CloudType>::massEscape()’ previously declared here
 Foam::volScalarField& Foam::synbiose2<CloudType>::massEscape()
                       ^
synbiose2.C:161:23: error: redefinition of ‘Foam::volScalarField& Foam::synbiose2<CloudType>::massStick()’
 Foam::volScalarField& Foam::synbiose2<CloudType>::massStick()
                       ^
In file included from synbiose2.H:146:0,
                 from synbiose2.C:26:
synbiose2.C:161:23: error: ‘Foam::volScalarField& Foam::synbiose2<CloudType>::massStick()’ previously declared here
 Foam::volScalarField& Foam::synbiose2<CloudType>::massStick()
                       ^
synbiose2.C:190:6: error: redefinition of ‘bool Foam::synbiose2<CloudType>::correct(typename CloudType::parcelType&, const Foam::polyPatch&, bool&, Foam::scalar, const Foam::tetIndices&)’
 bool Foam::synbiose2<CloudType>::correct
      ^
In file included from synbiose2.H:146:0,
                 from synbiose2.C:26:
synbiose2.C:190:6: error: ‘virtual bool Foam::synbiose2<CloudType>::correct(typename CloudType::parcelType&, const Foam::polyPatch&, bool&, Foam::scalar, const Foam::tetIndices&)’ previously declared here
 bool Foam::synbiose2<CloudType>::correct
      ^
synbiose2.C:385:6: error: redefinition of ‘void Foam::synbiose2<CloudType>::info(Foam::Ostream&)’
 void Foam::synbiose2<CloudType>::info(Ostream& os)
      ^
In file included from synbiose2.H:146:0,
                 from synbiose2.C:26:
synbiose2.C:385:6: error: ‘virtual void Foam::synbiose2<CloudType>::info(Foam::Ostream&)’ previously declared here
 void Foam::synbiose2<CloudType>::info(Ostream& os)
      ^
make: *** [Make/linux64GccDPInt32Opt/./synbiose2.o] Errore 1
