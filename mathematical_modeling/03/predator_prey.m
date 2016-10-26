% of predator-pray
function predator_prey

dt  = 0.1;
N   = 100;

t(1) = 0;
x(1) = 6; % population of victims
y(1) = 6; % population of predators

a = 5; % growth rate of the victims
b = 2; % growth rate of predator population
p = 1; % ratio of interactions
q = 1; % ratio of interactions

for i = 1:N 
  x(i+1) = x(i) + (a*x(i) - x(i)*x(i) - p*x(i)*y(i))*dt;
  y(i+1) = y(i) + (-b*y(i) + q*y(i)*x(i))*dt;
  t(i+1) = t(i) + dt;
end

plot(t,x, 'b') % population of victims
grid on
hold on
plot(t,y, 'r') % population of predators