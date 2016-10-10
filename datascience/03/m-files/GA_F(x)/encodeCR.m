function cr = encodeCR( x )
%

% len = 21 bits
n = 54;
cr = zeros( 1,n );

% sign bit
if( x(1) < 0 )
    cr( 1 ) = 1;
    x(1) = -x(1);
end
if( x(2) < 0 )
    cr( 28 ) = 1;
    x(2) = -x(2);
end
%first number
% integer part
y = floor( x(1) );
y_tmp = y;
idx = 12;
while( y > 0 )
    idx = idx - 1;
    cr( idx ) = mod( y,2 );
    y = bitshift( y,-1 );
end

% non-integer part
y = x(1) - y_tmp;
idx = 11;
while( idx < 27 )
    idx = idx + 1;
    y = y * 2;
    i = floor( y );
    cr( idx ) = i;
    y = y - i;
end

%second number
% integer part
y = floor( x(2) );
y_tmp = y;
idx = 39;
while( y > 0 )
    idx = idx - 1;
    cr( idx ) = mod( y,2 );
    y = bitshift( y,-1 );
end

% non-integer part
y = x(2) - y_tmp;
idx = 38;
while( idx < 54 )
    idx = idx + 1;
    y = y * 2;
    i = floor( y );
    cr( idx ) = i;
    y = y - i;
end