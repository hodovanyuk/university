function [A,S] = calcMNK(X,Y,p)

N = length(X);

M1 = zeros(2,2);
M1(1,1) = sum(X.*X);
M1(1,2) = sum(X);
M1(2,1) = M1(1,2);
M1(2,2) = N;

M2 = zeros(2,1);
M2(1) = sum(X.*Y);
M2(2) = sum(Y);

% M1 * U = M2 => U = inv(M1) * M2
U = M1^(-1) * M2;

a = U(1);
b = U(2);

S = sum((Y - a*X - b).^2);