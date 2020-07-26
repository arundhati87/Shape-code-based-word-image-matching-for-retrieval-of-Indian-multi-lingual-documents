function [max,max2] = find_maxs(dec_val) 
max=-1;
max2=-1;
for index=1:length(dec_val)
    if dec_val(index)>max
       max2=max;
       max=dec_val(index);
    elseif dec_val(index)>max2
       max2=dec_val(index);
    end
end