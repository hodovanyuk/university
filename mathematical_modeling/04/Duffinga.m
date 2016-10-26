function Duffinga
p = 0.4;
p1 = -2.1;
w = 3.8;
q = 2;

x(1) = 1;
y(1) = 1;
z(1) = 1;
t(1) = 0;

dt = 0.01;
N =  10000;

for i = 1:N 
    x(i+1) = x(i) + y(i)*dt;
    y(i+1) = y(i) + (-p1-x(i)^3-p*y(i)+q*cos(w*t(i)))*dt;
   
    t(i+1) = t(i) + dt;
end

figure 
hold all;
plot(t,x, 'b')
plot(t,y, 'g')
grid on;

figure
plot3(x , y, t, 'b')
grid on;
end
