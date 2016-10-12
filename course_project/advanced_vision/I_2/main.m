T = @(theta,t) [cos(theta) -sin(theta) t(1);sin(theta) cos(theta) t(2) ;0 0 1];

x = [10 20 1];
theta = pi/2;
t = [-10 30];
%disp(T(theta,t));
%disp(x);
disp(T(theta,t)*x');
%disp(x*T(theta,t))
