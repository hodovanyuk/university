function Lorensa
alpha = 10;
beta = 10;
r = 28;
gama = 1;
delta = 1;
l = 1;
b = 8/3;

x(1) = 1;
y(1) = 1;
z(1) = 1;
t(1) = 0;

dt = 0.01;
N =  10000;

for i = 1:N 
    x(i+1) = x(i) + (alpha*y(i) - beta*x(i))*dt;
    y(i+1) = y(i) + (r*x(i) - gama*y(i) - delta*x(i)*z(i))*dt;
    z(i+1) = z(i) + (-b*z(i) + l*x(i)*y(i))*dt;
    t(i+1) = t(i) + dt;
end

figure 
hold all;
plot(t,x, 'b')
plot(t,y, 'g')
plot(t,z, 'r')
grid on;

figure
plot3(x , y, z, 'b')
grid on;
end
