function ExponentialGrowth
    clc
    k = 0.182;
    t(1) = 0;
    p(1) = 25000;
    
    dt = 0.1;
    n = 40;
    
    for i=1:n 
        k1 = k * p(i);
        u = p(i) + dt*k1;
        k2 = k*u;
        p(i+1) = p(i) + ((k1+k2)/2)*dt;
        t(i+1) = t(i) + dt;
    end
    p(i)
    plot(t, p, '*')
    grid on
    hold on
    p = 25000 .* exp(k.*t);
    plot(t, p, 'r')