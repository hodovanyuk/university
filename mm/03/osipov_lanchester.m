% war model
% Osipo-Lanchester

function osipov_lanchester

dt = 0.01;
N =  43;
t(1) = 0;

B(1) = 20;  % ussr
R(1) = 20;   % naci


b = 3*0.9;    % ussr probability
r = 9*0.1;    % naci probability

for i = 1:N 
    R(i+1) = R(i) +  (-b*B(i)) * dt;
    B(i+1) = B(i) +  (-r*R(i)) * dt;
    t(i+1) = t(i) + dt;
end

grid on
hold on

plot(t,B, 'b')      % 1

plot(t,R, 'r')      % 2 
