Info << "Cell to be added" << endl;

//    fs.seekp(1,std::ios_base::end);
label nParticlesInFace=0;

fs << depositCell << "\n";

fs.close();

remove( depositListName.c_str());
rename( depositListNameTmp.c_str(), depositListName.c_str());

//need to compute the faceArea before
scalar volume = p.mass()/rho;
nParticlesInFace = 1 ;

// The file name reporting the layer level is done in the following way:
// Layer.FACE.NPARTICLE -> NPARTICLE is the layer level inside the face.
std::string outfileName4 = "Deposit." 	+ std::to_string(globalFaceId) + ".nParticles";
std::string outfileName5 = "Layer." 	+ std::to_string(globalFaceId) + "." + std::to_string(nParticlesInFace) ;

ofstream outfile4 (outfileName4.c_str());
ofstream outfile5 (outfileName5.c_str());

outfile4  << "1" ;
outfile4.close() ;

//Info << "Accumulating on Face" << tab << fI << endl;
scalar actualTime = mesh.time().value()  ;
outfile5 << actualTime ; 
outfile5.close() ;
