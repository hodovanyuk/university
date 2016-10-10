function X=mutation(X)

if (X < 0)
    X = uint16(abs(X));
    X = bitxor(X,32767);
    X = X + 1;
    X = bitor(X,32768);
else
    X = uint16(X);
end

p=floor(rand*15+1);
mask=0;
mask=bitset(mask,p);
X=bitxor(X,mask);

if (X > 32767)
    X = bitxor(X,65535);
    X = X + 1;
    X = - int16(X);
else
    X = int16(X);
end
%izmenenie randomnogo bita dlya predotvrasheniya 
%faila v main