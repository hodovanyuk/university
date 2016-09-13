function [i] = indexOf(A,str)
if compare(A,str)
    for i=1:length(A)
        key = strcmp(A(i),str);
        if key
           break; 
        end
    end
else
    i = 0;
end
