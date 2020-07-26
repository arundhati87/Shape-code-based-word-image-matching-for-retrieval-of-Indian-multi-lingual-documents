function [imatge_BN] = f_binaritza(imatge_orig)

% Binaritzo i nego

if (islogical(imatge_orig)==1)
        % la imatge es binaria, no faig res
        imatge_BN = imatge_orig;
    else
        if (isrgbimage(imatge_orig)==1)
            % la imatge es en color, la transformo a escala grisos
            imatge = rgb2gray(imatge_orig);  
        else
            % imatge en escala grisos
            imatge = imatge_orig;
        end
        
        
        level = graythresh(imatge);
        imatge_BN = im2bw(imatge,level);
        %figure,imshow(imatge_BN);
        
        %imatge_BN = f_binaritzacio(imatge);  
        imatge_BN = ~imatge_BN; 
        %figure; imshow(imatge_BN);
        %figure,imshow(imatge_BN);
    end
