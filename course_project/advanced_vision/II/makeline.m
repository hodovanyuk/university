% makes a set of points from pt1 to pt2
% warning - points not in order
function makeline(pt1,pt2)

  global drawr drawc lastused

  drawr(lastused+1) = round(pt1(1));
  drawc(lastused+1) = round(pt1(2));
  drawr(lastused+2) = round(pt2(1));
  drawc(lastused+2) = round(pt2(2));
  lastused = lastused + 2;

  % recursively split
  if abs(pt1(1)-pt2(1)) > 1 | abs(pt1(2)-pt2(2)) > 1
    mid(1) = round( (pt1(1) + pt2(1))/2);
    mid(2) = round( (pt1(2) + pt2(2))/2);
    makeline(pt1,mid)
    makeline(mid,pt2) 
  end
