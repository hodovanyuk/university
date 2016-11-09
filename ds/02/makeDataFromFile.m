function Y = makeDataFromFile( fileName,dimension,step )
% Example of function work
% input := {1 2 3 4 5 6 7 8 9 10}
% dimension = 3
% step = 2
% output :={
% 1 3 5
% 2 4 6
% 3 5 7
% 4 6 8
% 5 7 9
% 6 8 10
% }
k=0.75;
X = load( fileName,'-ascii' );
nX = length( X );
Y = zeros( nX-step*(dimension-1),dimension );
for i = 1:dimension
    idx1 = 1+(i-1)*step;
    idx2 = nX-(dimension-i)*step;
    Y( :,i ) = X( idx1:idx2,: );
end
%.*randn([length(Y),1])