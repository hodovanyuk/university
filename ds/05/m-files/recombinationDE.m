function U = recombinationDE( X,V )

[ m,n ] = size( X );
U = zeros( m,n );

for i = 1:m
    CR = rand( 1 );
    rnd = rand( 1,n );
    idx_X = find( rnd >= CR );
    idx_V = find( rnd < CR );
    if( ~isempty( idx_X ) )
        U( i,idx_X ) = X( i,idx_X );
    end
    if( ~isempty( idx_V ) )
        U( i,idx_V ) = V( i,idx_V );
    end
    Irand = floor( rand( 1 ) * n ) + 1;
    U( i,Irand ) = V( i,Irand );
end