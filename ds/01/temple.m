clc
%input
p=3;

x = 2; 
y = 3;

M_X = ones(p,p);
M_Y = ones([1;p]);

M_Y

for i =1:p
  for j =1:p
    M_X(i,j) = x^(i+j-2);
  endfor
  M_Y(i) = y*x^(i-1); 
endfor

M_X(1,1) = p;

M_X

M_Y

