function y = griewangk( x )

n = length( x );
j = 0:n-1;
y = sum( x.*x )/4000 - prod( cos( x./sqrt(j+1) ) ) + 1;
