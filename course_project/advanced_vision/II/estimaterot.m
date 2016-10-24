% estimate the translation and rotation that maps a set of
% model lines to their paired data lines
function theta = estimaterot(model,numpairs,pairs)

  global numlines Models datalines

  % estimate rotation
  d = zeros(numpairs,2);
  for p = 1 : numpairs
    u =  [Models(model,pairs(p,1),3) - Models(model,pairs(p,1),1), ...
        Models(model,pairs(p,1),4) - Models(model,pairs(p,1),2)];
    u = u / norm(u);
    v =  [datalines(pairs(p,2),3) - datalines(pairs(p,2),1), ...
        datalines(pairs(p,2),4) - datalines(pairs(p,2),2)];
    v = v / norm(v);
    d(p,:) = [v(1)*u(2)-v(2)*u(1),v(2)*u(2)+v(1)*u(1)];
  end

  D = d'*d;
  disc = sqrt( (D(1,1)-D(2,2))^2 + (D(1,2)+D(2,1))^2);
  theta(1) = atan2(((D(2,2) - D(1,1)) + disc) , (D(1,2)+D(2,1)));
  theta(2) = atan2(((D(2,2) - D(1,1)) - disc) , (D(1,2)+D(2,1)));
  theta(3) = theta(1) + pi;
  if theta(3) > 2*pi
    theta(3) = theta(3) - 2*pi;
  end
  theta(4) = theta(2) + pi;
  if theta(4) > 2*pi
    theta(4) = theta(4) - 2*pi;
  end
                                                                          
%
%for p = 1 : 4
%cs = [theta(p),cos(theta(p)),sin(theta(p))]
%end
%[V,DG] = eig(D)
%theta(1) = atan2(V(2,1),V(1,1))+pi
%cs2 = [theta(1),cos(theta(1)),sin(theta(1))]
%pause

