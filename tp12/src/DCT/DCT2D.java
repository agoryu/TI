package DCT;


import ij.process.FloatProcessor; // Pour classe Float Processor

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

		final int W = fp.getWidth();
		final int H = fp.getHeight();

		// Traiter les lignes
		for (int y = 0; y < H; y++) {

			double[] row_F = DCT1D.forwardDCT(fp.getLine(0, y, W - 1, y));

			for (int x = 0; x < W; x++) {
				fp.putPixelValue(x, y, row_F[x]);
			}
		}

		// Traiter les colonnes de l'image résultant du traitement des
		// lignes
		for (int x = 0; x < W; x++) {

			double[] col_f = new double[W];
			double[] col_F = new double[W];

			for (int y = 0; y < H; y++) {
				col_f[y] = fp.getPixelValue(x, y);
			}

			col_F = DCT1D.forwardDCT(col_f);

			for (int y = 0; y < W; y++) {
				fp.putPixelValue(x, y, col_F[y]);
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

		// Traiter les lignes
		/* � compl�ter */

		// Traiter les colonnes de l'image r�sultant du traitement des lignes
		/* � compl�ter */
	}
}