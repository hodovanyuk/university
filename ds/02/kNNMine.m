function C = kNNMine( X,CL,y,k )
% X - data
% CL - data2cluster
% y - the point of interest
% k - the number of neighbors
% C - predicted class of the point of interest

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
