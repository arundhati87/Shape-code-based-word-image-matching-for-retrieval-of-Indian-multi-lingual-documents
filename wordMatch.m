function wordMatch(im,bb,buck,label,lcnt,cX,cY)
fid=fopen('query.txt','r');
query_tx = fgets(fid);
fid1=fopen('missingsift.txt','w');
counter=0;
pquery=0;
%checking each query word one by one
while ischar(query_tx)
%checking for each character from query word
%determining query length
len=0;
while len<length(query_tx) && ((query_tx(len+1)<123 && query_tx(len+1)>96) || (query_tx(len+1)<91 && query_tx(len+1)>64) || (query_tx(len+1)<58 && query_tx(len+1)>47))
    len=len+1;
end
%%%%%%%
  qlen=len;
  if qlen>3
     qlen=round(qlen*0.8);
  end
  hqlen=int32(len/2);
  visited=0;
  for i= 1:hqlen
    class1=setLabel(query_tx(i));
    len1=buck(class1+1,1);
    len1=3*len1+1;
    for ch1=4:3:len1
        if i==1
           missing=[];
           Mcnt=0;
           missingbb=zeros(hqlen,4);
           missingbbin=0;
        else
           missing=[];
           Mcnt=0;
           missingbb=zeros(hqlen,4);
           missingbbin=0;
           for Min=1:i-1
               Mcnt=Mcnt+1;
               missingbbin=missingbbin+1;
               missing(Mcnt)=missingbbin;
               Mcnt=Mcnt+1;
               missing(Mcnt)=Min;
               bbin=buck(class1+1,ch1);
               v1=bb(bbin,1)-5*(i-Min)*bb(bbin,3);
               v2=bb(bbin,2)-2*bb(bbin,4);
               v3=5*bb(bbin,3);
               v4=5*bb(bbin,4);
               missingbb(missingbbin,1)=v1;
               missingbb(missingbbin,2)=v2;
               missingbb(missingbbin,3)=v3;
               missingbb(missingbbin,4)=v4;
           end
        end
        %visited=0;
        x=[];
        y=[];
        [dist_sarr] = NearestNeighbour(label,lcnt,cX,cY,buck(class1+1,ch1),visited);
        visited=buck(class1+1,ch1);
        x(1)=cX(buck(class1+1,ch1));
        y(1)=cY(buck(class1+1,ch1));
        count=1;
        %index=1;
        distnn=0;
        [x,y,count,missing,Mcnt,missingbb]=nextmatch(buck(class1+1,ch1),bb,label,lcnt,cX,cY,dist_sarr,query_tx,len,i,count,visited,qlen,x,y,missing,Mcnt,missingbb,missingbbin,distnn);
        if length(x)>1 && count>=qlen
            in=0;
            lx=length(x);
            for in=3:3:lx
                x1=x(in-2:in);
                y1=y(in-2:in);
                %[xs,ys]=smoothLine(x1,y1);
                plot(x1,y1,'og-','LineWidth',2);
                %hold on;
                %plot(xs,ys,'g-','LineWidth',3);
            end
            if rem(lx,3)~=0
                x1=x(lx-2:lx);
                y1=y(lx-2:lx);
               %[xs,ys]=smoothLine(x1,y1);
                plot(x1,y1,'og-','LineWidth',2);
                %hold on;
                %plot(xs,ys,'g-','LineWidth',3); 
            end
        elseif count>=hqlen
            for k=1:2:Mcnt
                filnam = ['doc',num2str(counter),'.pgm'];
                kin=missing(k);
                qin=missing(k+1);
                simg=[missingbb(kin,1),missingbb(kin,2),missingbb(kin,3),missingbb(kin,4)]; 
                subImage = imcrop(im, simg);
                if any(any(subImage))
                   rectangle('Position',simg,'LineWidth',3);
                   imwrite(subImage,filnam); 
                   pquery=pquery+1;
                   fprintf(fid1,'\n%d,%d,%d,%c,%s',pquery,qlen,count,query_tx(qin),filnam);
                   counter=counter+1;
                end
            end
        end
    end
 end
    query_tx = fgets(fid);
end
fclose(fid1);