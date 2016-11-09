clc
load data.txt
X  = [1:length(data)];
Y = data';
% M1 * U = M2 => U = inv(M1) * M2
hold all
plot(X,Y,'.');
k = 5;
min=10^31;
plot(X,Y,'color',rand(1,3));
for i=2:k
  i
  temp = llsq(X,Y,i);
  if temp < min
   min = temp;
   min_i = i;
  end
end
min_i
