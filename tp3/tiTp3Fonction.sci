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
    newLenX = s(1) * n;
    newLenY = s(2) * n;
    newImg = zeros(newLenX,newLenY);
    for raw=1:newLenY
        for col=1:newLenX
            for c=1:s(3)
                if modulo(n,2) == 0 then
                    tabMoyenne = [img(col+1,raw,c) img(col-1,raw,c) img(col,raw+1,c) img(col,raw-1,c)]
                    newImg(col,raw,c) = mean(tabMoyenne);    
                else
                    newImg(col,raw,c) = img(col-((n-1)*col),raw-((n-1)*raw),c);
                end;
            end;
        end;
    end;
endfunction;

function [quant] = quantification(img, vmin, vmax)
    im = im2double(img);
    quant = im * vmax - vmin;
endfunction;

function [periode] = calcPeriode(img, vmin, vmax)
    moy = vmax - vmin;
    i = find(img(:, 1, 1) == moy);
    periode = size(img(:, 1, 1)) / size(i);
endfunction;
