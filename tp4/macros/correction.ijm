macro "correction" {

	W = getWidth();
	H = getHeight();

	//contraste
	a = 0;
	//luminosite
	b = 2;

	for (j=0; j<H; j++) {
	   	for (i=0; i<W; i++) {
	   		
	   		res = a + b * getPixel(i,j);
	   		setPixel(i, j, res);
	   	}
	}
}