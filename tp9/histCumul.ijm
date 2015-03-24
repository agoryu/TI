// Histogramme cumulé
getRawStatistics(surf, moy, min, max, std, h); // h[0..255] <-> histo
hc=newArray(256);
hc[0]=h[0];
for (i=1;i< h.length;i++) {
    hc[i] = hc[i-1]+h[i] ;
}
Plot.create("Histogramme cumulé de "+getTitle, "Niveau", "hc", hc);
Plot.show();