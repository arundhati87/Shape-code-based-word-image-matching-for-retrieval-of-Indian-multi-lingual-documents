% Fonction d'extraction de l'imagette centrée a partir d'une image
% En sortie, l'imagette est centrée sur le centre de gravité de la (les) forme contenue
% Entrées : 
%   - Le tableau Bitmap de l'image
% Sortie : 
%   - Le tableau Bitmap centrée sur le centre de gravité dans 
%     une fenetre carrée de taille minimale pour y faire rentrer la forme
%
% LA FORME EST A 1 DANS L'IMAGE RETOURNEE
% Auteur : 
%   - Sebastien Adam
% Version : 
%   - v2.0 : le 27/06/09
% Etat : 
%   - ok
%****************************************************************************

function CenteredBitmap = ExtraitImagetteCentree(Bitmap)

%  Recopie de l'image dans un tableau agrandi
%  *******************************************

[L C]=size(Bitmap);
BitmapAgrandi=zeros(L+2,C+2);
BitmapAgrandi(2:L+1,2:C+1)=Bitmap(1:L,1:C);

L=L+2;
C=C+2;

% Calcul des histogrammes de projection pour détection du centre de gravite
%  *************************************************************************

for l=1:L,
    histox(l) = sum(BitmapAgrandi(l,:));
end
for c=1:C,
    histoy(c) = sum(BitmapAgrandi(:,c));
end


% Recherche des limites de la formes à partir de l'histogramme

ind=1;
anax=find(histox~=0);
anay=find(histoy~=0);
px(1)=anax(1);
px(2)=anax(length(anax));
py(1)=anay(1);
py(2)=anay(length(anay));

histoCCx=zeros(1,(px(2)-px(1))+1);

for c=px(1):1:px(2)
    histoCCx(c-px(1)+1) = sum(BitmapAgrandi(c,py(1):1:py(2)));
end

posx=[px(1):1:px(2)]/sum(histoCCx);

histoCCy=zeros(1,(py(2)-py(1))+1);

for l=py(1):1:py(2)
    histoCCy(l-py(1)+1) = sum(BitmapAgrandi(px(1):1:px(2),l));
end

posy=[py(1):1:py(2)]/sum(histoCCy);

mux = round(histoCCx * posx');              % position du CDG dans l'image
muy = round(histoCCy * posy');              %


fid=fopen('newFile.txt', 'a+');
fprintf(fid,'coordonnees du centre de gravite dans l''image originale : %d %d\n',mux-1,muy-1);  
fclose(fid);

dx1=mux-px(1);
dx2=px(2)-mux;
dy1=muy-py(1);
dy2=py(2)-muy;
dx=px(2)-px(1);
dy=py(2)-py(1);

xsize=max(dx1,dx2);
ysize=max(dy1,dy2);

maxsize=max(xsize,ysize);

CenteredBitmap=zeros(2*maxsize+1,2*maxsize+1); 



CenteredBitmap(maxsize-dx1+1:maxsize+dx2+1,maxsize-dy1+1:maxsize+dy2+1)=BitmapAgrandi(px(1):1:px(2),py(1):1:py(2));

