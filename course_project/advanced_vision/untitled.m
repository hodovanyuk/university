   x=1;y=1;S=1;
    hold on
    grid on
    r = sqrt(x^2+y^2);
    
    
    a = 2*S/r;
    A = [0, 0];
    B = [r a/2];
    C = [r -a/2];
    
    plot([A(1) B(1) C(1) A(1)], [A(2) B(2) C(2) A(2)], 'g')
    
%     theta =  atan(y/x);
%     trM = [cos(theta) sin(theta); -sin(theta) cos(theta)];
for i=1:45
    
    theta = i;
    
    trM = [cosd(theta) sind(theta); -sind(theta) cosd(theta)];
    
    An = trM * A';
    Bn = trM * B';
    Cn = trM * C';
    
%     tform = affine2d([cosd(theta) -sind(theta) 0; sind(theta) cosd(theta) 0; 0 0 1]);
%     A = transformPointsForward(tform,A);
%     B = transformPointsForward(tform,B);
%     C = transformPointsForward(tform,C);
    
   plot([An(1) Bn(1) Cn(1) An(1)], [An(2) Bn(2) Cn(2) An(2)], 'r')
% plot([An(1) Bn(1)], [An(1) Bn(2)], 'r')
   pause(0.1)
   axis([-2 2 -2 2])
end