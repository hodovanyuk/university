function C = kMeansMine( X,k )

N = size( X,1 );
idx = randperm( N );
cntr = X( idx( 1:k ),: );

flag = true;
iter = 0;
% loop will itterate while not find clisters centers 
while( flag )

    iter = iter + 1;
    
    C = zeros( N,1 );
    for i = 1:N
        p = X( i,: );
        p = (repmat( p,k,1 ) - cntr).^2;
        d = sqrt( sum( p' ) );
        [ ~,idx ] = min( d );
        C( i ) = idx( 1 );
    end
    
    flag = false;
    cntr_new = cntr;
    for i = 1:k
        idx = find( C == i );
        if idx ~= 0
          cntr_new( i,: ) = sum( X( idx,: ) ) / length( idx );
        end
    end

    flag = max( max( abs( cntr_new - cntr ) ) );
    cntr = cntr_new;
    
end