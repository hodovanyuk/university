function [key] = compare(A,str)
key = 0;
for i=1:length(A)
    key = strcmp(A(i),str);
    if key
       break; 
    end
end
