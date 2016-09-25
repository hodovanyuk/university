function Y = makeData( X,N )
% X - centers
% N - sizes
% Y - points

k = 0.75;
Y = repmat( X( 1,: ),N(1),1 ) + randn( N(1),2 )*k;
Y = [ Y; repmat( X( 2,: ),N(2),1 ) + randn( N(2),2 )*k ];
Y = [ Y; repmat( X( 3,: ),N(3),1 ) + randn( N(3),2 )*k ];

