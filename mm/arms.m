
clc; clear all; 
sx   = .09; sy  = .12;     
gx   = .02; gy  = .01;
fx   = .15; fy  = .05;
maxt = 100;          

X(1)=15; Y(1)=20;

for t=1:maxt-1     
  X(t+1) = X(t) + sx*Y(t) - fx*X(t) + gx;  
  Y(t+1) = Y(t) + sy*X(t) - fy*Y(t) + gy;  
end;

plot(1:maxt,X,1:maxt,Y); 
legend('X','Y',2); xlabel('Time'); ylabel('Level');
title(['sx:' num2str(sx) '  sy:' num2str(sy) '  fx:' num2str(fx) '  fy:' num2str(fy) '  gx:' num2str(gx) '  gy:' num2str(gy)]);
