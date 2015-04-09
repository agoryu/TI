
import ij.ImagePlus;
import ij.ImageStack;
import ij.plugin.filter.PlugInFilter;
import ij.process.ByteProcessor;
import ij.process.ImageProcessor;

public class Sample_cfa implements PlugInFilter {

	ImagePlus imp; // Fenêtre contenant l'image de référence
	int width; // Largeur de la fenêtre
	int height; // Hauteur de la fenêtre

	public int setup(String arg, ImagePlus imp) {
		this.imp = imp;
		return PlugInFilter.DOES_8G;
	}

	public void run(ImageProcessor ip) {
		// Lecture des dimensions de la fenêtre
		width = imp.getWidth();
		height = imp.getHeight();
		
		// Calcul des échantillons de chaque composante de l'image CFA
		ImageStack samples_stack = imp.createEmptyStack();
		samples_stack.addSlice("rouge", cfa_samples(ip,0));	// Composante R
		samples_stack.addSlice("vert", cfa_samples(ip,1));// Composante G
		samples_stack.addSlice("bleu", cfa_samples(ip,2));	// Composante B

		// Création de l'image résultat
		ImagePlus cfa_samples_imp = imp.createImagePlus();
		cfa_samples_imp.setStack("couleur CFA", samples_stack);
		cfa_samples_imp.show("stack cfa");

	}

	ImageProcessor cfa_samples(ImageProcessor ip, int channel) {

		// Image couleur de référence et ses dimensions
		width = imp.getWidth();
		height = imp.getHeight();

		int pixel_value = 0; // Valeur du pixel source
		ImageProcessor cfa_ip = new ByteProcessor(width, height); // Image CFA
																	// générée

		// Échantillons G
		if(channel == 1) {
			for (int y = 0; y < height; y += 2) {
				for (int x = 0; x < width; x += 2) {
					pixel_value = ip.getPixel(x, y);
					cfa_ip.putPixel(x, y, pixel_value);
				}
			}
			for (int y = 1; y < height; y += 2) {
				for (int x = 1; x < width; x += 2) {
					pixel_value = ip.getPixel(x, y);
					cfa_ip.putPixel(x, y, pixel_value);
				}
			}
		}
		else if(channel == 0) {
			// Échantillons R
			for (int y = 0; y < height; y += 2) {
				for (int x = 1; x < width; x += 2) {
					pixel_value = ip.getPixel(x, y);
					cfa_ip.putPixel(x, y, pixel_value);
				}
			}
		}
		else if(channel == 2) {
			// Échantillons B
			for (int y = 1; y < height; y += 2) {
				for (int x = 0; x < width; x += 2) {
					pixel_value = ip.getPixel(x, y);
					cfa_ip.putPixel(x, y, pixel_value);
				}
			}
		}

		return cfa_ip;
	}

}
