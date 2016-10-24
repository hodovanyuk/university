function y = schwefel( x )

D = length( x );
y = -sum( x .* sin( sqrt( abs( x ) ) ) )/D;