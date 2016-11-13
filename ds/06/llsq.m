clc
X = [0.30 0.35 0.4 0.5 0.6 0.8 0.95 1.1];
nX = length(X);
Y = [1.6 1.4 1.4 1.6 1.7 2 1.7 2.1];

%m = (nX*sum(X.*Y)-sum(X)*sum(Y))/(nX*sum(X.^2)-(sum(X))^2)
%c = (sum(Y)-m*sum(X))/(nX)

%init
w = [0.5 0.5];
eta = 0.3;
% for step=1:10
    for i= 1:nX
        t = w(1)*X(1)+w(2);

        gama = t - Y(1);

        dw = eta*gama*[X(1) 1];

        w = w + dw;
    end
% end
x = 0:(X(nX)-X(1))/nX:X(nX);
y = x*w(1)+w(2);
grid on
hold on
plot(X,Y,'.-');
plot(x,y,'.');




% bimod(X,Y)