function cr = encodeCR( x )
%

% len = 21 bits
n = 26;
cr = zeros( 1,n );

% sign bit
if( x < 0 )
    cr( 1 ) = 1;
    x = -x;
end

% integer part
y = floor( x );
y_tmp = y;
idx = 12;
while( y > 0 )
    idx = idx - 1;
    cr( idx ) = mod( y,2 );
    y = bitshift( y,-1 );
end

% non-integer part
y = x - y_tmp;
idx = 11;
while( idx < 26 )
    idx = idx + 1;
    y = y * 2;
    i = floor( y );
    cr( idx ) = i;
    y = y - i;
end
