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
