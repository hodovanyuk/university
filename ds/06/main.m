clc
clear all

X = [0.30 0.35 0.4 0.5 0.6 0.8 0.95 1.1];
nX = length(X);
Y = [1.6 1.4 1.4 1.6 1.7 2 1.7 2.1];
hold on;
plot(X,Y,'.');
m = 0.5;
c = 0.3;
Y_new = X.*m+c;
e = sum((Y-Y_new).^2/nX);
legend1 = strcat('m = ',num2str(m),', c = ',num2str(c),' error = ',num2str(e));
plot(X,Y_new,'.-r');
m = 1.1;
c = 0.5;
Y_new = X.*m+c;
e = sum((Y-Y_new).^2/nX);
legend2 = strcat('m = ',num2str(m),', c = ',num2str(c),' error = ',num2str(e));
plot(X,Y_new,'.-g');
m = 1.1;
c = 0.9;
Y_new = X.*m+c;
e = sum((Y-Y_new).^2/nX);
legend3 = strcat('m = ',num2str(m),', c = ',num2str(c),' error = ',num2str(e));
plot(X,Y_new,'.-b');
legend('origin',legend1,legend2,legend3);