// Macros exemple de modification de  la LUT

// Recherche du minimum de l'image pour les etudiants

// M1 IVI

// Version: 0.1
// Date: 11/02/2010
// Author: L. Macaire
 
macro "modif_LUT" {

	// Ouverture d'une image
	// open ("C:\\lagis-pc-serv2\\enseignement\\enseigne.0910\\master ivi\\seance 1 cours ludo fft\\omega_zero_sept_x.jpg");
	// recuperation du ID de l'image
	image = getImageID();


	// recuperation de la taille du plan de fourier
	W = getWidth();
	H = getHeight();

	// recherche du min 

	min = 255;

	for (j=0; j<H; j++) {
		for (i=0; i<W; i++) {
		
			p = getPixel(i,j);
			if ( min > p) {
				min =p;
			}
	 
		}
	}

	print ("min =", min);

	// declaration des LUTs

	reds = newArray(256); 
	greens = newArray(256); 
	blues = newArray(256);

	// Recuperation des LUTS
	getLut(reds, greens, blues);

	// Modification des LUTS pour 'video inversee'

	for (i=0; i<reds.length; i++) {
		reds[i] = 255-i;
		greens[i] = 255-i;
		blues[i] = 255-i;
	}

	// Affichage sous forme de resultats

	 for (i=0; i<reds.length; i++) {
		setResult("Red", i, reds[i]);
		setResult("Green", i, greens[i]);
		setResult("Blue", i, blues[i]);
	}
	updateResults;

	// Mise a jour des luts
	setLut(reds, greens, blues);
} // fin macro

