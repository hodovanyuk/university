function x = decodeCR( cr )

x = 0;
base = 1;
for i = 11:-1:2
    x = x + cr( i )*base;
    base = base * 2;
end

base = 0.5;
for i = 12:26
    x = x + cr( i )*base;
    base = base / 2;
end

if( cr( 1 ) == 1 )
    x = -x;
end
