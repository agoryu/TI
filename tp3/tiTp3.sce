stacksize('max');
exec ('tiTp3Fonction.sci');

img_name = "Lenna.png";

//img_inf = imfinfo(img_name);
img = imread(img_name);

//disp(img_inf);
//disp(size(img));
//disp(length(img));

//layer_red = img(:,:,1);
//layer_green = img(:,:,2);
//layer_blue = img(:,:,3);

//img_red = img;
//img_red(:,:,2) = zeros(img_red(:,:,2));
//img_red(:,:,3) = zeros(img_red(:,:,3));

//img_green = img;
//img_green(:,:,1) = zeros(img_green(:,:,1));
//img_green(:,:,3) = zeros(img_green(:,:,3));

//img_blue = img;
//img_blue(:,:,1) = zeros(img_blue(:,:,1));
//img_blue(:,:,2) = zeros(img_blue(:,:,2));

sousEch = sousEchant(img,4);

imshow(sousEch);
