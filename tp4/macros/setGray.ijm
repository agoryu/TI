macro "setDynamiqueGray" {

	image = getImageID();

	W = getWidth();
	H = getHeight();

	min = 255;
	max = 0;

	for (j=0; j<H; j++) {
	   	for (i=0; i<W; i++) {

			p = getPixel(i,j);
			if ( min > p) {
				min = p;
			}
			
	 		if ( max < p) {
				max = p;
			}
	    }
	}

	for (j=0; j<H; j++) {
	   	for (i=0; i<W; i++) {
	   		
	   		res = round(255 * ((getPixel(i,j) - min)/(max - min)));
	   		setPixel(i, j, res);
	   	}
	}
}