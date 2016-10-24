% estimate translation
function t = esttrans(R,model,numpairs,pairs)

  global numlines Models datalines currentimage scalefactor
  global drawr drawc lastused

  sumpp = zeros(2,2);
  sumdpp = zeros(2,1);
  for p = 1 : numpairs
    perpm = [Models(model,pairs(p,1),2) - Models(model,pairs(p,1),4), Models(model,pairs(p,1),3) - Models(model,pairs(p,1),1)]';
    perpm = perpm / norm(perpm);
    perpm = R*perpm;
    sumpp = sumpp + perpm*perpm';
    mi = [Models(model,pairs(p,1),1),Models(model,pairs(p,1),2)]';
    di = [datalines(pairs(p,2),1),datalines(pairs(p,2),2)]';
    sumdpp = sumdpp + perpm*perpm'*(di - scalefactor*R*mi);
  end
  t = inv(sumpp)*sumdpp;

  % draw transformed model lines on top of original data
%  overlapimage = currentimage;
%  [H,W] = size(overlapimage);
%  lastused = 0;
%  drawr = zeros(10000,1);
%  drawc = zeros(10000,1);
%  for p = 1 : numpairs
%    pt1 = [Models(model,pairs(p,1),1),Models(model,pairs(p,1),2)]';
%    pt1 = scalefactor*R*pt1 + t;
%    pt2 = [Models(model,pairs(p,1),3),Models(model,pairs(p,1),4)]';
%    pt2 = scalefactor*R*pt2 + t;
%    makeline(pt1,pt2)
%    for i = 1 : lastused
%      if drawr(i) > 3 & drawr(i) < H-2 & drawc(i) > 3 & drawc(i) < W-2
%        for j = -2 : 2
%          for k = -2 : 2
%            overlapimage(drawr(i)+j,drawc(i)+k) = 1.0;
%          end
%        end
%      end
%    end
%  end
%  figure(10)
%  colormap(gray)
%  imshow(overlapimage)
%
%pause

