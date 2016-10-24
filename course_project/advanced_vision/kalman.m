
% compute the background image
Im0 = double(imread('DATA/ball00000100.jpg','jpg'));
Im1 = double(imread('DATA/ball00000101.jpg','jpg'));
Im2 = double(imread('DATA/ball00000102.jpg','jpg'));
Im3 = double(imread('DATA/ball00000103.jpg','jpg'));
Im4 = double(imread('DATA/ball00000104.jpg','jpg'));
Imback = (Im0 + Im1 + Im2 + Im3 + Im4)/5;
[MR,MC,Dim] = size(Imback);

% Kalman filter initialization
R=[[0.2845,0.0045]',[0.0045,0.0455]'];
H=[[1,0]',[0,1]',[0,0]',[0,0]'];
Q=0.01*eye(4);
P = 100*eye(4);
dt=1;
A=[[1,0,0,0]',[0,1,0,0]',[dt,0,1,0]',[0,dt,0,1]'];
g = 6; % pixels^2/time step
Bu = [0,0,0,g]';
kfinit=0;
x=zeros(100,4);

% loop over all images
fig1=1;
fig2=0;
fig15=0;
fig3=0;
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

  % Kalman update
i
  if kfinit==0
    xp = [MC/2,MR/2,0,0]'
  else
    xp=A*x(i-1,:)' + Bu
  end
  kfinit=1;
  PP = A*P*A' + Q
  K = PP*H'*inv(H*PP*H'+R)
  x(i,:) = (xp + K*([cc(i),cr(i)]' - H*xp))';
x(i,:)
[cc(i),cr(i)]
  P = (eye(4)-K*H)*PP

  if fig1 > 0
    figure(fig1)
    hold on
    for c = -0.97*radius: radius/20 : 0.97*radius
      r = sqrt(radius^2-c^2);
      plot(x(i,1)+c,x(i,2)+r,'r.')
      plot(x(i,1)+c,x(i,2)-r,'r.')
    end
%    eval(['saveas(gcf,''KFILT/kflt',int2str(i-1),'.jpg'',''jpg'')']);  
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

% estimate image noise (R) from stationary ball
  posn = [cc(55:60)',cr(55:60)'];
  mp = mean(posn);
  diffp = posn - ones(6,1)*mp;
  Rnew = (diffp'*diffp)/5;
