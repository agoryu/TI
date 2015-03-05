// macro à completer : filtre passe-bas sur l'image.

// le spectre du filtre est un disque binaire sur le plan de fourier.

// le filtrage est applique par produit du spectre de la FFT de l'image avec le spectre du filtre

// l'image filtree resulte de la FFT inverse

 
macro "filtrage passe-basFFT" {

    run("FFT");
    // recuperation de ID de la FFT
    fourier = getImageID();

    // recuperation de la taille W x H du plan de Fourier
    W = getWidth();
    H = getHeight();


    // Creation d'un masque binaire

    newImage("masque", "8-bit", W, H, 1);
    masque = getImageID();
    // fond noir
    setColor(0);
    makeRectangle (0,0, W,H);
    fill();

    fc = 0.05;

    // calcul du rayon du disque binaire à partir de la frequence de coupure fc
    // attention, la FFT etant consideree comme une image par ImageJ, le rayon doit etre calcule en pixels
    rayon = H * fc;

    print("rayon =", rayon);

    setColor(255);
    makeOval (W/2-rayon,H/2-rayon, 2*rayon,2*rayon);
    fill ();


    // Filtrage passe-bas

    selectImage(fourier);
    makeOval(W/2-rayon,H/2-rayon, 2*rayon,2*rayon);
    setColor(0);
    // Selection inverse du cercle
    run("Make Inverse");
    fill();


    // Transformee de fourier inverse pour fournir l'image filtree

    run("Inverse FFT");
}

