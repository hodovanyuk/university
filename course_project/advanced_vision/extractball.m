% extracts the center (cc,cr) and radius of the largest blob
% flag = 0 if failure
function [cc,cr,radius,flag]=extractball(Imwork,Imback,fig1,fig2,fig3,fig15,index)
  
  cc = 0;
  cr = 0;
  radius=0;
  flag=0;
  [MR,MC,Dim] = size(Imback);

  % subtract background & select pixels with a big difference
  fore = zeros(MR,MC);
  fore = (abs(Imwork(:,:,1)-Imback(:,:,1)) > 10) ...
     | (abs(Imwork(:,:,2) - Imback(:,:,2)) > 10) ...
     | (abs(Imwork(:,:,3) - Imback(:,:,3)) > 10);
  if fig15 > 0
    figure(fig15)
    clf
    imshow(fore)
    %eval(['imwrite(uint8(fore),''BGONE/nobg',int2str(index),'.jpg'',''jpg'')']);  
  end

  % erode to remove small noise
  foremm = bwmorph(fore,'erode',2);

  if fig2 > 0
    figure(fig2)
    clf
    imshow(foremm)
    %eval(['imwrite(uint8(foremm),''BCLEAN/cln',int2str(index),'.jpg'',''jpg'')']);  
  end

  % select largest object
  labeled = bwlabel(foremm,4);
  stats = regionprops(labeled,['basic']);
  [N,W] = size(stats);
  if N < 1
    return   
  end

  % do bubble sort (large to small) on regions in case there are more than 1
  id = zeros(N);
  for i = 1 : N
    id(i) = i;
  end
  for i = 1 : N-1
    for j = i+1 : N
      if stats(i).Area < stats(j).Area
        tmp = stats(i);
        stats(i) = stats(j);
        stats(j) = tmp;
        tmp = id(i);
        id(i) = id(j);
        id(j) = tmp;
      end
    end
  end

  % make sure that there is at least 1 big region
  if stats(1).Area < 100 
    return
  end
  selected = (labeled==id(1));
  if fig3 > 0
    figure(fig3)
    clf
    imshow(selected)
  end

  % get center of mass and radius of largest
  centroid = stats(1).Centroid;
  radius = sqrt(stats(1).Area/pi);
  cc = centroid(1);
  cr = centroid(2);
  flag = 1;
  return
