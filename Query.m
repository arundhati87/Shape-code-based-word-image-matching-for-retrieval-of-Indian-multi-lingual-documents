function buck = Query(buck,label,bb,im,model)

I = imread('out.jpg') ;

%[cX,cY,~,L,~,str_label]=comp_analysis(I,model);
%imOr = erase_component(str_label,cX,L,I);

%wordMatch(cX,cY);



I = double(rgb2gray(I)/256) ;
[frames1,descriptors1] = sift(I, 'Verbosity', 1) ;

fid=fopen('query.txt');
query_tx = fgets(fid);

%checking each query word one by one
while ischar(query_tx)
    
    %checking for each character from query word
    for i= 1:length(query_tx)
        found=0;
        class=setLabel(query_tx(i));
        
        %to take query from labelled connected components from image
        for j=1:length(label)
            class_temp=setLabel(label(j,1));
            if class == class_temp
                subImage = sub_image(bb,label(j,2),im); 
                query_im = subImage;
                found=1;
                break;
            end
        end
        %to take query from labelled connected components from image-done
        
        %If not found from labelled compoenet take from ideal dataset
        if found==0
            if double(query_tx(i))>64 && double(query_tx(i))<91
                query=[query_tx(i),'-uc'];
            elseif double(query_tx(i))>96 && double(query_tx(i))<123
                query=[query_tx(i),'-lc'];
            else
                query=query_tx(i);
            end
            DirName=['C:\Users\UPalLab\Documents\MATLAB\idealdata\',query,'*.tif'];
            [~,~,Names] = DIRR(DirName,'name');
            for n = 1:length(Names)
                query_im = imread(char( Names(n)) );
            end
        end
        %If not found from labelled component take from ideal dataset-done
        
        %sift match
        [frames2,descriptors2] = sift(query_im, 'Verbosity', 1);
        matches = siftmatch(descriptors2, descriptors1);
        plotmatches(query_im,I,frames2,frames1,matches);
        %sift match-done
        
    end
    
query_tx = fgets(fid);
end
%checking each query word one by one-done

fclose(fid);