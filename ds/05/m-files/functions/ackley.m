function y = ackley( x )

n = length( x );
d1 = 0;
d2 = 0;
for i = 1:n
    d1 = d1 + x(i)^2;
    d2 = d2 + cos(2*pi*x(i));
end

y = 20 + exp(1) - 20*exp( -0.2*sqrt( d1/n ) ) - ...
    exp( d2/n );