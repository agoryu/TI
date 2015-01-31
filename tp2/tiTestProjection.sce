// Effacer la memoire de travail de Scilab
clear;
// Chargement des fonctions externes
exec ('tiProjection.sci');
// Definition d'un cube de cote unite, sommets et aretes
[pCube, sCube] = tiCube (1);
//disp(pCube);
//disp(sCube);

E1 = RotationX(0)*RotationY(0)*RotationZ(0)*Translation(0,0,-5);
theta = %pi /4;
E2 = RotationX(theta)*RotationY(theta)*RotationZ(0)*Translation(5,0,0);



disp(E2);

// Matrice de projection 3D -> 2D
//  scaleX scaleY camRot camPos
M = [ -360      0    80    400;
         0   -360    60    300;
         0      0   0.2      1];
// Projection des sommets du cube
p = M * pCube;
disp(p);
// Passage en coordonnees cartesiennes
p = [p(1,:) ./ p(3,:); p(2,:) ./ p(3,:)];
disp(p);
// Affichage dans la figure 1
tiAfficheObjet2D (1, [600, 800], p, sCube);
