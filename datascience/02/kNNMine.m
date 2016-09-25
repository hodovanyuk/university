function C = kNNMine( X,CL,y,k )
% X - множина точок, розбитих по кластерам
% CL - розбиття точок по кластерам
% y - точка, що треба класифікувати
% k - кількість точок, по яким визначати поточну
% C - кластер, до якого належить точка

%  y1 y2 y3      x11 x12 x13   
%  y1 y2 y3      x21 x22 x23
%  y1 y2 y3      x31 x32 x33

m = size( X,1 );

DD = ( repmat( y,m,1 ) - X ).^2;
d = sqrt( sum( DD' ) );
idx = 1:m;
d = [ d' idx' ];
d = sortrows( d,1 );
idx = d( 1:k,2 );
clust = CL( idx );
maxClust = max( clust );
count = zeros( 1,maxClust );
for i = 1:length( clust )
    count( clust( i ) ) = count( clust( i ) ) + 1;
end
[ ~,maxIdx ] = max( count );
C = maxIdx( 1 );
