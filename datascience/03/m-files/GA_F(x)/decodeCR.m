function x = decodeCR( cr )

x = [0 0];
% first number
base = 1;
for i = 11:-1:2
    x(1) = x(1) + cr( i )*base;
    base = base * 2;
end

base = 0.5;
for i = 12:26
    x(1) = x(1) + cr( i )*base;
    base = base / 2;
end

if( cr( 1 ) == 1 )
    x(1) = -x(1);
end

%second number

base = 1;
for i = 38:-1:27
    x(2) = x(2) + cr( i )*base;
    base = base * 2;
end

base = 0.5;
for i = 39:54
    x(2) = x(2) + cr( i )*base;
    base = base / 2;
end

if( cr( 1 ) == 1 )
    x(2) = -x(2);
end
