import ij.ImagePlus;
import ij.plugin.filter.PlugInFilter;
import ij.process.FloatProcessor;
import ij.process.ImageProcessor;
import DCT.DCT2D;

/**
 * 
 * @author gaetan
 */
public class DCT_plugin implements PlugInFilter {

	// ATRIBUTES //

	/**
	 * Fenêtre contenant l'image de référence
	 */
	private ImagePlus imp;

	/**
	 * Largeur de la fenêtre
	 */
	private int width;

	/**
	 * Hauteur de la fenêtre
	 */
	private int height;

	// METHODS //

	/**
	 * Méthodes de configuration du plug-in, appelé en première. L'image sur
	 * laquelle nous travaillons est l'image de référence en couleur.
	 */
	public int setup(String arg, ImagePlus imp) {
		this.imp = imp;
		return PlugInFilter.DOES_ALL;
	}

	public void run(ImageProcessor ip) {

		// Lecture des dimensions de la fenêtre
		width = imp.getWidth();
		height = imp.getHeight();

		FloatProcessor fp = ip.convertToFloatProcessor();
		fp.add(-128);
		DCT2D.forwardDCT(fp);

		ImagePlus frame = new ImagePlus("DCT", fp);
		frame.show();
	}

}