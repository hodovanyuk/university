% collacation
clc
points = [0.25, 0.5, 0.75];
df1 = ones(1,3)*-2;
df2 = 2 - 6*points;
df3 = 6*points - 12*points.^2;
M = [[df1(1),df2(1),df3(1)];
    [df1(2),df2(2),df3(2)];
    [df1(3),df2(3),df3(3)]];
c = M\[1,1,1]';

% c(1)*x(i)*(1-x(i))+c(1)*x(i)*(1-x(i))+c(1)*x(i)*(1-x(i))+c(1)*x(i)*(1-x(i))
