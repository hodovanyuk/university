function Reslera
eps = 0.3;
f = 0.4;
mu = 8.5;

x(1) = 1;
y(1) = 1;
z(1) = 1;
t(1) = 0;

dt = 0.01;
N =  10000;

for i = 1:N 
    x(i+1) = x(i) + (-y(i)-z(i))*dt;
    y(i+1) = y(i) + (x(i)+eps*y(i))*dt;
    z(i+1) = z(i) + (f-mu*z(i)+x(i)*z(i))*dt;
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
