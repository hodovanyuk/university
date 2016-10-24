
% compute the background image
Im0 = double(imread('DATA/ball00000100.jpg','jpg'));
Im1 = double(imread('DATA/ball00000101.jpg','jpg'));
Im2 = double(imread('DATA/ball00000102.jpg','jpg'));
Im3 = double(imread('DATA/ball00000103.jpg','jpg'));
Im4 = double(imread('DATA/ball00000104.jpg','jpg'));
Imback = (Im0 + Im1 + Im2 + Im3 + Im4)/5;
[MR,MC,Dim] = size(Imback);

% loop over all images
fig1=1;
fig2=0;
fig15=0;
fig3=1;
fig4=4;
for i = 1 : 60
  % load image
  if i < 11
    Im = (imread(['DATA/ball0000010',int2str(i-1), '.jpg'],'jpg')); 
  else
    Im = (imread(['DATA/ball000001',int2str(i-1), '.jpg'],'jpg')); 
  end
  if fig1 > 0
    figure(fig1)
    clf
    imshow(Im)
  end
  Imwork = double(Im);

  %extract ball
  [cc(i),cr(i),radius,flag]=extractball(Imwork,Imback,fig1,fig2,fig3,fig15,i);
  if flag==0
    continue
  end

  if fig1 > 0
    figure(fig1)
    hold on
    for c = -0.97*radius: radius/20 : 0.97*radius
      r = sqrt(radius^2-c^2);
      plot(cc(i)+c,cr(i)+r,'g.')
      plot(cc(i)+c,cr(i)-r,'g.')
    end
    %eval(['saveas(gcf,''TRACK/trk',int2str(i-1),'.jpg'',''jpg'')']);  
  end

      pause(0.3)
end

% show positions
if fig4 > 0
  figure(fig4)
  hold on
  clf
  plot(cc,'r*')
  plot(cr,'g*')
end
