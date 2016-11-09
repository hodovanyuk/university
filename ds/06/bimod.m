function rtrn = bimod(X,Y)
m = 0.71721;
c = 1.2392;
rtrn = (m.*X.-Y.+c)>0;