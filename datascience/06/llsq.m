clc
X = [0.30 0.35 0.4 0.5 0.6 0.8 0.95 1.1];
nX = length(X);
Y = [1.6 1.4 1.4 1.6 1.7 2 1.7 2.1];

%m = (nX*sum(X.*Y)-sum(X)*sum(Y))/(nX*sum(X.^2)-(sum(X))^2)
%c = (sum(Y)-m*sum(X))/(nX)

%w = [0.5 0.5]
%
%t = sum(w.*[X 1]',2)
%
%gama = t .- Y'
%
%eta = 0.3
%
%dw = eta*gama.*X
%
%w = w + dw


bimod(X,Y)