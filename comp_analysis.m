function [cX,cY,bb,L,label,str_label,buck] = comp_analysis(buck,im,model,img) 
%function comp_analysis(im,index) 
[cX,cY,bb,L,areas] = find_conn_comp(im);  
%figure,imshow(label2rgb(L));%find_nearestNeighbours(cX,cY);
figure,imshow(img);
str_label(1:length(cX))='*';
label=zeros(50,2);
count=0;
fid=fopen('accuracy.txt','w');
hold on
for i= 1:length(cX)
    if areas(i)>16
        %extract each connected component from its bounding box to store in the disk 
        subImage = sub_image(bb,i,im); 
        subImage=imcomplement(subImage);
        delete('test.tiff');
        filnam = ['test','.tiff']; 
        %filnam = ['test',num2str(index),num2str(i),'.tiff'];
        imwrite(subImage,filnam);  
        [~, ~, ext] = fileparts(filnam); 
        %extracting fourier-mellin feature for each connected component and
        %testing its class using svm classifier
        arg=['C:\Users\kutu\Documents\MATLAB\map_text_retrieval\*',ext];
        Fourier_mellin(arg);  
        %Angle_feature(arg);
        testing_label_vector=39;
        testing_instance_matrix = load('newFeature.txt');
        %testing_instance_matrix = load('set.txt');
        [predicted_label, ~, dec_val] = svmpredict(testing_label_vector, testing_instance_matrix, model,'-b 1');
        [max,max2]= find_maxs(dec_val);
        diff=(max-max2);
        if max>0.3
           str_label(i)=setChar(predicted_label);
           buck=bucket(buck,predicted_label,cX(i),cY(i),i);
           %if max>0.5
           count=count+1;
           label(count,1)=predicted_label;
           label(count,2)=i;
           %end
           %l=[str_label(i),':',max,'-',max2];
           text(cX(i),cY(i),str_label(i),'Color','r','FontSize',10);
           %text(cX(i),cY(i),l);
           fprintf(fid,'\nMax:::%c,%g,%g,%g',str_label(i),max,max2,diff);
        end
    end
end
%QueryExtract(label,bb,im);
wordMatch(im,bb,buck,label,count,cX,cY);
hold off
fclose(fid);