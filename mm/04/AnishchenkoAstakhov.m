function AnishchenkoAstakhov
mu = 1.2;
teta = 0.5;

x(1) = 1e-4;
y(1) = 1e-4;
z(1) = 1e-4;
t(1) = 0;

dt = 0.1;
N =  10000;

for i = 1:N 
    x(i+1) = x(i) + (mu*x(i) + y(i) - x(i)*z(i))*dt;
    y(i+1) = y(i) + (-x(i))*dt;
    z(i+1) = z(i) + (-teta*z(i)+x(i)^2)*dt;
    t(i+1) = t(i) + dt;
end

figure 
hold all;
plot(t,x, 'b')
plot(t,y, 'g')
plot(t,z, 'r')
legend('x','y','z')
print -djpg AnishchenkoAstakhov.jpg
grid on;

figure
plot3(x , y, z, 'b')
legend(' The Anishchenko Astakhov attractor')
grid on;
print -djpg AnishchenkoAstakhov1.jpg
end
