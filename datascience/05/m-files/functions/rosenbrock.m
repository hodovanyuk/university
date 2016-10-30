function y = rosenbrock( x )

y = sum( 100*( x(2:end)-(x(1:end-1)).^2 ).^2 + ( x(1:end-1)-1 ).^2 );
