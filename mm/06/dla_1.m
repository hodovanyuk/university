% DLA
clc;clear all;close all;
N = 200;
N1 = N/10;
N2 = N - N1;
K = 2000;
DLA = zeros(N,N); 
imh = image(cat(3,1-(DLA==0)/2,1-(DLA<0)/2,1-(DLA>0)/2));
pause(.5);
for k = 1 : K
    DLA(N/2,N/2) = 1;
    x = randi([N1 N2]);
    y = randi([N1 N2]);
    DLA(x,y) = 1;
    flag = 1;
    while flag 
        up = [x-1, y];
        right = [x, y+1];
        down = [x+1, y];
        left = [x, y-1];
        pos = [up;right;down;left];
        r = randi([1 4]);
        
        DLA(x,y) = 0;
        x = pos(r,1);
        y = pos(r,2);
        DLA(pos(r,1),pos(r,2)) = 1;

        if (DLA(x-1,y)==1) || (DLA(x+1,y)==1) ...
           || (DLA(x,y+1)==1) || (DLA(x,y-1)==1)
            flag = 0;
        end
        
        if (x == 2 || y == 2 || x == N - 1 || y == N - 1)
            DLA(x,y) = 0;
            flag = 0;
        end
    end
    set(imh,'cdata',cat(3,1-(DLA==0)/2,1-(DLA<0)/2,1-(DLA>0)/2))
    drawnow
    pause(.00001);
end