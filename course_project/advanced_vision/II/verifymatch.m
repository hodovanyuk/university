% verify a set of pairings
function success = verifymatch(theta,t,model,numpairs,pairs)

  global datalines Models parallelthresh septhresh overlapthresh currentimage
  global drawr drawc lastused scalefactor
  
  % matching transformation - rotation matrix R and translation vector t
  R = [ [ cos(theta),sin(theta)]',[-sin(theta),cos(theta)]'];

  % align to verify
  success = 0;
  for p = 1 : numpairs
    % are transformed line pairs:
    %	1) nearly parallel?
    %	2) close?
    %	3) overlap?
    
    %	1) test nearly parallel
    vecd = [datalines(pairs(p,2),3)-datalines(pairs(p,2),1),datalines(pairs(p,2),4)-datalines(pairs(p,2),2)]';
    vecd = vecd / norm(vecd);
    vecm = [Models(model,pairs(p,1),3)-Models(model,pairs(p,1),1), ...
		Models(model,pairs(p,1),4)-Models(model,pairs(p,1),2)]';
    lenM = scalefactor*norm(vecm);
    vecm = vecm / norm(vecm);
    vecm = R*vecm;              % rotate model vector
%vecd'*vecm
%parallelthresh

    if abs(vecd'*vecm) < parallelthresh
      return
    end
    
    %	2) test close
    perpm = [Models(model,pairs(p,1),2)-Models(model,pairs(p,1),4), ...
		Models(model,pairs(p,1),3)-Models(model,pairs(p,1),1)]';
    perpm = perpm / norm(perpm);
    perpm = R*perpm;            % rotate perpendicular vector

    % get model endpoint
    modend = scalefactor*R*[Models(model,pairs(p,1),1),Models(model,pairs(p,1),2)]' + t;
    
    % test both endpoints for closeness
%septhresh
    for i = 1 : 2
      pnt = [datalines(pairs(p,2),2*i-1),datalines(pairs(p,2),2*i)]';
      distp = (pnt - modend)'*perpm;
      if abs(distp) > septhresh
        return
      end
    end
    
    %	3) test overlap
%overlapthresh*lenM
    for i = 1 : 2
      pnt = [datalines(pairs(p,2),2*i-1),datalines(pairs(p,2),2*i)]';
      del = (pnt - modend)' * vecm;
      if del < -overlapthresh*lenM | del > (1+overlapthresh)*lenM
        return
      end
    end    
  end
  success = 1;

  % draw transformed model lines on top of original data
  overlapimage = currentimage;
  [H,W] = size(overlapimage);
  lastused = 0;
  drawr = zeros(10000,1);
  drawc = zeros(10000,1);
  for p = 1 : numpairs
    pt1 = [Models(model,pairs(p,1),1),Models(model,pairs(p,1),2)]';
    pt1 = scalefactor*R*pt1 + t;
    pt2 = [Models(model,pairs(p,1),3),Models(model,pairs(p,1),4)]';
    pt2 = scalefactor*R*pt2 + t;
    makeline(pt1,pt2)
    for i = 1 : lastused
      if drawr(i) > 3 & drawr(i) < H-2 & drawc(i) > 3 & drawc(i) < W-2
        for j = -2 : 2
          for k = -2 : 2
            overlapimage(drawr(i)+j,drawc(i)+k) = 255;
          end
        end
      end
    end
  end  
  figure(11)
  colormap(gray)
  imshow(overlapimage)


