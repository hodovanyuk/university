
% model of the drug
 
function antibiotics_model
 
dt = 0.1;
N =  480;
t(1) = 0;
 
I = 1/24; % the rate of arrival of medicines
 
X(1) = 0.0001; % ratio of drugs in the gastrointestinal tract
Y(1) = 0;   % concentration of medicines in blood
 
k1 = 0.72; % ratio from the gastrointestinal tract into the blood
k2 = 0.15;  % ratio of withdrawal of the drug
 
for i = 1:N 
    X(i+1) = X(i) +  (I - k1*X(i)) * dt;
    Y(i+1) = Y(i) +  (k1*X(i) - k2*Y(i)) * dt;
    t(i+1) = t(i) + dt;
end
 
 
plot(t,X, 'b') % in the gastrointestinal tract
grid on
hold on
plot(t,Y, 'r') % in the blood