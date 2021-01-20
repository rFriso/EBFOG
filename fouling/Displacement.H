vector   areaV;

areaV=mesh.boundaryMesh()[patchID].faceAreas()[fI];

scalar  area;

area= mag(areaV);

// displacement

scalar dh;

dh=dm/rho/area;

// The sign - because the normal vector points outward the surface.
dx=-nw.x()*dh;
dy=-nw.y()*dh;
dz=-nw.z()*dh;


