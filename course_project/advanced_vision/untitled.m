clc;
clear all;
Im = zeros(100,100);
% imshow(Im);
h = 5;
S = 10;
% S = 1/2 a h
a = 2*S/h;
A = [0 0];
B = [0 a/2];
C = [0 -a/2];

theta = 180;
M = [cos(theta) sin(theta); -sin(theta) cos(theta)];

B_new = M*B';