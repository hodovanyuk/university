function gross_national_product
clc;
clear all;
m = 2.701:1e-4:3.7;
Na = length(m);
N = 20;
Nc = 220;
kn = zeros(Na,N);
lam = 4;
gama = 1;
beta = 1.5;
sigma = 4;
B = 1;
for i = 1:Na
    k = zeros(Nc,1);
    k(1) = 1;
    
    for n = 1:Nc
        k(n+1) = sigma*B*k(n)^(beta)*(m(i)-k(n))^(gama)/(1+lam);
    end
    for j =1:N
        kn(i,j)=k(end-j+1);
    end
    
end

figure
hold on;
plot(m,kn,'k');
xlabel('a');
ylabel('cn');
