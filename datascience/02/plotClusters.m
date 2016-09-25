function plotClusters( X,C )

markers = '*vd';
colors  = 'rgb';

k = max( C );
figure
for i = 1:k
    idx = find( C == i );
    M = X( idx,: );
    
    plot( M( :,1 ),M( :,2 ),[ colors( i ) markers( i ) ] );
    hold on;
end