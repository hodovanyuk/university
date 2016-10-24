
% compute the background image
Im0 = double(imread('DATA/ball00000100.jpg','jpg'));
Im1 = double(imread('DATA/ball00000101.jpg','jpg'));
Im2 = double(imread('DATA/ball00000102.jpg','jpg'));
Im3 = double(imread('DATA/ball00000103.jpg','jpg'));
Im4 = double(imread('DATA/ball00000104.jpg','jpg'));
Imback = (Im0 + Im1 + Im2 + Im3 + Im4)/5;
[MR,MC,Dim] = size(Imback);

% Kalman filter static initializations
R=[[0.2845,0.0045]',[0.0045,0.0455]'];
H=[[1,0]',[0,1]',[0,0]',[0,0]'];
Q=0.01*eye(4);
dt=1;
A1=[[1,0,0,0]',[0,1,0,0]',[dt,0,1,0]',[0,0,0,0]'];  % on table, no vertical velocity
A2=[[1,0,0,0]',[0,1,0,0]',[dt,0,1,0]',[0,dt,0,1]']; % bounce
A3=[[1,0,0,0]',[0,1,0,0]',[dt,0,1,0]',[0,dt,0,1]']; % normal motion
g = 6.0;              % gravity=pixels^2/time step
Bu1 = [0,0,0,0]';   % ' on table, no gravity
Bu2 = [0,0,0,g]';   % ' bounce
Bu3 = [0,0,0,g]';   % ' normal motion
loss=0.7;

% multiple condensation states
NCON=10;          % number of condensation samples
MAXTIME=60;        % number of time frames
x=zeros(NCON,MAXTIME,4);      % state vectors
weights=zeros(NCON,MAXTIME);  % est. probability of state
trackstate=zeros(NCON,MAXTIME);         % state=1,2,3;
P=zeros(NCON,MAXTIME,4,4);    % est. covariance of state vec.
for i = 1 : NCON              % initialize estimated covariance
for j = 1 : MAXTIME
  P(i,j,1,1) = 100;
  P(i,j,2,2) = 100;
  P(i,j,3,3) = 100;
  P(i,j,4,4) = 100;
end
end
pstop=0.05;      % probability of stopping vertical motion
pbounce=0.30;    % probability of bouncing at current state (overestimated)
xc=zeros(4,1);   % selected state
TP=zeros(4,4);   % predicted covariance

% loop over all images
fig1=1;
fig2=0;
fig15=0;
fig3=0;
for step = 1 : MAXTIME
step

  % load image
  if step < 11
    Im = (imread(['DATA/ball0000010',int2str(step-1), '.jpg'],'jpg')); 
  else
    Im = (imread(['DATA/ball000001',int2str(step-1), '.jpg'],'jpg')); 
  end
  Imwork = double(Im);

  % extract ball
  [cc(step),cr(step),radius,flag]=extractball(Imwork,Imback,fig1,fig2,fig3,fig15,step);
  if flag==0  % ball not found - generate random position
    for newsample = 1 : NCON
      x(newsample,step,:) = [floor(MC*rand(1)),floor(MR*rand(1)),0,0]'; %'
      weights(newsample,step)=1/NCON;
    end
    continue
  end

  % display green estimated ball circle over original image
  if fig1 > 0
    figure(fig1)
    clf
    imshow(Im)
    hold on
    for c = -0.99*radius: radius/10 : 0.99*radius
      r = sqrt(radius^2-c^2);
      plot(cc(step)+c,cr(step)+r,'g.')
      plot(cc(step)+c,cr(step)-r,'g.')
    end
  end

  % condensation tracking
  % generate NCON new hypotheses from current NCON hypotheses
  % first create an auxiliary array ident() containing state vector identifier j
  % SAMPLE*p_k times, where p is the estimated probability of j
  if step ~= 1
    SAMPLE=1000;
    ident=zeros(SAMPLE,1);
    idcount=0;
    for newsample = 1 : NCON    % generate sampling distribution
      num=floor(SAMPLE*weights(newsample,step-1));  % number of samples to generate
      if num > 0
        ident(idcount+1:idcount+num) = newsample*ones(1,num);
        idcount=idcount+num;
      end
    end
  end

  % generate NCON new state vectors
  for newsample = 1 : NCON

    % sample randomly from the auxiliary array ident()
    if step==1 % make a random vector
      xc = [floor(MC*rand(1)),floor(MR*rand(1)),0,0]'; %'
    else
      oldsample = ident(ceil(idcount*rand(1))); % select which old sample
      xc(:) = x(oldsample,step-1,:);  % get its state vector

      % sample about this vector from the old distribution (assume no covariance)
      for n = 1 : 4
        xc(n) = xc(n) + 5*sqrt(P(oldsample,step-1,n,n))*randn(1);
      end
    end

    % hypothesize if it is going into a bounce or tabletop state
    if step == 1    % initial time - assume falling
      xp = xc;   % no process at start
      A = A3;
      Bu = Bu3;
      trackstate(newsample,step)=3;
    else
      if trackstate(oldsample,step-1)==1  % if already stopped bouncing
        A = A1;
        Bu = Bu1;
        xc(4) = 0;
        trackstate(newsample,step)=1;     % stay stopped bouncing
      else
        r=rand(1);   % random number for state selection
        if r < pstop
          A = A1;
          Bu = Bu1;
          xc(4) = 0;
          trackstate(newsample,step)=1;
        elseif r < (pbounce + pstop)
          A = A2;
          Bu = Bu2;
          % add some random vertical motion due to imprecision
          % about time of bounce
          xc(2) = xc(2) + 3*abs(xc(4))*(rand(1)-0.5); 
          xc(4) = -xc(4)*loss;  % invert vertical velocity (lossy)
          trackstate(newsample,step)=2;  % set into bounce state
        else % normal motion
          A = A3;
          Bu = Bu3;
          trackstate(newsample,step)=3;
        end
      end
      xp=A*xc + Bu;      % predict next state vector
    end

    % update & evaluate new hypotheses via Kalman filter
    % predictions
    for u = 1 : 4 % extract old P()
    for v = 1 : 4
      TP(u,v)=P(oldsample,step-1,u,v);
    end
    end
    PP = A*TP*A' + Q;    % ' predicted error
    % corrections
    K = PP*H'*inv(H*PP*H'+R);      % gain
    x(newsample,step,:) = (xp + K*([cc(step),cr(step)]' - H*xp))';    % corrected state
    P(newsample,step,:,:) = (eye(4)-K*H)*PP;                          % corrected error

    % weight hypothesis by distance from observed data
    dvec = [cc(step),cr(step)] - [x(newsample,step,1),x(newsample,step,2)];
    weights(newsample,step) = 1/(dvec*dvec'); %'

    % draw some samples over one image
%    if step == 15 & fig1 > 0
      figure(fig1)
      hold on
      for c = -0.99*radius: radius/10 : 0.99*radius
        r = sqrt(radius^2-c^2);
        if trackstate(newsample,step)==1                 % stop
          plot(x(newsample,step,1)+c,x(newsample,step,2)+r,'c.')
          plot(x(newsample,step,1)+c,x(newsample,step,2)-r,'c.')
        elseif trackstate(newsample,step)==2             % bounce
          plot(x(newsample,step,1)+c,x(newsample,step,2)+r,'y.')
          plot(x(newsample,step,1)+c,x(newsample,step,2)-r,'y.')
        else                                  % normal
          plot(x(newsample,step,1)+c,x(newsample,step,2)+r,'k.')
          plot(x(newsample,step,1)+c,x(newsample,step,2)-r,'k.')
        end
      end
%    end
  end
  
  % rescale new hypothesis weights
  totalw=sum(weights(:,step)'); %'
  weights(:,step)=weights(:,step)/totalw;

  % select top hypothesis to draw
  subset=weights(:,step);
  top = find(subset == max(subset));
  trackstate(top,step);

  % display final top hypothesis
  if fig1 > 0
    figure(fig1)
    hold on
    for c = -0.99*radius: radius/10 : 0.99*radius
      r = sqrt(radius^2-c^2);
%      plot(x(top,step,1)+c,x(top,step,2)+r+1,'b.')
%      plot(x(top,step,1)+c,x(top,step,2)+r,'y.')
      plot(x(top,step,1)+c,x(top,step,2)+r,'r.')
      plot(x(top,step,1)+c,x(top,step,2)-r,'r.')
%      plot(x(top,step,1)+c,x(top,step,2)-r,'y.')
%      plot(x(top,step,1)+c,x(top,step,2)-r-1,'b.')
    end
%    eval(['saveas(gcf,''COND/cond',int2str(step-1),'.jpg'',''jpg'')']);  
  end

      pause(0.5) % wait a bit for the display to catch up
end
