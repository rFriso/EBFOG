// Face of impact located, now time to tassellate the face itself. Check if the cell that owns the 
// face have already been marked as porous. 
//#include <fstream>

std::string depositListName= "depositCellList";

std::ifstream dL;
dL.open(depositListName.c_str());

label cellCheck 	= 0;
label cellI 		= 0;
label nParticlesInFace 	= 0;

label depositCell=mesh.findNearestCell(xyz);

Info << "depositCell " << tab << depositCell << tab << "face" << globalFaceId << endl;

std::string depositListNameTmp= "depositCellList.tmp";
std::ofstream fs(depositListNameTmp.c_str());


std::string linebuffer;

while (dL.is_open() && getline(dL,linebuffer))	
{
     if (linebuffer.length() == 0)continue;

     std::stringstream test(linebuffer);
     
     test >> cellI;

     fs << cellI << "\n";
 
     if(cellI == depositCell) 
     {
	   cellCheck=1;
	   // This passage is required to identify the porous cellSet.
	   // If it is not already declared, need to update.
     }

}

dL.close();

if (cellCheck==0)
{
    #include "createDeposit.H"
}
else
{
   #include "readDeposit.H"
}
