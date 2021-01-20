string  outfileName10 = "porous" + std::to_string(globalFaceId) +".areas" ;

ofstream outfile10 (outfileName10.c_str());

//label counter=0;

forAll(deposits,facetI)
{
    outfile10 << facetArea[facetI] << "\n" ;
}

outfile10.close();
