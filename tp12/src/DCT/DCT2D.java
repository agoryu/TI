package DCT;

import ij.process.FloatProcessor; // Pour classe Float Processor

import java.awt.Rectangle;

abstract public class DCT2D {

	// ---------------------------------------------------------------------------------
	/**
	 * Transformation DCT 2D directe (méthode de classe) utilisant la
	 * séparabilité
	 * 
	 * @param fp
	 *            Signal 2D d'entrée (MxN) (FloatProcessor)
	 * @return Signal 2D de sortie (MxN) (FloatProcessor)
	 */
	public static void forwardDCT(FloatProcessor fp) {

		final Rectangle roi = fp.getRoi();
		final int newW = roi.width;
		final int newH = roi.height;
		final int beginX = roi.x;
		final int beginY = roi.y;

		
		// Traiter les lignes
		for (int y = 0; y < newH; y++) {

			double[] row_F = DCT1D.forwardDCT(fp.getLine(0, y+beginY, newW - 1, y+beginY));

			for (int x = 0; x < newW; x++) {
				fp.putPixelValue(x+beginX, y+beginY, row_F[x]);
			}
		}

		// Traiter les colonnes de l'image résultant du traitement des
		// lignes
		for (int x = 0; x < newW; x++) {

			double[] col_f = new double[newW];
			double[] col_F = new double[newW];

			for (int y = 0; y < newH; y++) {
				col_f[y] = fp.getPixelValue(beginX+x, beginY+y);
			}

			col_F = DCT1D.forwardDCT(col_f);

			for (int y = 0; y < newW; y++) {
				fp.putPixelValue(beginX+x, beginY+y, col_F[y]);
			}
		}
	}

	// ---------------------------------------------------------------------------------
	/**
	 * Transformation DCT 2D inverse (méthode de classe)
	 * 
	 * @param fp
	 *            Signal 2D d'entrée et de sortie (FloatProcessor)
	 */
	public static void inverseDCT(FloatProcessor fp) {

		final Rectangle roi = fp.getRoi();
		final int newW = roi.width;
		final int newH = roi.height;
		final int beginX = roi.x;
		final int beginY = roi.y;

		
		// Traiter les lignes
		for (int y = 0; y < newH; y++) {

			double[] row_F = DCT1D.inverseDCT(fp.getLine(0, y+beginY, newW - 1, y+beginY));

			for (int x = 0; x < newW; x++) {
				fp.putPixelValue(x+beginX, y+beginY, row_F[x]);
			}
		}

		// Traiter les colonnes de l'image résultant du traitement des
		// lignes
		for (int x = 0; x < newW; x++) {

			double[] col_f = new double[newW];
			double[] col_F = new double[newW];

			for (int y = 0; y < newH; y++) {
				col_f[y] = fp.getPixelValue(beginX+x, beginY+y);
			}

			col_F = DCT1D.inverseDCT(col_f);

			for (int y = 0; y < newW; y++) {
				fp.putPixelValue(beginX+x, beginY+y, col_F[y]);
			}
		}
	}
}