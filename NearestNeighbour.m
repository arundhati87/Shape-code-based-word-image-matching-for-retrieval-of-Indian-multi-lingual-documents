function [dist_sarr] = NearestNeighbour(label,lcnt,X,Y,in2,visited)

%finding small components and their nearest neighbours
dist_arr=[999,999,999];
dist_sarr=[999,999,999];
count=0;
%index=-1;
for i = 1:lcnt
    in1=label(i,2);
    l=label(i,1);
    flag=0;
    if visited~=0
       for n=1:length(visited)
           if(in1==visited(n))
             flag=1;
             break;
           end
       end
    end
    if in1~=in2 && flag~=1      
       dist=( (X(in1)-X(in2))^2 + (Y(in1)-Y(in2))^2)^.5;
	   count=count+1;
	   dist_arr(count,1)=dist;
	   dist_arr(count,2)=in1;
	   dist_arr(count,3)=l;
   end
end
dist_sarr=sortrows(dist_arr,1);
