//Elliot Vanegue
//Gaëtant Deflandre

macro "dematricage" {

    setBatchMode(true);

    run("Sample cfa");
    selectWindow("couleur CFA");

    run("Convolve...", "text1=[0.25 0.5 0.25\n0.5 1 0.5\n0.25 0.5 0.25\n]");
    run("Next Slice [>]");

    run("Convolve...", "text1=[0.0 0.25 0.0\n0.25 1.0 0.25\n0.0 0.25 0.0\n]");
    run("Next Slice [>]");

    run("Convolve...", "text1=[0.25 0.5 0.25\n0.5 1.0 0.5\n0.25 0.5 0.25\n]");
    run("Stack to RGB");

    setBatchMode("exit and display");


}