This Boundary condition is intended to be used with a steady-state particle tracking (uncoupled). 
The idea is of realizing a subgrid for every face that is hit by a particle. Each portion of this subgrid
is intended as a "bin" for the incoming particles.
The number (and the volume) of the particles defines the displacement of the subgrid face. This displacement
is stored (write out to a file or recorded as a pointer, yet to be defined), and it is involved in the 
definition of a porosity. Such a porosity will keep into account the height of the deposits and their relative distance.
This way I can consider the effect of the shape of the deposit in terms of wavelength (average slope) and 
peak or valley dominated deposit (skewness).


Thus the grid should not be updated, but only the deposit file.
we still have to define how: store the effective distribution or store only the final average properties???


In order to see in which bin the particle sticks:
1- Decide the number of subdivisions
2- Get the length of the 4 edges that sorrounds the face
3- Divide the face in a grid
4- Decide the arrival bin:
	a. Divide the distance between the low-left corner of the grid and the arrival point by the size of the
	   subdivision (for each of the directions). In this way I have the bin
 	b. Check the  height and update it adding the particle volume.
5- Translate such displacement  in the coefficient of the porosity:
	IS IT NECESSARY TO DEFINE A NEW POROSITY MODEL????? ANISOTROPIC, KEEPING INTO ACCOUNT THE ROUGHNESS....
	Maybe. In the meantime set-up the procedure.


Remarks:

It is important to hold fixed the reference of frame of the face. In order to be consistent the following assumption is
done:
	-The origin of the reference is the point which is closed to the origin
	-The second point is the first point with an x-coordinate bigger than the 1st, if no one has, switch to the one
	 that have a smaller x.
	 It is not possible to have a case that does not belong to this one. 
	-Then keep the order provide by the facePoint method.

