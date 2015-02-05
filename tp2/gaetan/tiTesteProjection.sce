// Effacer la memoire de travail de Scilab
clear;
// Chargement des fonctions externes
exec ('tiProjection.sci');
// Definition d'un cube de cote unite, sommets et aretes
[pCube, sCube] = tiCube (1);

// Matrice de projection 3D -> 2D
// Matrice intrinsèques
//M = [ -360      0    80    400;
//         0   -360    60    300;
//         0      0   0.2      1];


theta = 45;
matRX = RotationX(theta);
matRY = RotationY(0);
matRZ = RotationZ(theta);
matT = Translation(0,0,5);
matExt = Extrinseques(matRX, matRY, matRZ, matT);
matProj = Projection(20, 600/6.6, 800/8.8, 600/2, 800/2);
//matProj = Projection(20, 600/6.6, 800/8.8, 800/2, 600/2)

M = matProj * matExt;
disp(M);

// Projection des sommets du cube
p = M * pCube;

// Passage en coordonnees cartesiennes
p = [p(1,:) ./ p(3,:); p(2,:) ./ p(3,:)];
disp(p);

// Affichage dans la figure 1
tiAfficheObjet2D (1, [600, 800], p, sCube);
