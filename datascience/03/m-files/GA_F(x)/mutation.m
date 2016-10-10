function cr1 = mutation( cr1 )

n = length( cr1 );
r = randi( n,1 );

if( cr1( r ) == 1 )
    cr1( r ) = 0;
else
    cr1( r ) = 1;
end
