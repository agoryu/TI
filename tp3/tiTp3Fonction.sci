function [newImg] = sousEchant(img,n)
    s = size(img);
    newLenX = s(1)/n;
    newLenY = s(2)/n;
    newImg = zeros(newLenX,newLenY);
    for raw=1:newLenY
        for col=1:newLenX
            for c=1:s(3)
                newImg(col,raw,c) = img(col*n,raw*n,c);
            end;
        end;
    end;
endfunction;

function [newImg] = surEchant(img,n)
    s = size(img);
    lenX = s(1);
    lenY = s(2);
    newImg = zeros(lenX * n,lenY * n, 3);
    for raw=1:lenY
        for col=1:lenX
            for c=1:s(3)
                for i=0:(n-1)
                    for j=0:(n-1)
                        x = ((col*n)-1) + i;
                        y = ((raw*n)-1) + j;
                        newImg(x, y, c)
                    end;
                end;
            end;
        end;
    end;
endfunction;

function [quant] = quantification(img, m)
    maxVal = max(img);
    minVal = min(img);
    quant = ((maxVal - minVal) / m) / (maxVal - minVal);
endfunction;

function [newImg] = quantificationImage(img, composante, nbBit)
    m = 2^nbBit;
    pas = quantification(im, m);
    im2double(im);
    
    for i=1:m
        
    end;     
endfunction

function [periode] = calcPeriode(img, vmin, vmax)
    moy = vmax - vmin / 2;
    i = find(img(:, 1, 1) == moy);
    periode = size(img(:, 1, 1)) / size(i);
endfunction;
