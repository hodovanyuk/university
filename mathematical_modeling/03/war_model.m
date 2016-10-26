% model of hostilities

function war_model

dt = 0.01;
N = 43;
t(1) = 0;

B(1) = 20; % army Soviet 1
R(1) = 20; % army German 2

b = 3*0.9; % probability of breaking the tank 1
r = 9*0.1; % probability of breaking the tank 2

for i = 1:N 
R(i+1) = R(i) + (-b*B(i)) * dt;
B(i+1) = B(i) + (-r*R(i)) * dt;
t(i+1) = t(i) + dt;
end

plot(t,B, 'b') % army 1
grid on
hold on
plot(t,R, 'r') % army 2