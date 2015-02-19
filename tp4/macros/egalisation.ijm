macro "egalisation" {

	W = getWidth();
	H = getHeight();

	bins = 256;

  	getHistogram(values, counts, bins);
  	cumule = newArray(256);

  	cumule[0] = counts[0];
	for (j=1; j<256; j++) {
	   	cumule[j] = cumule[j-1] + counts[j];
	}

	ratio = 255 / (W * H);
	
	for (j=0; j<H; j++) {
		for (i=0; i<W; i++) {
			p = getPixel(i, j);
			new = cumule[p];
	   		setPixel(i, j, new * ratio);
	   	}
	}
}