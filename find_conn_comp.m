function [cX,cY,bb,L,areas,s3] = find_conn_comp(image) 

image=imcomplement(image);
CC = bwconncomp(image);
L = labelmatrix(CC);
s = regionprops(CC,'Area');
s1= regionprops(CC,'Centroid');
s2= regionprops(CC,'BoundingBox');  
s3= regionprops(CC,'Image');  

    
areas=cat(1,s.Area);
centroids = cat(1, s1.Centroid);
cX=centroids(:,1); 
cY=centroids(:,2);
bb=cat(1,s2.BoundingBox);

figure,imshow(label2rgb(L)); %displaying image with its labels