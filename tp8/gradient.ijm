macro "gradient" {

    //changement taille image pour éviter les nombres négatifs
    run("Conversions...", " ");
    run("32-bit");
    original = getImageID();
    selectImage(original);
    
    run("Duplicate...", "title=horizontal");
    picturX = getImageID();
    run("Convolve...", "text1=[-0.125 0.0 0.125\n-0.25 0.0 0.25\n-0.125 0.0 0.125\n]");

    selectImage(original);

    run("Duplicate...", "title=vertical");
    picturY = getImageID();
    run("Convolve...", "text1=[-0.125 -0.25 -0.125\n0.0 0.0 0.0\n0.125 0.25 0.125\n]");

    imageCalculator("Divide create", "horizontal","vertical");
    selectWindow("Result of horizontal");
    run("Macro...", "code=v=atan(v)");
    run("Macro...", "code=v=sqrt((v/3.14*180)");
    run("Macro...", "code=v=sqrt(v * v)");

    W = getWidth();
    H = getHeight();
    
    for(i=0; i<W; i++) {
        for(j=0; j<H; j++) {
            print(getPixel(j, i));
        }
    }

    if(getPixel(W/2, H/2) < 3.14) {
        print("diagonale_bas_gauche_haut_droite");
    } else {
        print("diagonale_haut_gauche_bas_droite");
    }
}