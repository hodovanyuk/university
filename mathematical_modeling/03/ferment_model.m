% model of enzyme reactions

function ferment_model

dt = 0.1;
N =  100;
t(1) = 0;

S(1) = 1e-3; % the substrate
C(1) = 0;   % system (S+E)
E(1) = 0.5e-3;  % enzyme
P(1) = 0;  % product

k1 = 1e3; % the ratio (S+E) -> (SE)
k_1 = 1; % the ratio (S+E) <- (SE)
k2 = 0.5; % cont SE -> (P+E)


for i = 1:N 
    S(i+1) = S(i) + ( k_1 * C(i) - k1 * S(i) * (E(1) - C(i)) ) * dt;
    C(i+1) = C(i) + ( k1 * S(i) * (E(1) - C(i)) - (k_1 + k2) * C(i) ) * dt;
    t(i+1) = t(i) + dt;
    
    E(i+1) = E(1) - C(i);
    P(i+1) = S(1) - S(i) - C(i);
end

plot(t,S, 'b') % substrate
grid on
hold all
plot(t,C, 'r') % complex
plot(t,E, 'g') % enzyme
plot(t,P, 'k') % product

    
    
