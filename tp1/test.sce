// Définition des échantillons sur un axe
axe = [0:99] / 100 + 5e-3; //pas du graphe
// Définition des éléments de surface
x = ones (1:100)' * axe;
y = axe' * ones (1:100);
// Position de la source -> hauteur
xs = 0.5;
ys = 0.5;
// Calcul de la distance
d = sqrt ((x - xs).^2 + (y - ys).^2);
// Trace de la fonction distance
plot3d (axe, axe, d);
// Visualisation sous forme d'image en niveaux de gris
imshow (d);
