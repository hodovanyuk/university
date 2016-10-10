function [X,F]=create_population(m)

X=rand(m,1);
X=int16(floor(X*200-100));
F=-X.*X-6*X+24;
