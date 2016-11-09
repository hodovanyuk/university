% model of the zombie infestation 
function virus_zombi_SZR_model

dt = 0.01;
N = 10000;
t(1) = 0;

S(1) = 100; % not a zombie
R(1) = 0; % dead zombies who can rise from the dead
Z(1) = 1; % zombie

alpha = 0.35; % the probability of infection upon contact
beta = 0.65; % chance to kill a zombie
gamma = 0.1; % probability to rise from the dead

for i = 1:N 
S(i+1) = S(i) + (-alpha*S(i) * Z(i))*dt;
Z(i+1) = Z(i) + (alpha*S(i) * Z(i) + gamma*R(i)- beta*Z(i)*S(i))*dt;
R(i+1) = R(i) + (beta*Z(i) * S(i) - gamma*R(i))*dt;
t(i+1) = t(i) + dt;
end

plot(t,S, 'g') % not a zombie
grid on
hold all
plot(t,R, 'b') % dead zombies who can rise from the dead
plot(t,Z, 'r') % zombies