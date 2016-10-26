% competition types
function competition_model

dt = 0.01;
N = 250;

t(1) = 0;
x(1) = 10; % population first
y(1) = 20; % population druih

a1 = 60; % speed ratio of the population 1
b1 = 3; % speed ratio of natural increase of population 1
c1 = 4; % coefficient that describes the konurentsiya types
a2 = 42; % speed ratio of the population 2
b2 = 3; % speed ratio of natural increase of population 2
c2 = 2; % coefficient that describes the konurentsiya types

for i = 1:N
x(i+1) = x(i) + (x(i)*(a1 - b1*x(i) - c1*y(i)))*dt;
 y(i+1) = y(i) + (y(i)*(a2 - b2*y(i) - c2*x(i)))*dt;
t(i+1) = t(i) + dt;
end

plot(t,x, 'b') % population 1
grid on
hold on
plot(t,y, 'r') % population 2