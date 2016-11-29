% DLA
clc;clear all;close all;
N = 200;
K = 100;
DLA = zeros(N,N); 
imh = image(cat(2,(DLA==0),(DLA==1)));
pause(.5);
for k = 1 : K
    DLA(N/2,N/2) = 1;
    x = randi([20 180]);
    y = randi([20 180]);
    DLA(x,y) = 1;
    flag = 1;
    while flag 
        if (DLA(x-1,y)==1) || (DLA(x+1,y)==1) ...
           || (DLA(x,y+1)==1) || (DLA(x,y-1)==1)
            flag = 0;
        end
        if (x == 1 || y == 1 || x == N || y == N)
            DLA(x,y) = 0;
            flag = 0;
        end
        r = randi([1 4]); % �������� �������� ���� ��������
        if r == 1 % �����
            DLA(x,y) = 0;
            x = x - 1;
            DLA(x,y) = 1;
        end
        if r == 2 % ������
            DLA(x,y) = 0;
            y = y + 1;
            DLA(x,y) = 1;
        end
        if r == 3 % ����
            DLA(x,y) = 0;
            x = x + 1;
            DLA(x,y) = 1;
        end
        if r == 4 % ����
            DLA(x,y) = 0;
            y = y - 1;
            DLA(x,y) = 1;
        end
    end
    set(imh,'cdata',cat(2,(DLA==0),(DLA==1)))
    drawnow
    pause(.00001);
end