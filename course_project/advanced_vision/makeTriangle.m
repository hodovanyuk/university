function [A,B,C] = makeTriangle(x,y,S)
    r = sqrt(x^2+y^2);
    a = 2*S/r;
    A = [0, 0];
    B = [r a/2];
    C = [r -a/2];
    theta = atan(y/x);
    trM = [cos(theta) sin(theta); -sin(theta) cos(theta)];
    A = trM * A';
    B = trM * B';
    C = trM * C';
end