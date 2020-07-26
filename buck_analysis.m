function buck_analysis(label,cX,cY,classin,buck)
class=setLabel(query_tx(classin-2));
classnext=setLabel(query_tx(classin-1));
class2next=setLabel(query_tx(classin));
len=length(buck(class+1));
for ch=1:3:len
    [minCor,minCor2] = NearestNeighbour(label,cX,cY,buck(class+1,ch+2));
end