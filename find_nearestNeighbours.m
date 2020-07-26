function [cor1,cor2] = find_nearestNeighbours(cX,cY) 
%finding 2 nearest neighbours of each component's centroid

cor1=zeros(length(cX)-1,2);
cor2=zeros(length(cX)-1,2);

for j = 1:length(cX)
     minDist=999;
     minDist2=999;
     for i = 1:length(cX)
         if i~=j 
             dist=( (cX(i)-cX(j))^2 + (cY(i)-cY(j))^2)^.5;
             if dist<minDist2
                  if dist>minDist
                       minDist2=dist;
                       cor2(j,1)=cX(i);
                       cor2(j,2)=cY(i);
                  else
                       minDist2=minDist;
                       minDist=dist;
                       cor2(j,1)=minCor(j,1);
                       cor2(j,2)=minCor(j,2);
                       cor1(j,1)=cX(i);
                       cor1(j,2)=cY(i);
                   end
              end
          end
    end
end

%plot centroid of each connected component
plot(cX(i),cY(i),'g*');

%plotting red line with nearest neighbour
x=[cX(i),cor1(i,1)];
y=[cY(i),cor1(i,2)];
plot(x,y,'--r','LineWidth',3);

%plotting blue line with 2nd nearest neighbour
x1=[cX(i),cor2(i,1)];
y1=[cY(i),cor2(i,2)];
plot(x1,y1,':b','LineWidth',3);

