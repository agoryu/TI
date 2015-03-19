macro "gradient" {

    setBatchMode(true);

    //changement taille image pour éviter les nombres négatifs
    run("Conversions...", " ");
    run("32-bit");
    original = getImageID();

    sobelx = sobelX(original);
    sobely = sobelY(original);


    W = getWidth();
    H = getHeight();    

    n_neg = 0;
    n_pos = 0;
    sum_neg = 0;
    sum_pos = 0;

    for(x=0; x<H; x++) {
        for(y=0; y<W; y++) {
            angle = getAngle(x,y,sobelx,sobely);

            if(angle>=0.0){
                sum_pos += angle;
                n_pos++;
            } else {
                sum_neg += angle;
                n_neg++;
            }
        }
    }

    if(n_neg>0){
        mean_neg = sum_neg / n_neg;
    } else {
        mean_neg = 0;
    }

    if(n_pos>0){
        mean_pos = sum_pos / n_pos;
    } else {
        mean_pos = 0;
    }

    mean_neg = round(mean_neg);
    mean_pos = round(mean_pos);

    print(mean_neg);
    print(mean_pos);


    if(mean_pos>89.0 && mean_pos<91.0 && mean_neg>(-91.0) && mean_neg<(-89.0)){
        print("horizontale");
    } else if(mean_pos>=0.0 && mean_pos<1.0 && mean_neg>(-1.0) && mean_neg<=(0.0)){
        print("verticale");
    } else {
        print("diagonale");
    }

    setBatchMode(false);

}

function to32bits(){
    //changement taille image pour éviter les nombres négatifs
    run("Conversions...", " ");
    run("32-bit");
}

function sobelX(imgSource) {
    selectImage(imgSource);
    run("Duplicate...", "title=sobel_x");
	to32bits();
    run("Convolve...", "text1=[-1 0 1\n-2 0 2\n-1 0 1\n] normalize");

    return getImageID();
}

function sobelY(imgSource) {
    selectImage(imgSource);
    run("Duplicate...", "title=sobel_y");
	to32bits();
    run("Convolve...", "text1=[-1 -2 -1\n0 0 0\n1 2 1\n] normalize");
    return getImageID();
}

function getAngle(x, y, sobelx, sobely){
    selectImage(sobelx);
    dx = getPixel(x, y);
    selectImage(sobely);
    dy = getPixel(x, y);

    theta = atan2(dy,dx);

    return (theta/3.1415)*180;
}
