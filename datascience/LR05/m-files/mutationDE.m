function V = mutationDE( X,F )

[ m,n ] = size( X );
V = zeros( m,n );

for i = 1:m
    idx = randperm( m );
    idx( find( idx == i ) ) = [];
    r1 = idx( 1 );
    r2 = idx( 2 );
    r3 = idx( 3 );
    V( i,: ) = X( r1,: ) + F*( X( r2,: ) - X( r3,: ) );
end
