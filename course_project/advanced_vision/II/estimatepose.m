% estimate the translation and rotation that maps a set of
% model lines to their paired data lines
function [theta,trans] = estimatepose(model,numpairs,pairs)

  global numlines Models datalines

  theta = zeros(4,1);
  trans = zeros(4,2);
  theta = estimaterot(model,numpairs,pairs);
  for p = 1 : 4
    R = [ [cos(theta(p)),sin(theta(p))]',[-sin(theta(p)),cos(theta(p))]'];
    trans(p,:) = esttrans(R,model,numpairs,pairs)';
  end
