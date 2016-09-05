clc
% y = 2x+7
a = 2;
b = 7;
N = 20;

X = linspace(5,15,N);
Y = a*X+b;

%plot(X,Y,'.');

R = rand(1,N)-0.5;

Y2 = Y+R;


%plot(X,Y2,'.r');

% X,Y2
M1 = zeros(2,2);
M1(1,1) = sum(X.*X);
M1(1,2) = sum(X);
M1(2,1) = M1(1,2);
M1(2,2) = N;

M2 = zeros(2,1);
M2(1) = sum(X.*Y);
M2(2) = sum(Y);

% M1 * U = M2 => U = inv(M1) * M2
hold all
plot(X,Y,'.');
U = M1^(-1) * M2;

k = 5;
min=10^31;
plot(X,Y_NEW,'color',rand(1,3));
for i=1:k
  temp = llsq(X,Y,i);
  if temp < min
   min = temp;
   min_i = i;
  end
endfor
min_i