import ij.ImagePlus;
import ij.plugin.filter.PlugInFilter;
import ij.process.ByteProcessor;
import ij.process.ImageProcessor;

import java.util.ArrayList;
import java.util.List;

public class _Contour implements PlugInFilter {

	private int seuilBas = 95;
	private int seuilHaut = 105;

	public int setup(String arg, ImagePlus imp) {
		return PlugInFilter.DOES_8G;
	}

	public void run(ImageProcessor ip) {
		ByteProcessor newbp = hystRec(ip, this.seuilBas, this.seuilHaut);
		ImagePlus newImg = new ImagePlus(
				"Résultat du seuillage par hystérésis", newbp);
		newImg.show();
	}

	public ByteProcessor hystIter(ImageProcessor imNormeG, int seuilBas,
			int seuilHaut) {

		// récupération des dimension de l'image
		int width = imNormeG.getWidth();
		int height = imNormeG.getHeight();

		// Création d'une image de la meme taille que l'image en entré
		ByteProcessor maxLoc = new ByteProcessor(width, height);
		List<int[]> highpixels = new ArrayList<int[]>();

		// parcours de l'image
		for (int y = 0; y < height; y++) {
			for (int x = 0; x < width; x++) {

				// on enleve les pixels en dessous du seuil bas
				int g = imNormeG.getPixel(x, y) & 0xFF;
				if (g < seuilBas)
					continue;

				// si le pixel est supérieur au seuil haut
				// on ajoute le pixel à la nouvelle image et on met a jour la
				// liste
				// des pixels supérieurs au seuil haut
				if (g > seuilHaut) {
					maxLoc.set(x, y, 255);
					highpixels.add(new int[] { x, y });
					continue;
				}

				// si le pixel est entre les deux seuil
				// on le met dans la nouvelle image
				maxLoc.set(x, y, 128);
			}
		}

		int[] dx8 = new int[] { -1, 0, 1, -1, 1, -1, 0, 1 };
		int[] dy8 = new int[] { -1, -1, -1, 0, 0, 1, 1, 1 };

		while (!highpixels.isEmpty()) {

			List<int[]> newhighpixels = new ArrayList<int[]>();

			for (int[] pixel : highpixels) {
				int x = pixel[0], y = pixel[1];

				// parcours des voisins
				for (int k = 0; k < 8; k++) {
					int xk = x + dx8[k], yk = y + dy8[k];
					// si le voisin dépasse de l'image on le passe
					if (xk < 0 || xk >= width)
						continue;
					if (yk < 0 || yk >= height)
						continue;

					// tous les voisins qui sont entre les deux seuil
					// sont des contours donc on les met a 255
					if (maxLoc.get(xk, yk) == 128) {
						maxLoc.set(xk, yk, 255);
						newhighpixels.add(new int[] { xk, yk });
					}
				}
			}

			highpixels = newhighpixels;
		}

		// tous les pixels qui n'ont pas été modifié ne sont
		// pas des contours donc on les met à 0
		for (int y = 0; y < height; y++) {
			for (int x = 0; x < width; x++) {
				if (maxLoc.get(x, y) != 255)
					maxLoc.set(x, y, 0);
			}
		}
		return maxLoc;
	}

	public ByteProcessor hystRec(final ImageProcessor imNormeG,
			final int seuilBas, final int seuilHaut) {

		// récupération des dimension de l'image
		int width = imNormeG.getWidth();
		int height = imNormeG.getHeight();

		// Création d'une image de la meme taille que l'image en entré
		ByteProcessor maxLoc = new ByteProcessor(width, height);
		List<int[]> highpixels = new ArrayList<int[]>();

		// parcours de l'image
		for (int y = 0; y < height; y++) {
			for (int x = 0; x < width; x++) {

				// on enleve les pixels en dessous du seuil bas
				int g = imNormeG.getPixel(x, y) & 0xFF;
				if (g < seuilBas)
					continue;

				// si le pixel est supérieur au seuil haut
				// on ajoute le pixel à la nouvelle image et on met a jour la
				// liste
				// des pixels supérieurs au seuil haut
				if (g > seuilHaut) {
					maxLoc.set(x, y, 255);
					highpixels.add(new int[] { x, y });
					continue;
				}

				// si le pixel est entre les deux seuil
				// on le met dans la nouvelle image
				maxLoc.set(x, y, 128);
			}
		}

		propaRec(imNormeG, maxLoc, seuilBas, highpixels.get(0)[0],
				highpixels.get(0)[1]);

		// tous les pixels qui n'ont pas été modifié ne sont
		// pas des contours donc on les met à 0
		for (int y = 0; y < height; y++) {
			for (int x = 0; x < width; x++) {
				if (maxLoc.get(x, y) != 255)
					maxLoc.set(x, y, 0);
			}
		}
		return maxLoc;
	}

	private void propaRec(final ImageProcessor imNormeG,
			ImageProcessor imContours, final int seuilBas, final int x,
			final int y) {

		// récupération des dimension de l'image
		int width = imNormeG.getWidth();
		int height = imNormeG.getHeight();

		int[] dx8 = new int[] { -1, 0, 1, -1, 1, -1, 0, 1 };
		int[] dy8 = new int[] { -1, -1, -1, 0, 0, 1, 1, 1 };

		// parcours des voisins
		for (int k = 0; k < 8; k++) {
			int xk = x + dx8[k], yk = y + dy8[k];
			// si le voisin dépasse de l'image on le passe
			if (xk < 0 || xk >= width)
				continue;
			if (yk < 0 || yk >= height)
				continue;

			// tous les voisins qui sont entre les deux seuil
			// sont des contours donc on les met a 255
			if (imContours.get(xk, yk) == 128) {
				imContours.set(xk, yk, 255);
				propaRec(imNormeG, imContours, seuilBas, xk, yk);
			}
		}
	}
}
