clc
clear all
%input data
fileName = '23.txt';
X = makeDataFromFile(fileName,3,2);
%actions with data
nCluster = 3;
clusters = kMeansMine(X,nCluster);
%output data
plotClusters(X,clusters);
