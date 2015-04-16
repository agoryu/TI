import ij.ImagePlus;
import ij.plugin.filter.PlugInFilter;
import ij.process.Blitter;
import ij.process.ByteProcessor;
import ij.process.FloatProcessor;
import ij.process.ImageProcessor;

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
	
	final static int BLOCK_SIZE = 8;
	
	public final static int[][] QY = {
	    {16, 12, 14, 14,  18,  24,  49,  72},
	    {11, 12, 13, 17,  22,  35,  64,  92},
	    {10, 14, 16, 22,  37,  55,  78,  95},
	    {16, 19, 24, 29,  56,  64,  87,  98},
	    {24, 26, 40, 51,  68,  81, 103, 112},
	    {40, 58, 57, 87, 109, 104, 121, 100},
	    {51, 60, 69, 80, 103, 113, 120, 103},
	    {61, 55, 56, 62,  77,  92, 101,  99}
	};
	
	private static ByteProcessor bpQuantification = new ByteProcessor(BLOCK_SIZE, BLOCK_SIZE);

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
		bpQuantification.setIntArray(QY);

		//Compression
		FloatProcessor fp = ip.convertToFloatProcessor();
		fp.add(-128);
		
		/*for(int y=0; y<BLOCK_SIZE; y++) {
			for(int x=0; x<BLOCK_SIZE; x++) {
				fp.setRoi(x*(width/BLOCK_SIZE), y*(height/BLOCK_SIZE), width/BLOCK_SIZE, height/BLOCK_SIZE);
				DCT2D.forwardDCT(fp);
				fp.copyBits(bpQuantification, 0, 0, Blitter.DIVIDE);
			}
		}*/
		
		DCT2D.forwardDCT(fp);
		fp.copyBits(bpQuantification, 0, 0, Blitter.DIVIDE);
		
		//arrondi
		for(int y=0; y<width; y++) {
			for(int x=0; x<height; x++) {
				int value = Math.round(fp.getf(x, y));
				fp.putPixelValue(x, y, value);
			}
		}

		ImagePlus frame = new ImagePlus("DCT", fp);
		frame.show();
		
		//Decompression
		FloatProcessor fp2 = new FloatProcessor(fp.getFloatArray());
		/*for(int y=0; y<BLOCK_SIZE; y++) {
			for(int x=0; x<BLOCK_SIZE; x++) {
				fp2.setRoi(x*(width/BLOCK_SIZE), y*(height/BLOCK_SIZE), width/BLOCK_SIZE, height/BLOCK_SIZE);
				fp2.copyBits(bpQuantification, 0, 0, Blitter.MULTIPLY);
				DCT2D.inverseDCT(fp2);
			}
		}*/
		fp2.copyBits(bpQuantification, 0, 0, Blitter.MULTIPLY);
		DCT2D.inverseDCT(fp2);
		fp2.add(128);
		
		ImagePlus frame2 = new ImagePlus("DCT2", fp2);
		frame2.show();
	}

}