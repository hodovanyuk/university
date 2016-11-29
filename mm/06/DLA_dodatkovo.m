% DLA
clc;clear all;close all;
N = 160;
N1 = N/10;
N2 = N - N1;
K = 5000;
DLA = zeros(N,N); 
PRINT = zeros(N,N);
imh = image(cat(3,(DLA==0),(DLA==1),(DLA==2)));
% pause(.5);
for k = 1 : K
    for i = 2 : 2 : N - 1
        DLA(N - 1,i) = 1;
        DLA(N - 1,i + 1) = 2;
    end
    x = randi([N1 N2]);
    y = randi([N1 N2]);
    DLA(x,y) = 1;
    flag1 = 1;
    while flag1 == 1
        r = randi([1 4]); % вибираємо напрямок руху частинки
        if r == 1 % вверх
            DLA(x,y) = 0;
            x = x - 1;
            DLA(x,y) = 1;
        end
        if r == 2 % вправо
            DLA(x,y) = 0;
            y = y + 1;
            DLA(x,y) = 1;
        end
        if r == 3 % вниз
            DLA(x,y) = 0;
            x = x + 1;
            DLA(x,y) = 1;
        end
        if r == 4 % вліво
            DLA(x,y) = 0;
            y = y - 1;
            DLA(x,y) = 1;
        end
        if (DLA(x-1,y)==1) || (DLA(x+1,y)==1) ...
           || (DLA(x,y+1)==1) || (DLA(x,y-1)==1)
            flag1 = 0;
        end
        if (x == 2 || y == 2 || x == N - 1 || y == N - 1)
            DLA(x,y) = 0;
            flag1 = 0;
        end
    end
    x = randi([N1 N2]);
    y = randi([N1 N2]);
    DLA(x,y) = 2;
    flag2 = 2;
    while flag2 == 2
        r = randi([1 4]); % вибираємо напрямок руху частинки
        if r == 1 % вверх
            DLA(x,y) = 0;
            x = x - 1;
            DLA(x,y) = 2;
        end
        if r == 2 % вправо
            DLA(x,y) = 0;
            y = y + 1;
            DLA(x,y) = 2;
        end
        if r == 3 % вниз
            DLA(x,y) = 0;
            x = x + 1;
            DLA(x,y) = 2;
        end
        if r == 4 % вліво
            DLA(x,y) = 0;
            y = y - 1;
            DLA(x,y) = 2;
        end
        if (DLA(x-1,y)==2) || (DLA(x+1,y)==2) ...
           || (DLA(x,y+1)==2) || (DLA(x,y-1)==2)
            flag2 = 0;
        end
        if (x == 2 || y == 2 || x == N - 1 || y == N - 1)
            DLA(x,y) = 0;
            flag2 = 0;
        end
    end
    set(imh,'cdata',cat(3,(DLA==0),(DLA==1),(DLA==2)))
    drawnow
    pause(.0000001);
end