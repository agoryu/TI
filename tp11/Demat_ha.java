
import ij.ImagePlus;
import ij.ImageStack;
import ij.plugin.filter.Convolver;
import ij.plugin.filter.PlugInFilter;
import ij.process.ByteProcessor;
import ij.process.ImageProcessor;

public class Demat_ha implements PlugInFilter {

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
		
		// Déclaration d'un noyau et d'un objet Convolver pour la convolution
		float[] kernel = {1,2,1 , 2,4,2 , 1,2,1};
		for (int i=0;i<kernel.length;i++) {
		    kernel[i]=kernel[i]/4;
		}
		ImageProcessor red = cfa_samples(ip,0);
		ImageProcessor green = est_G_hamilton(ip);
		ImageProcessor blue = cfa_samples(ip,2);
		Convolver conv = new Convolver();
		conv.setNormalize(false);	// SANS normalisation (par défaut, convolve() normalise)
		// Composante R estimée par interpolation bilinéaire grâce à la convolution
		conv.convolve(red,kernel,3,3);
		conv.convolve(blue,kernel,3,3);
		
		samples_stack.addSlice("rouge", red);
		samples_stack.addSlice("green", green);
		samples_stack.addSlice("bleu", blue);

		// Création de l'image résultat
		ImagePlus cfa_samples_imp = imp.createImagePlus();
		cfa_samples_imp.setStack("couleur CFA", samples_stack);
		cfa_samples_imp.show("stack cfa");

	}
	
	ImageProcessor est_G_hamilton(ImageProcessor cfa_ip) {
		ImageProcessor est_ip = cfa_ip.duplicate();
		
		width = imp.getWidth();
		height = imp.getHeight();

		for (int y = 0; y < height; y += 2) {
			for (int x = 1; x < width; x += 2) {
				int gm10 = cfa_ip.getPixel(x-1,y)&0xff;
				int g10 = cfa_ip.getPixel(x+1,y)&0xff;
				int r = cfa_ip.getPixel(x,y)&0xff;
				int rm20 = cfa_ip.getPixel(x-2,y)&0xff;
				int r20 = cfa_ip.getPixel(x+2,y)&0xff;
				int deltaX = Math.abs(gm10 - g10) + Math.abs(2 * r - rm20 - r20);
				
				int g0m1 = cfa_ip.getPixel(x,y-1)&0xff;
				int g01 = cfa_ip.getPixel(x,y+1)&0xff;
				int r0m2 = cfa_ip.getPixel(x,y-2)&0xff;
				int r02 = cfa_ip.getPixel(x,y+2)&0xff;
				int deltaY = Math.abs(g0m1 - g01) + Math.abs(2 * r - r0m2 - r02);
				
				int pixel_value = 255;
				if(deltaX < deltaY) {
					pixel_value = (gm10 + g10)/2 + (2 * r - rm20 - r20)/4;
				} else if(deltaX > deltaY) {
					pixel_value = (g0m1 + g01)/2 + (2 * r - r0m2 - r02)/4;
				} else if(deltaX == deltaY) {
					pixel_value = (g0m1 + g01 + gm10 + g10)/4 + (4 * r - r0m2 - rm20 - r20 - r02)/8;
				}
				est_ip.putPixel(x, y, pixel_value);
				
			}
		}
		
		for (int y = 1; y < height; y += 2) {
			for (int x = 0; x < width; x += 2) {
				int gm10 = cfa_ip.getPixel(x-1,y)&0xff;
				int g10 = cfa_ip.getPixel(x+1,y)&0xff;
				int b = cfa_ip.getPixel(x,y)&0xff;
				int bm20 = cfa_ip.getPixel(x-2,y)&0xff;
				int b20 = cfa_ip.getPixel(x+2,y)&0xff;
				int deltaX = Math.abs(gm10 - g10) + Math.abs(2 * b - bm20 - b20);
				
				int g0m1 = cfa_ip.getPixel(x,y-1)&0xff;
				int g01 = cfa_ip.getPixel(x,y+1)&0xff;
				int b0m2 = cfa_ip.getPixel(x,y-2)&0xff;
				int b02 = cfa_ip.getPixel(x,y+2)&0xff;
				int deltaY = Math.abs(g0m1 - g01) + Math.abs(2 * b - b0m2 - b02);
				
				int pixel_value = 255;
				if(deltaX < deltaY) {
					pixel_value = Math.abs(gm10 + g10)/2 + Math.abs(2 * b - bm20 - b20)/4;
				} else if(deltaX > deltaY) {
					pixel_value = Math.abs(g0m1 + g01)/2 + Math.abs(2 * b - b0m2 - b02)/4;
				} else if(deltaX == deltaY) {
					pixel_value = (g0m1 + g01 + gm10 + g10)/4 + (4 * b - b0m2 - bm20 - b20 - b02)/8;
					
				}
				est_ip.putPixel(x, y, pixel_value);
			}
		}
		
	    return (est_ip);
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
					//int green = (int) (pixel_value & 0x00ff00) >> 8;
					cfa_ip.putPixel(x, y, pixel_value);
				}
			}
			for (int y = 1; y < height; y += 2) {
				for (int x = 1; x < width; x += 2) {
					pixel_value = ip.getPixel(x, y);
					//int green = (int) (pixel_value & 0x00ff00) >> 8;
					cfa_ip.putPixel(x, y, pixel_value);
				}
			}
		}
		else if(channel == 0) {
			// Échantillons R
			for (int y = 0; y < height; y += 2) {
				for (int x = 1; x < width; x += 2) {
					pixel_value = ip.getPixel(x, y);
					//int red = (int) (pixel_value & 0xff0000) >> 16;
					cfa_ip.putPixel(x, y, pixel_value);
				}
			}
		}
		else if(channel == 2) {
			// Échantillons B
			for (int y = 1; y < height; y += 2) {
				for (int x = 0; x < width; x += 2) {
					pixel_value = ip.getPixel(x, y);
					//int blue = (int) (pixel_value & 0x0000ff);
					cfa_ip.putPixel(x, y, pixel_value);
				}
			}
		}

		return cfa_ip;
	}

}
