function henon_model
a =0.2;
b =-0.9999;
xn =0;
yn =0;
N =10000;
X = zeros(N, 1);
Y = zeros(N, 1);
for i=1:N
    X(i) = xn;
    Y(i) = yn;
    x  = yn + 1 - a*xn^2;
    y  = b * xn;
    xn = x;
    yn = y;
end
figure
plot(X, Y,'.')
xlabel('x')
ylabel('y')
legend('a = 0.2 b= -0.9999')
end
