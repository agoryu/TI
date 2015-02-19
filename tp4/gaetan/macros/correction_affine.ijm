// Macros de correction affine a+b.I(x,y)

// Version: 0.1
// Date: 13/02/2015
// Author: G. DEFLANDRE
 
macro "dynamque_auto"{

    b = 1.2;
	a = -64*b;	
	
	// Ouvrir image active
	image = getImageID();
	
	// recuperation de la taille du plan de fourier
	width = getWidth();
	height = getHeight();
	
	for(raw=0; raw<height; raw++){
		for(col=0; col<width; col++){
			p = getPixel(col,raw);
			newp = a+(b*p);
			setPixel(col,raw,newp);
		}
	}

}
