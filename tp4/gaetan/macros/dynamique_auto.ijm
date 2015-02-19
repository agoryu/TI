// Macros qui étale la dynamque de l'histogramme au mieu

// Version: 0.1
// Date: 13/02/2015
// Author: G. DEFLANDRE
 
macro "dynamque_auto"{

	// Ouvrir image active
	image = getImageID();
	depth = 255;
	
	// recuperation de la taille du plan de fourier
	width = getWidth();
	height = getHeight();
	
	// recherche gris min et max
	min = 255;
	max = 0;
	
	for(raw=0; raw<height; raw++){
		for(col=0; col<width; col++){
			p = getPixel(col,raw);
			
			if(min > p){
				min = p;
			}
			
			if(max < p){
				max = p;
			}
		}
	}
	
	print("min = ", min);
	print("max = ", max);
	
	for(raw=0; raw<height; raw++){
		for(col=0; col<width; col++){
			p = getPixel(col,raw);
			newp = ((p-min)*depth) / (max-min);
			setPixel(col,raw,newp);
		}
	}
	
}