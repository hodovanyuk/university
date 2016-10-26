function GenesioTesi
graphics_toolkit('gnuplot');
alpha = 0.446;
beta = 1.1; 
gama = 1;

x(1) = 1e-4;
y(1) = 1e-4;
z(1) = 1e-4;
t(1) = 0;

dt = 0.001;
N =  100000;

for i = 1:N 
    x(i+1) = x(i) + (y(i))*dt;
    y(i+1) = y(i) + (z(i))*dt;
    z(i+1) = z(i) + (-gama*x(i)-beta*y(i)-alpha*z(i)+x(i).^2)*dt;
%    z(i+1) = z(i) + (-alpha*z(i)-beta*y(i)-x(i)*(1+x(i)))*dt;
    t(i+1) = t(i) + dt;
end

figure 
hold all;
plot(t,x, 'b')
plot(t,y, 'g')
plot(t,z, 'r')
legend('x','y','z')
print -djpg GenesioTesi1.jpg
grid on;

figure
plot3(-z , y, x, 'b')
legend('Genesio Tesi attractor')
grid on
print -djpg GenesioTesi.jpg
end
