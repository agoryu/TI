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

//chaque element de la surface a une distance par rapport a chaque source lum.
//il ne faut pas fait la somme des distances mais la somme des éclairement de
//chaque source pour un element
//test = list();
//for i = 1:N
//    for j = 1:N
//        test(i) = test(i) + (I0 * ((h^2) / ((h^2 + ld(j)^2)^(2))));
//    end;
//end;

//plot3d (axe, axe, test);
//imshow (test/max(test));
plot3d (axe, axe, e);
imshow (e/max(e));


