// If this file is called it means that a certain number of particles is stuck on that face.
// So I need to find the number of particles that has stuck to the face. It is a lot easier to create
// another file with the number of particles stuck (sort of porousFaces.######.nParticles.


std::string infileName4 = "Deposit." + std::to_string(globalFaceId) + ".nParticles" ;
ifstream infile4(infileName4.c_str()) ;

infile4 >> nParticlesInFace ; 
infile4.close();

nParticlesInFace ++;

std::string outfileName4 = "Deposit." + std::to_string(globalFaceId) + ".tmp" ;
ofstream outfile4(infileName4.c_str()) ;

outfile4  << nParticlesInFace ;
outfile4.close() ;

remove( infileName4.c_str());
rename( outfileName4.c_str(),infileName4.c_str());

std::string  outfileName6 = "Layer." + std::to_string(globalFaceId) + "." + std::to_string(nParticlesInFace) ;
ofstream outfile6 (outfileName6.c_str());

scalar actualTime = mesh.time().value();

//Info << "Start the timer" << tab << fI << endl;

outfile6 <<  actualTime ;
outfile6.close()  ;
