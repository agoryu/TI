macro "direction FFT"
{
    // ouverture d'une image si necessaire - sinon la macro analyse l'image courante
    //open ("/home/bmathon/Enseignement/TI/tp6_TF/images/256_a.jpg");

    // recuperation de l'identifiant de l'image
    image = getImageID();

    // application de la TDF (FFT : Fast Fourier Transform)
    run("FFT");

    // recuperation de l'ID du module de la FFT
    fourier = getImageID();

    // recuperation de la taille W x H du module de la FFT
    W = getWidth();
    H = getHeight();

    // recherche du max
    max_1 = 0; 
    i_max_1 = 0;
    j_max_1 = 0;
    max_2 = 0; 
    i_max_2 = 0;
    j_max_2 = 0;

    
    for (j=0; j<H; j++)
    {
        for (i=0; i<W; i++) 
        {
            p = getPixel(i,j);
            if ( max_1 < p)
            {
                max_2 = max_1;
                i_max_2 = i_max_1;
                j_max_2 = j_max_1;
                max_1 =p;
                i_max_1 = i;
                j_max_1 = j;
            } 
        }
    }

    // mise a zero de la valeur max

    setPixel (i_max_1,j_max_1,0);
    setPixel (i_max_2, j_max_2,0);

    print("x1 = " + i_max_1 + " y1 = " + j_max_1);
    print("x2 = " + i_max_2 + " y2 = " + j_max_2);
    print("plan de Fourier");
    fourrierX2 = i_max_2 / W - 0.5;
    fourrierY2 = (j_max_2 / H - 0.5) * (-1);
    print("x2 = " + fourrierX2 + " y2 = " + fourrierY2);

    if((fourrierX2*fourrierX2) - (fourrierY2*fourrierY2) != 0) {
        if(fourrierY2 != 0) {
            print("horizontal");
        } else {
            print("vertical");
        }
    } else {
        print("diagonal");
    }
}
