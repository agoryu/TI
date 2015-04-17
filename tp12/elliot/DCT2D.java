
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
		for (int y = beginY; y < newH + beginY; y++) {

			double[] row_F = DCT1D.forwardDCT(fp.getLine(beginX, y, beginX + newW - 1, y));

			for (int x = beginX; x < newW + beginX; x++) {
				fp.putPixelValue(x, y, row_F[x - beginX]);
			}
		}

		// Traiter les colonnes de l'image résultant du traitement des
		// lignes
		for (int x = beginX; x < newW + beginX; x++) {

			double[] col_f = new double[newH];
			double[] col_F = new double[newH];

			for (int y = beginY; y < newH + beginY; y++) {
				col_f[y - beginY] = fp.getPixelValue(x, y);
			}

			col_F = DCT1D.forwardDCT(col_f);

			for (int y = beginY; y < newH + beginY; y++) {
				fp.putPixelValue(x, y, col_F[y - beginY]);
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
		for (int y = beginY; y < newH + beginY; y++) {

			double[] row_F = DCT1D.inverseDCT(fp.getLine(beginX, y, beginX + newW - 1, y));

			for (int x = beginX; x < newW + beginX; x++) {
				fp.putPixelValue(x, y, row_F[x - beginX]);
			}
		}

		// Traiter les colonnes de l'image résultant du traitement des
		// lignes
		for (int x = beginX; x < newW + beginX; x++) {

			double[] col_f = new double[newH];
			double[] col_F = new double[newH];

			for (int y = beginY; y < newH + beginY; y++) {
				col_f[y - beginY] = fp.getPixelValue(x, y);
			}

			col_F = DCT1D.inverseDCT(col_f);

			for (int y = beginY; y < newH + beginY; y++) {
				fp.putPixelValue(x, y, col_F[y - beginY]);
			}
		}
	}
}