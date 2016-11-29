a=2;b=10;
x = a:b;
t = 1./((b-a)*rand((length(x)),1)+a);

f = @(x) abs(1./(x*rand)+rand*x);
y = f(x).*t';
plot(x,y)
xlabel('gate width')
ylabel('steps')