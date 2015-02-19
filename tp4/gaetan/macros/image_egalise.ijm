// Macros qui calcul image égalisé

// Version: 0.1
// Date: 13/02/2015
// Author: G. DEFLANDRE
 
macro "image_egalise"{

	// Ouvrir image active
	image = getImageID();
	
	ret = dire("Bonjour");
	
	print("toto", ret);

}

function hist() {
	return ;
}

function hist_cumul(text) {
	print(text);
	return 42;
}
