clc
clear all
Im0 = double(imread('DATA/ball00000100.jpg','jpg'));
Im1 = double(imread('DATA/ball00000101.jpg','jpg'));
Im2 = double(imread('DATA/ball00000102.jpg','jpg'));
Im3 = double(imread('DATA/ball00000103.jpg','jpg'));
Im4 = double(imread('DATA/ball00000104.jpg','jpg'));
Imwork = double(imread('DATA/ball00000115.jpg','jpg'));
Imback = (Im0 + Im1 + Im2 + Im3 + Im4)/5;

 % subtract background & select pixels with a big difference

[MR,MC,Dim] = size(Imback);
fore = zeros(MR,MC);
fore = (abs(Imwork(:,:,1)-Imback(:,:,1)) > 10) ...
 | (abs(Imwork(:,:,2) - Imback(:,:,2)) > 10) ...
 | (abs(Imwork(:,:,3) - Imback(:,:,3)) > 10);
figure(1)
clf

% erode to remove small noise
foremm = bwmorph(fore,'erode',2);

imshow(foremm)

labeled = bwlabel(foremm,4);
stats = regionprops(labeled,['basic']);
[N,W] = size(stats);

centroid = stats(1).Centroid;
radius = sqrt(stats(1).Area/pi);
cc = centroid(1);
cr = centroid(2);
hold on
for c = -0.97*radius: radius/10 : 0.97*radius
  r = sqrt(radius^2-c^2);
  plot(cc+c,cr+r,'g.','markersize', 10)
  plot(cc+c,cr-r,'g.')
end