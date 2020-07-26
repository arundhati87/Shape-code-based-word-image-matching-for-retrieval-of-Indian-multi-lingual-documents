function Run(DirName) 
%Run('C:\set\*.tiff')
[~,~,Names] = DIRR(DirName,'name');

%call svm training for modelling from labelled dataset
%model=load_model('label.txt','set.txt');
%load('model.mat');
% load('model_abf.mat');
% model=model_abf;
%model=load('model.mat');

for n = 1:length(Names)
I = imread(char( Names(n)));
%I = im2bw(I, graythresh(I));
% myfilter = fspecial('gaussian',[3 3], 0.5);
% I = imfilter(I, myfilter, 'replicate');
%[~, name, ~] = fileparts(char( Names(n)));
%filnam = [name,num2str(n),'.bmp'];
imwrite(I, 'P.pbm');
system('QAtextGraphicSeparation.exe -in P.pbm -outxt P.text.pbm -outg P.graphx.pbm -outu P_un.pbm -prune 3 -area 3 -elbbox 20 -elmaer 2 -dmaer .6');
 
 IT1 = imread('P.text.pbm');
 IT2 = imread('P_un.pbm');
 
 IT3 = imcomplement(IT1) + imcomplement(IT2);
 imwrite(imcomplement(IT3), 'P.Text.Result.pbm');
 system('QAtextExtraction.exe -in P.text.pbm -outxt P.bbox.txt -outbb P.bbox.dxf -char 2.5 -hough 0.2');
 
% %calling connected component analysis after text - graphics seperation
%TestConnComp('C:\Users\kutu\Documents\MATLAB\map_text_retrieval\P.Text.Result*.pbm',model,'C:\Users\kutu\Documents\MATLAB\map_text_retrieval\P.graphx*.pbm',n,I);
TestConnComp('C:\Users\admin\Documents\MATLAB\map_text_retrieval\?.pbm','C:\Users\admin\Documents\MATLAB\map_text_retrieval\P.graphx*.pbm',n);

end

