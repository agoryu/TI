// Définition des échantillons sur un axe
axe = [0:99] / 100 + 5e-3; 
// Définition des éléments de surface
x = ones (1:100)' * axe;
y = axe' * ones (1:100);

// Grille de N*N source
N = 10;

// Hauteur
h = 0.5;

// Puissance
Phi = 100;

// Création de la liste des positions des sources
lxs = list();
lys = list();
nbSource = 0;

xmin = -1.5
xmax = 2.5
ymin = -1.5
ymax = 2.5
ecartx = abs(xmin) + abs(xmax)
ecarty = abs(ymin) + abs(ymax)

pasx = ecartx / (N-1)
pasy = ecarty / (N-1)

for i = 1:N
    for j = 1:N
        nbSource = nbSource + 1;
        lxs(nbSource) = xmin + pasx * (i-1);
        lys(nbSource) = ymin + pasy * (j-1);
    end;
end;

// Calcul des distances de chaque element pour chaque source
ld = list();
for i = 1:nbSource
    xs = lxs(i);
    ys = lys(i);
    ld(i) = sqrt ((x - xs).^2 + (y - ys).^2);
end;

// Intensite energetique
I0=Phi/2/%pi;

e = list();

for i = 1:nbSource
    e(i) = I0 * ((h^2) .* ((h^2 + ld(i).^2).^(2)).^(-1));
end;

sume = e(1); 
for i = 2:nbSource
    sume = e(i) + sume;
end;

variation = ((max(sume) - min(sume)) * 100) / max(sume);

disp(variation);

plot3d (axe, axe, sume);
//imshow (e/max(e));
