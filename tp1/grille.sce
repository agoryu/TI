// Définition des échantillons sur un axe
axe = [0:99] / 100 + 5e-3; //pas du graphe
// Définition des éléments de surface
x = ones (1:100)' * axe;
y = axe' * ones (1:100);

// Grille de N*N source
N = 2;

// Position de la source -> sur le plan
//xs = 0.5;
//ys = 0.5;

// distance entre chaque source
pas = 1/(N+1);

// Création de la liste des positions des sources
lxs = list();
lys = list();

for i = 1:N
    for j = 1:N
        lxs(i)= i * pas;
        // on ecrase des element existant !!!!!!!!!!!
        lys(j)= j * pas;
    end;
end;

// Calcul des distances
ld = list();
for i = 1:N
    for j = 1:N
        ld(((i-1)*N)+j) = sqrt ((x - lxs(i)).^2 + (y - lys(j)).^2);
    end;
end;

sumd = ld(1)
// TODO faire la somme de la liste de matrice ld
for i = 2:(N*N)
    sumd = ld(i) + sumd;
end;


// Puissance
Phi=100;

// Intensite energetique
I0=Phi/2/%pi;

// Hauteur
h= 0.5;

// Eclairement avec source de lambert
// L'exposant de la fin change car le cosinus de l'angle intervient 2 fois 
e = I0 * ((h^2) .* ((h^2 + sumd.^2).^(2)).^(-1));

plot3d (axe, axe, e);
imshow (e/max(e));

espacedeb = 0;
espacesize = 1/N;
espacefin = 1/N;

x(1) = espacesize/2 + espacedeb;
espacedeb = espacefin;
espacefin = espacefin + espacesize;
x(2) = espacesize/2 + espacedeb;

