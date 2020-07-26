function [subImage] = sub_image(bb,i,im) 

simg=[bb(i,1),bb(i,2),bb(i,3),bb(i,4)];
rectangle('Position',simg,'LineStyle','--');
subImage = imcrop(im, simg);
subImage = imcomplement(subImage);
