% angle between a pair of data lines lies within delta of angle between a
% pair of model lines
function success = binarytest(model,m1,d1,m2,d2,delta)

  global datalines Models binarydelta

  % get model and data direction vectors 
%binaryin=[m1,d1,m2,d2]
  success = 0;
  if m1 == m2
    return
  end
  if d1 == d2
    return
  end
  vecd1 = [datalines(d1,3)-datalines(d1,1),datalines(d1,4)-datalines(d1,2)];
  vecd1 = vecd1 / norm(vecd1);
  vecd2 = [datalines(d2,3)-datalines(d2,1),datalines(d2,4)-datalines(d2,2)];
  vecd2 = vecd2 / norm(vecd2);
  vecm1 = [Models(model,m1,3)-Models(model,m1,1), ...
		Models(model,m1,4)-Models(model,m1,2)];
  vecm1 = vecm1 / norm(vecm1);
  vecm2 = [Models(model,m2,3)-Models(model,m2,1), ...
		Models(model,m2,4)-Models(model,m2,2)];
  vecm2 = vecm2 / norm(vecm2);

  % get angles
  angd = acos(vecd1*vecd2');
  if angd > pi/2
    angd = pi - angd;
  end
  angm = acos(vecm1*vecm2');
  if angm > pi/2
    angm = pi - angm;
  end

  % do test
  if abs(angd - angm) <= binarydelta
    success = 1;
  end
