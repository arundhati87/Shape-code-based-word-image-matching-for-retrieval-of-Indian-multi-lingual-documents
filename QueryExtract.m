function QueryExtract(label,bb,im)

fid=fopen('query.txt');
query_tx = fgets(fid);

%checking each query word one by one
while ischar(query_tx)
    
    %checking for each character from query word
    for i= 1:length(query_tx)
        found=0;
        class=setLabel(query_tx(i));
        
        %to take query from labelled connected components from image
        count=0;
        for j=1:length(label)
            class_temp=label(j,1);
            if class == class_temp
                simg=[bb(label(j,2),1),bb(label(j,2),2),bb(label(j,2),3),bb(label(j,2),4)];
                subImage = imcrop(im, simg);
                filnam = ['query',num2str(class_temp),'-',num2str(count),'.pgm'];
                imwrite(subImage,filnam); 
                found=1;
                count=count+1;
                %break;
            end
        end
        %to take query from labelled connected components from image-done
        
        %If not found from labelled compoenet take from ideal dataset
        if found==0
            if double(query_tx(i))>64 && double(query_tx(i))<91
                query=[query_tx(i),'u'];
            elseif double(query_tx(i))>96 && double(query_tx(i))<123
                query=[query_tx(i),'l'];
            else
                query=query_tx(i);
            end
            DirName=['C:\Users\kutu\Documents\MATLAB\FourierMellin\arial\',query,'*.tif'];
            [~,~,Names] = DIRR(DirName,'name');
            for n = 1:length(Names)
                query_im = imread(char( Names(n)) );
                filnam = ['query',query,'.pgm'];
                imwrite(query_im,filnam); 
            end
        end
        %If not found from labelled component take from ideal dataset-done
    end
    
query_tx = fgets(fid);
end
%checking each query word one by one-done

fclose(fid);