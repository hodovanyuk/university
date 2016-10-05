clc
clear all
%input data
fileName = '23.txt';
X = makeDataFromFile(fileName,3,3);
%actions with data
nCluster = 3;
clusters = kMeansMine(X,nCluster);
%output data
hold all
plotClusters(X,clusters);
%--------------------------------------%
% kNN 
y = [ 60, 60, 1 ];
k = 2; 
kNNMine( X,clusters,y,k )
plot(y(1),y(2),'b');