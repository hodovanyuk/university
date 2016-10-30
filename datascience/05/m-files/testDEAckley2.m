
D = 2;
L = -500 * ones( 1,D );
U =  500 * ones( 1,D );

% f = @ackley;
% f = @spherefunc;
% f = @hyperellipsoid;
% f = @rosenbrock;
% f = @griewangk;
f = @schwefel;

step = 10;

x = L( 1 ):step:U( 1 );
y = L( 2 ):step:U( 2 );
z = zeros( length( y ),length( x ) );

for i = 1:length( x )
    for j = 1:length( y )
        z( j,i ) = f( [ x( i ),y( j ) ] );
    end
end

surf( x,y,z );
shading interp
