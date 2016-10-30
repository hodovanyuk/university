function [ X,Y ] = selectionDE( X,U,f )

[ m,n ] = size( X );
Y = zeros( m,1 );

for i = 1:m
    fx = f( X( i,: ) );
    fu = f( U( i,: ) );
    if( fu < fx )
        X( i,: ) = U( i,: );
        Y( i ) = fu;
    else
        Y( i ) = NaN;
    end
end