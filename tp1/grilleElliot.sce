// Définition des échantillons sur un axe
axe = [0:99] / 100 + 5e-3; 
// Définition des éléments de surface
x = ones (1:100)' * axe;
y = axe' * ones (1:100);

// Grille de N*N source
N = 2;

// Hauteur
h = 0.5;

// Puissance
Phi = 100;

// Soit la distance-entre-deux-sources = distance-source-mur*ratio
ratio = N*3;

// Distance source-mur
dsm = 1 / (2 + (N-1)*ratio);

// Distance source-source
dss = dsm*ratio;

// Création de la liste des positions des sources
lxs = list();
lys = list();
nbSource = 0;


// Commentaires ci-dessous: solution non concluante
//espacedeb = 0;
//espacesize = 1/N;
//espacefin = 1/N;
//
//for i = 1:N
//    for j = 1:N
//        nbSource = nbSource + 1;
//        lxs(nbSource) = i * espacesize/2 + ((i-1) * (espacesize/2));
//        lys(nbSource) = j * espacesize/2 + ((j-1) * (espacesize/2));
//    end;
//end;


// sum des distance x
sumdx = dsm;

for i = 1:N
    
    // sum des distance y
    sumdy = dsm;
    
    for j = 1:N
        
        nbSource = nbSource + 1;
        
        lxs(nbSource) = sumdx;
        lys(nbSource) = sumdy;
        
        sumdy = sumdy + dss;
        
    end;
    sumdx = sumdx + dss;
end;

for i = 1:nbSource
    mprintf('Source %d : x=%s \ty=%s\n', i, string(lxs(i)), string(lys(i)));
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
