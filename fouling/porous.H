// Face of impact located, now time to tassellate the face itself. Check if the cell that owns the 
// face have already been marked as porous. 
//#include <fstream>


std::string porousListName= "porousCellList";

std::ifstream pL;
pL.open(porousListName.c_str());

label cellCheck = 0;

label porousCell=mesh.findNearestCell(xyz);

label cellI=0;
label nDivisions=500;

Info << "porousCell " << tab << porousCell << tab << "face" << globalFaceId << endl;

std::string porousListNameTmp= "porousCellList.tmp";
std::ofstream fs(porousListNameTmp.c_str());


std::string linebuffer;

while (pL.is_open() && getline(pL,linebuffer))	
{
     if (linebuffer.length() == 0)continue;

     std::stringstream test(linebuffer);
     
     test >> cellI;

     Info << "checking" << cellI << endl;

     fs << cellI << "\n";
 
     if(cellI == porousCell) 
     {

	   Info << cellI << "already porous" << endl;
	   cellCheck=1;
	   // This passage is required to identify the porous cellSet.
	   // If it is not already declared, need to update.
     }

}

pL.close();

if (cellCheck==0)
{
    #include "createDeposit.H"

}
else
{


   #include "readDeposit.H"

   
}


// need to compute the location of the impact.


