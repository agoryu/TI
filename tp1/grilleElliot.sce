// Définition des échantillons sur un axe
axe = [0:99] / 100 + 5e-3; 
// Définition des éléments de surface
x = ones (1:100)' * axe;
y = axe' * ones (1:100);

// Grille de N*N source
N = 2;

// distance entre chaque source
pas = 1/(N+1);

// Création de la liste des positions des sources
lxs = list();
lys = list();
nbSource = 0;

for i = 1:N
    for j = 1:N
        nbSource = nbSource + 1;
        lxs(nbSource) = i * pas;
        lys(nbSource) = j * pas;
    end;
end;

// Calcul des distances
ld = zeros(100,nbSource);
for i = 1:100
    for j = 1:nbSource
        ld(i,j) = sqrt ((x(i) - lxs(j))^2 + (y(i) - lys(j))^2);
    end;
end;

// Puissance
Phi=100;

// Intensite energetique
I0=Phi/2/%pi;

// Hauteur
h= 0.5;

e = ones(1:100);
for i = 1:100
    for j = 1:nbSource
        e(i) = e(i) + (I0 * ((h^2) / ((h^2 + ld(i,j)^2)^(2))));
    end;
    disp(e(i));
end;

variation = (max(e) - min(e)) / max(e);

disp(variation);

//plot3d (axe, axe, e);
//imshow (e/max(e));
