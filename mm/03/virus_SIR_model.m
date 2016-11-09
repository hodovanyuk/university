% model of infection

function virus_SIR_model

dt = 0.1;
N = 1000;
t(1) = 0;

S(1) = 499; % uninfected
R(1) = 0; % insulated, are immune, cured
I(1) = 1; % infected

alpha = 0.001; % probability of infection
beta = 0.1; % percentage of cured isolated

for i = 1:N 
S(i+1) = S(i) + (-alpha*S(i) * I(i))*dt;
I(i+1) = I(i) + (alpha*S(i) * I(i) - beta*I(i))*dt;
R(i+1) = R(i) + (beta*I(i))*dt;
t(i+1) = t(i) + dt;
end

plot(t,S, 'b') % uninfected
grid on
hold all
plot(t,R, 'g') % isolated, cured
plot(t,I, 'r')% infected