function Y = makeDataM( X,N )
% X - centers
% N - sizes

% Y - points

% X
% 1  2  3  4
% 2  2  2  2
% 3  4  1  1
% 5  5 10  8
% 8 -1 -1  3

n = size( X,1 );        % clusters count
m = size( X,2 );        % dimension

k = 0.75;

Y = repmat( X( 1,: ),N(1),1 ) + randn( N(1),m )*k;
for i = 2:n
    Y = [ Y; repmat( X( i,: ),N(i),1 ) + randn( N(i),m )*k ];
end
