function Chua
p = 9;
q = 14.286;
M1 = -1/7;
M0 = 2/7;
f = @(x) M0*x+0.5*(M1-M0)*(abs(x+1)-abs(x-1));

x(1) = 1;
y(1) = 1;
z(1) = 1;
t(1) = 0;

dt = 0.01;
N =  10000;

for i = 1:N 
    x(i+1) = x(i) + (p*(y(i)-f(x(i))))*dt;
    y(i+1) = y(i) + (x(i)-y(i)+z(i))*dt;
    z(i+1) = z(i) + (-q*y(i))*dt;
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
