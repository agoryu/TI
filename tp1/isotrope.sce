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

// a^2 exposant réelle, si a est un nombre alors exposant normale
// si a est une matrice, alors produit matricelle

// a.^2 exposant sur le contenu de la matricelle, cad point à poàint : 
// a00*a00, a01*a01, ... aij*aij

// Eclairement
e = I0 * (h .* ((h^2 + d.^2).^(-3/2)));
plot3d (axe, axe, e);
imshow (e/max(e));

