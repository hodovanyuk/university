function plotClusters3( X,C )

markers = '*vd';
colors  = 'rgb';

k = max( C );
figure
for i = 1:k
    idx = find( C == i );
    M = X( idx,: );
    
    plot3( M( :,1 ),M( :,2 ),M( :,3),[ colors( i ) markers( i ) ] );
    hold on;
end