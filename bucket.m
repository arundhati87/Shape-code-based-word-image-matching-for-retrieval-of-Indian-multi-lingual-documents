function buck=bucket(buck,class,x,y,in)
if class==-1
   for i=1:40
       buck(i,1)=0;
       buck(i,2)=-1;
       buck(i,3)=-1;
       buck(i,4)=-1;
   end
else
    len=1+buck(class+1,1)*3;
    if len~=1
        buck(class+1,len+1)=x;
        buck(class+1,len+2)=y;
        buck(class+1,len+3)=in;
        buck(class+1,1)=buck(class+1,1)+1;
    else
       buck(class+1,1)=1;
       buck(class+1,2)=x;
       buck(class+1,3)=y; 
       buck(class+1,4)=in; 
    end
end