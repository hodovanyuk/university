function y = calcFitness( x )
% y = |x+y|+1
y = 1 / ( sqrt( abs( x(1)+x(2)+1) ) + 1 );