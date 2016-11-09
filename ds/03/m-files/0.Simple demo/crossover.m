function [X3,X4]=crossover(X1,X2)

if (X1 < 0)
    X1 = uint16(abs(X1));
    X1 = bitxor(X1,32767);
    X1 = X1 + 1;
    X1 = bitor(X1,32768);
else
    X1 = uint16(X1);
end
if (X2 < 0)
    X2 = uint16(abs(X2));
    X2 = bitxor(X2,32767);
    X2 = X2 + 1;
    X2 = bitor(X2,32768);
else
    X2 = uint16(X2);
end

p=floor(rand*14+1);
mask=1;
while (p>1)
    mask=bitshift(mask,1)+1;
    p=p-1;
end
mask2=mask;
mask1=bitxor(mask2,uint16(65535));
X3=bitor(bitand(X1,mask1),bitand(X2,mask2));
X4=bitor(bitand(X1,mask2),bitand(X2,mask1));

if (X3 > 32767)
    X3 = bitxor(X3,65535);
    X3 = X3 + 1;
    X3 = - int16(X3);
else
    X3 = int16(X3);
end
if (X4 > 32767)
    X4 = bitxor(X4,65535);
    X4 = X4 + 1;
    X4 = - int16(X4);
else
    X4 = int16(X4);
end

%pobitoviu obmen 4astei dlya sozdaniya novoi
%hromosomi
% X1 and M1(111111|00000) = X1(      |000000)
% X2 and M2(000000|11111) = X2(111111|      )
%X1 or X2
    