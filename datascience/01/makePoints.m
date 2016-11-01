function [X,Y] = makePoints(a,b,N,x0,x1)

X = linspace(x0,x1,N);
Y = a*X + b + rand(1,N)-0.5;
