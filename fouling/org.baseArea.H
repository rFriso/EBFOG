	vectorField  faceCentres = mesh.boundaryMesh()[patchID].faceCentres();
	vectorField  centerList(facePoints.size());
	labelList    faceList(facePoints.size()); 

	label index =  0;

	
	forAll(pp,faceI)
	{

	labelList  neighbourFacePoints = mesh.boundaryMesh()[patchID].localFaces()[faceI];
	//labelList    	neighbourFacePoints = mesh.boundaryMesh()[patchID].localFaces()[faceCheck];


		forAll(neighbourFacePoints,pointsI)
		{
	  
			if ( neighbourFacePoints[pointsI] == facePoints[nodeNumber])
			{
				centerList[index]=faceCentres[faceI];
				//Add a list of faces touched for the sorting of the neighbours (the evaluation of the displacement)
			 	faceList[index]= faceI ;
				index ++;
				Info << index <<endl;
			}
		}
	}


	vector sumFaces(0,0,0);
	scalar baseArea;
	//Area calculation: Do not know if it is robust. Attempt #1, in case change here first
	//if(index != 4)
	//{
	// //A boundary point is hit. Therefore need to build the area in a different way
	// 
	// point point1 = centerList[0];
	// point point2 = centerList[1];
	// point center = points[facePoints[nodeNumber]];
	// 
	// vector diagLeft =(point1-center);
	// vector diagRight=(point2-center);
	// 
	// vector quadArea = diagLeft^diagRight;
	// 
	// scalar height = mag(quadArea)/mag(point1-point2);
	// 
	// scalar base1 = mag(diagLeft)*Foam::cos(Foam::asin(height/mag(diagLeft)));
	// scalar base2 = mag(diagRight)*Foam::cos(Foam::asin(height/mag(diagRight)));
	// 
	// baseArea = height*(base1+base2); 
	// 
	//}

	//Adding the support for triangular cells: done before since very robust and very simple
	if(index==3)
	{
	//The calculation of the area is straightForward

	 point point1 = centerList[0];
	 point point2 = centerList[1];
	 point point3 = centerList[2];

	 vector diagLeft =(point3-point1);
	 vector diagRight=(point2-point1);

	 vector Area = diagLeft^diagRight/2;

	 baseArea = mag(Area);

	}


	//If the number of faces sharing the point is bigger than 3, it is a pain in the ass.
	// What I sorted out until now is reordering the neighbour faces centers
	// in a clock/counterclock wise way (according to the distance from the firstpoint checked)

	else
	{

	
//	vector n1 = (centerList[1] - centerList[0])^(centerList[2] - centerList[0]);
//	vector n2 = (centerList[2] - centerList[3])^(centerList[1] - centerList[3]);
//
//	vector sumFaces = n1+n2;

	vectorField  centerOrdered(centerList.size());
	labelList    faceOrdered(facePoints.size());
        label j     = 1;
	label init  = 0;
	label k	    = 0;
	label added = 0;
	label faceToCheck = 0;

        centerOrdered = centerList[0];	
	for( label v = 1 ; v < centerList.size(); v++ )
	{

	        //Info << "centerList[v]" << faceList [v]<< centerList[v] << endl ;
	        //Info << "Checking if the faces are neighbours..." << endl;

		 if(!init)
		 {
		    //start from the first element in list (random basically from our standpoint)
		    faceToCheck = faceList[0];
		    Info << " Initialising the loop with face" << faceToCheck << endl ;
		 }
		 else
 		 {
		    //The first element have already been set. Just pick that one
		    faceToCheck = faceOrdered[v-1];
		    Info << " Ist neighbour:" << faceToCheck << endl ;
		    Info << " Looking for its neighbour:" << faceToCheck << endl ;
		 }
		 //Loop over the neighbour of the face to define an orer for the neighbourFaces
		 
   	          const labelList neighbourFaces = mesh.boundaryMesh()[patchID].faceFaces()[faceToCheck];
		
		 label faceNeighbourI = 0;
	 	 while( faceNeighbourI < neighbourFaces.size())
		 {

  		   Info << "Checking Face:" << neighbourFaces[faceNeighbourI] << endl;

        	   label check = 0;
		   k=0;
		   while(k<centerList.size())
		   { 
		     if(neighbourFaces[faceNeighbourI] == faceList[k])
		     {
		        // Add this loop to avoid faces to be counted twice
		   
  		        Info << "NeighbourFound:" << neighbourFaces[faceNeighbourI]  << endl;

		        forAll(centerOrdered,centerI)
		        {
		   	     if(centerOrdered[centerI] == centerList[k])
		   	     {
		   		check ++;
		   	     }
		        }
		        //If check is 0 means the face has not been counted yet.
		        if(!check)
		        {
                           Info << "Adding" << faceCentres[neighbourFaces[faceNeighbourI]] << "in position "<< j << endl;
		        	init++; 
		   	centerOrdered[j]= faceCentres[neighbourFaces[faceNeighbourI]];
		   	faceOrdered[j]=neighbourFaces[faceNeighbourI];

		   	j++;	 
		   	//Work done, clockwise/counterlockwise sequence depends on the first
		   	//face found. Since I need only the absolute value of the area this
		   	//is not a problem at the moment.

		   	added ++;

		   	//keeping on searching should does not make sense, the face have been found.
		   	k = centerList.size();
 
   		   	faceNeighbourI = neighbourFaces.size();
		        }
		        }
			k++;
			}
   		 
			faceNeighbourI++;
		 }
		
	 }
		Info << "centerOrdered" << centerOrdered << endl ;
		scalar redArea = 0.0;
	 forAll(centerOrdered,centerI)
	 {

	         point  nextPoint = centerOrdered[centerI+1];
		 if(centerI == index-1 )
		 { 
			//Close the loop
			nextPoint = centerOrdered[0];
	                Info << "this should be equal to the starting point" << nextPoint << endl ;

		 }

	         Info << "nextPoint" << nextPoint << endl ;


//	         Info << "points[facePoints[nodeNumber]]" << points[facePoints[nodeNumber]] << endl;

		 Info << "checking center" << centerI << endl;

		 vector	 vector1 = nextPoint - points[facePoints[nodeNumber]] ;	
		 vector  vector2 = centerOrdered[centerI] - points[facePoints[nodeNumber]] ;
	         Info << "\nvector 1 " <<  vector1 << endl;
	         Info << "\nvector 2 " <<  vector2 << endl;
		
		 
	         vector n = vector1 ^ vector2 ;
	
	         sumFaces += n;
		 redArea  += mag(n);
		 Info << "\n cumulated  Area" << mag(sumFaces) << endl ;
		 Info << "\n redundant check Area" << mag(redArea) << endl ;
		 Info << "\n triangleArea  Area" << mag(n) << endl ;
	}
	}
	    
	baseArea = mag(sumFaces)/2; 
	Info << "Base area :" << baseArea << endl;
