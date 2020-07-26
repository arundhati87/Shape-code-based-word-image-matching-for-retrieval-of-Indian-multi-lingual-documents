function [im] = erase_component(str_label,cX,L,im) 

for len = 1:length(cX)
       if ~strcmp(str_label(len),'*')
         [r, c] = find(L==len);
         for in = 1:length(r)
            im(r(in),c(in))=0;
         end
       end
end
