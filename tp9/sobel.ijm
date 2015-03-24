// Calcul de la norme du gradient par masque de Sobel
//
requires("1.41i");  // requis par substring(string, index)
setBatchMode(true);

sourceImage = getImageID();
filename = getTitle();
extension = "";
if (lastIndexOf(filename, ".") > 0) {
    extension = substring(filename, lastIndexOf(filename, "."));
    filename = substring(filename, 0, lastIndexOf(filename, "."));
}
filenameGradX = filename+"_grad_x"+extension;
filenameGradY = filename+"_grad_y"+extension;

run("Duplicate...", "title="+filenameGradX);
run("32-bit");  // Conversion en Float avant calcul des dérivées !!
run("Convolve...", "text1=[1 0 -1\n2 0 -2\n1 0 -1\n] normalize");

selectImage(sourceImage);
run("Duplicate...", "title="+filenameGradY);
run("32-bit");  // Conversion en Float avant calcul des dérivées !!
run("Convolve...", "text1=[1 2 1\n0 0 0\n-1 -2 -1\n] normalize");
/****** Calcul de la norme du gradient ******/
// récupération de la taille de l'image
W = getWidth();
H = getHeight();
// Calculs pour chaque pixel
run("Duplicate...", "title=norme");
run("8-bit"); 

run("Duplicate...", "title=angle");
run("8-bit"); 

for(i=0; i<H; i++) {
    for(j=0; j<W; j++) {
        selectImage(filenameGradX);
        pX = getPixel(j, i);

        selectImage(filenameGradY);
        pY = getPixel(j, i);

        selectImage("norme");
        norme = sqrt((pX * pX) + (pY * pY));
        setPixel(j, i, norme);

        selectImage("angle");
        //calcul de la tangente
        angle = atan2(pY, pX)/3.14*180;    
        //on ramene le resultat à un multiple de 45
        angle = round(angle / 45) * 45;
        setPixel(j, i, angle);

    }
}

selectImage("norme");
run("Duplicate...", "title=newNorme");
run("8-bit"); 

for(i=0; i<H; i++) {
    for(j=0; j<W; j++) {
        selectImage("norme");
        if(getPixel(j, i) <= 80) {

            selectImage("newNorme");
            setPixel(j, i, 0);
        } else {
            selectImage("newNorme");
            setPixel(j, i, 255);
            if(angle == 0 || angle == 180) {
                //setPixel(j-1, i, 255);
                //setPixel(j+1, i, 255);
                setPixel(j+1, i+1, 0);
                setPixel(j, i+1, 0);
                setPixel(j-1, i+1, 0);
                setPixel(j-1, i-1, 0);
                setPixel(j, i-1, 0);
                setPixel(j+1, i-1, 0);
            } else if(angle == 90) {
                setPixel(j-1, i, 0);
                setPixel(j+1, i, 0);
                setPixel(j+1, i+1, 0);
                //setPixel(j, i+1, 0);
                setPixel(j-1, i+1, 0);
                setPixel(j-1, i-1, 0);
                //setPixel(j, i-1, 0);
                setPixel(j+1, i-1, 0); 
            } else if(angle == 45) {
                setPixel(j-1, i, 0);
                setPixel(j+1, i, 0);
                //setPixel(j+1, i+1, 0);
                setPixel(j, i+1, 0);
                setPixel(j-1, i+1, 0);
                //setPixel(j-1, i-1, 0);
                setPixel(j, i-1, 0);
                setPixel(j+1, i-1, 0); 
            } else {
                setPixel(j-1, i, 0);
                setPixel(j+1, i, 0);
                setPixel(j+1, i+1, 0);
                setPixel(j, i+1, 0);
                //setPixel(j-1, i+1, 0);
                setPixel(j-1, i-1, 0);
                setPixel(j, i-1, 0);
                //setPixel(j+1, i-1, 0);
            }
        }
    }
}

setBatchMode("exit and display");