function y = hyperellipsoid( x )

n = length( x );
p2 = 0:n-1;
base = ones( 1,n ) * 2;
y = sum( base.^p2 .* x.^2 );