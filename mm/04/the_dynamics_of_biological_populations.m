function the_dynamics_of_biological_populations
a = 0.001:1e-2:1;
Na = length(a);
N = 20;
Nc = 220;
cn = zeros(Na,N);
b = 1.1e+6;
r = 0.1;
s = 16;

t = 1:Nc;
for i = 1:Na
    c = zeros(Nc,1);
    c(1) = 1;
    
    for n = 2:Nc
        c(n) = 4*r*c(n-1)*(1-c(n-1));
    end
    for k =1:N
        cn(i,k)=c(end -k+1);
    end
end
figure
hold on;
plot(a,cn,'k');
xlabel('a');
ylabel('cn');
end
