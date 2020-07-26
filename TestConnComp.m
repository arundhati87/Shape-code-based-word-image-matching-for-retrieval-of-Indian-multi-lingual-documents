%function TestConnComp(DirName,model,graphDir,index,img) %TestConnComp('C:\set\*.tiff')
function TestConnComp(DirName,graphDir,index)

[~,~,Names] = DIRR(DirName,'name');
[~,~,Names1] = DIRR(graphDir,'name');

for n = 1:length(Names)
    im = imread(char( Names(n)) ); 
    imgraph = imread(char( Names1(n)) );  
     buck(1:40)=-1;
     buck=bucket(buck,-1,-1,-1,-1);
    %find connected component,fourier-melling feature of each,svm
    %classifier and labelling with proper accuracy
    %[cX,~,~,L,~,str_label,buck]=comp_analysis(buck,im,model,img);
    %comp_analysis(im,index);
    %To erase a labelled connected components from text image 
    im=imcomplement(im);
    %im = erase_component(str_label,cX,L,im);
    %merge remaining text image with graphical portions
    IT3 = im;% + imcomplement(imgraph);
    imOr = imcomplement(IT3);
    imwrite(imOr, 'graph.pbm');
    % skeleton based analysis,vectorization,removing long graphical line
    % without junction point
    system('QAdist34Skeletonization.exe -in graph.pbm -out P.34skel.pbm -prune 3');
    system('QAvectorizationRW.exe -in P.34skel.pbm -out Pvector.dxf');
    %system('SkeletonJunctionAnalysis.exe');
    system('main.exe');%calling c code for junction point analysis & removal of long skeleton
    
    %%%%%%%%%%%%NEWLY ADDED FOR BANGLA SCRIPT%%%%%%%%%%%%%
    im1=imread('out.jpg');
    im1 = im2bw(im1, graythresh(im1));
    [cX,~,bb,L,~,~] = find_conn_comp(im1);  
    for i= 1:length(cX)
        if bb(i,3) < 10 || bb(i,4)<10
            [r, c] = find(L==i);
            for in = 1:length(r)
                im1(r(in),c(in))=1;
            end
        end
    end
    imwrite(im1,'s1.bmp');
    [cX,~,~,L,~,s3] = find_conn_comp(im1); 
    for i= 1:length(cX)
        pl=cat(1,s3(i).Image);
        [rows,cols]=size(pl);
        v=diag(pl);
        pixntx=0;
        in=int8(rows/2);
        for iy= 1:cols-3
            if pixntx==0 && ((pl(in,iy)==1 && pl(in,iy+1)==1 && pl(in,iy+2)==0 && pl(in,iy+3)==0))
               pixntx=1;
               iy=iy+1;
            elseif pixntx==1 && ((pl(in,iy)==0 && pl(in,iy+1)==0 && pl(in,iy+2)==1 && pl(in,iy+3)==1) || (pl(in,iy)==1 && pl(in,iy+1)==1 && pl(in,iy+2)==0 && pl(in,iy+3)==0))
               pixntx=pixntx+1;
               break;
            end 
        end
        in=int8(cols/2);
        pixnty=0;
        for ix= 1:rows-3
            if pixnty==0 && ((pl(ix,in)==1 && pl(ix+1,in)==1 && pl(ix+2,in)==0 && pl(ix+3,in)==0))
               pixnty=1;
               ix=ix+1;
            elseif pixnty==1 && ((pl(ix,in)==0 && pl(ix+1,in)==0 && pl(ix+2,in)==1 && pl(ix+3,in)==1) || (pl(ix,in)==1 && pl(ix+1,in)==1 && pl(ix+2,in)==0 && pl(ix+3,in)==0))
               pixnty=pixnty+1;
               break;
            end 
        end
        pixntd=0;
        for i=1:length(v)-1
            if pixntd==0 && (v(i)==1 && v(i+1)==0)
               pixntd=1;
            elseif pixntd==1 && ((v(i)==0 && v(i+1)==1) || (v(i)==1 && v(i+1)==0))
               pixntd=pixntd+1;
               break;
            end 
        end
        if pixntx<2 && pixnty<2 && pixntd<2
           [r, c] = find(L==i);
            for in = 1:length(r)
                im1(r(in),c(in))=1;
            end 
        end
    end
    imwrite(im1,'s2.bmp');
%         else
%             iny=bb(i,2);
%             for inx = bb(i,1):(bb(i,1)+bb(i,3))
%                 subImage = sub_image(bb,i,im); 
%                 subImage=imcomplement(subImage);
%                 delete('test.tiff');
%                 filnam = ['test','.tiff']; 
%                 %filnam = ['test',num2str(index),num2str(i),'.tiff'];
%                 imwrite(subImage,filnam);  
%                 [~, ~, ext] = fileparts(filnam); 
%                 arg=['C:\Users\kutu\Documents\MATLAB\map_text_retrieval\*',ext];
%              end
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    %for sift matching of remaining unlabelled characters using query image
%      buck=Query(buck,label,bb,im,model);
%      buck_analysis(buck);
        
end

