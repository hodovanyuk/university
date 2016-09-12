function [S] = llsq(X,Y,p)

N = length(X);

M_X = ones(p,p);

M_Y = ones([1 p]);
% p:-1:1
for i =1:p
  for j =1:p
    M_X(i,j) = sum(X.^(i+j-2));
  end
  M_Y(i) = sum(Y.*(X.^(i-1))); 
end

M_X(1,1) = N;
M_X = flipud(fliplr(M_X));
M_Y = flipud(M_Y);
% M1 * U = M2 => U = inv(M1) * M2
% length(M_X)
% length(M_Y)
U = M_X^(-1) * M_Y';

Y_NEW = ones([1 N]);
U = fliplr(U');
for i=1:N
  for j = 2:length(U)
    Y_NEW(i) = U(j)*X(i)^(j-1);
  end
  Y_NEW(i) = Y_NEW(i) + U(1); 
end

S = (sum(Y-Y_NEW))^2
plot(X,Y_NEW,'color',rand(1,3));
