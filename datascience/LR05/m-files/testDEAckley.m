
clear all

D = 2;
N = 100;
L = -500 * ones( 1,D );
U =  500 * ones( 1,D );
F = 0.9;
eps = 0.0001;
iter_eps = 0;
maxiter = 15000;
% f = @ackley;
% f = @spherefunc;
% f = @hyperellipsoid;
% f = @rosenbrock;
% f = @griewangk;
f = @schwefel;

[ X,Y ] = initDE( N,D,L,U,f );
iter = 0
ymin = min( Y )
% plot( X(:,1),X(:,2),'.' )

while( iter_eps < maxiter )
    V = mutationDE( X,F );
    % hold on
    % plot( V(:,1),V(:,2),'.g' )

    U = recombinationDE( X,V );
    [ X1,Y1 ] = selectionDE( X,U,f );
    idx = find( ~isnan( Y1 ) );
    if( ~isempty( idx ) )
        X( idx,: ) = X1( idx,: );
        Y( idx ) = Y1( idx );
    end
    if( abs( ymin - min( Y ) ) < eps )
        iter_eps = iter_eps + 100;
    else
        iter_eps = 0;
        [ ymin,idxmin ] = min( Y );
        % X( idxmin( 1 ),: )
    end
    iter = iter + N
    ymin
end
[ ymin,idxmin ] = min( Y );
X( idxmin( 1 ),: )