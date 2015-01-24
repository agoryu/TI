// Définition des échantillons sur un axe
axe = [0:99] / 100 + 5e-3; //pas du graphe
// Définition des éléments de surface
x = ones (1:100)' * axe;
y = axe' * ones (1:100);
// Position de la source -> sur le plan
xs = 0.5;
ys = 0.5;

// Calcul de la distance
d = sqrt ((x - xs).^2 + (y - ys).^2);

// Puissance
Phi=100;

// Intensite energetique
I0=Phi/2/%pi;

// Hauteur
h= 0.5;

// Eclairement avec source de lambert
// L'exposant de la fin change car le cosinus de l'angle intervient 2 fois 
e = I0 * ((h^2) .* ((h^2 + d.^2).^(2)).^(-1));

plot3d (axe, axe, e);
imshow (e/max(e));
