function [X1,F1]=getchromosome(X,F)

FTemp = F;
F=F-min(F);

L=sum(F);
P=double(F)/L;
P=cumsum(P);%razbivaem na u4astki nashu chromosomu

i=1;
n=rand;
while(n>P(i))
    i=i+1;
end

X1=X(i);
F1=FTemp(i);
