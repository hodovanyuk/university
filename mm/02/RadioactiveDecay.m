function RadioactiveDecay
    clc
    k = -0.0001216;
    t(1) = 0;
    p(1) = 2000;
    
    dt = 0.1;
    n = 16;
    
    for i=1:n 
        k1 = k * p(i);
        u = p(i) + dt*k1;
        k2 = k*u;
        p(i+1) = p(i) + ((k1+k2)/2)*dt;
        t(i+1) = t(i) + dt;
    end
    
    plot(t, p, '*')
    grid on
    hold on
    p = 25000 .* 2.^t;
    plot(t, p, 'r')
