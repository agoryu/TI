// Effacer la memoire de travail de Scilab
clear;
// Chargement des fonctions externes
exec ('tiProjection.sci');
// Definition d'un cube de cote unite, sommets et aretes
[pCube, sCube] = tiCube (1);
//[pGrille, sGrille] = tiGrille (3, 3, 1);
//disp(pCube);
//disp(sCube);

E1 = RotationX(0)*RotationY(0)*RotationZ(0)*Translation(0,0,-5);
//theta = %pi /4;
theta = 45
E2 = RotationX(theta) * RotationY(0) * RotationZ(theta) * Translation(0,5,0);

disp(E2);

sx = 600/6.6;
sy = 800/6.3;

I1 = Projection(20) * ChangeRepere(sx, sy, 0, 0);
//disp(ChangeRepere(sx, sy, 0, 0))
//disp(I1);

// Matrice de projection 3D -> 2D
//  scaleX scaleY camRot camPos
M = [ -360      0    80    400;
         0   -360    60    300;
         0      0   0.2      1];
// Projection des sommets du cube
p = M * pCube;
//p = M * pGrille
disp(p);
// Passage en coordonnees cartesiennes
p = [p(1,:) ./ p(3,:); p(2,:) ./ p(3,:)];
disp(p);
// Affichage dans la figure 1
tiAfficheObjet2D (1, [600, 800], p, sCube);
//tiAfficheObjet2D (1, [600, 800], p, sGrille);
