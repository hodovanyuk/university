clc;clear all;close all;
N = 64;

old = zeros(N,N);
new = zeros(N,N);

old(N/2,N/2) = 1;
imh = image(cat(3,old,old,old));
while true
    for i = 1 : N
        for j = 1 : N
            if old(i,j)==1
                x_n = i;
                y_n = j+1;
                if y_n > 64
                    y_n = 1;
                end
                
                new(x_n,y_n) = 1;
            end

        end
    end
    old = new;
    new = zeros(N,N);
    set(imh,'cdata',cat(3,old,old,old))
    drawnow
    pause(.1);
end
% init
old = zeros(N,N);
f_step = @(t)[cos(deg2rad(t)),sin(deg2rad(t));-sin(deg2rad(t)),cos(deg2rad(t))];
% add sharks and fishes with rand age
for i=1:N
    for j=1:N
        if rand>0.3
            old(i,j) = 1;
        else
            old(i,j) = -1;
        end
    end
end

for i=1:N
    for j=1:N
% fishes move
        if old(i,j)>0
% on new layer move fish to new position
            up = 1 - (old(i-1,j)~=0);
            right = 2 - 2*(old(i,j+1)~=0);
            down = 3 - 3*(old(i+1,j)~=0);
            left = 4 - 4*(old(i,j-1)~=0);
            pos = [up,right,down,left];
            pos = find(pos~=0);
            r_idx = round((length(pos)-1)*rand + 1);
            step =  round([0 1]*f_step(pos(r_idx)*90));
            %case when new place is already filled
            if new(step(1),step(2)) ~= 0
                if rand>0.5
                     new(step(1),step(2)) = old(i,j) + sqrt(old(i,j)^2)/old(i,j);
                end
            else 
                new(step(1),step(2)) = old(i,j) + sqrt(old(i,j)^2)/old(i,j);
            end            
% if old(i,j)/fbreed == 1 ->  put on old fish place one child 
            if old(i,j)/fbreed == 1
                new(i,j) = 1;
            end
        end

% sharks move
        if old(i,j) < 0
% if fish near shark, shark moves on it place
           %
           %
           %
           
           % add torus 
           
           %
           %
           %
% if shark haven't meet fish for nstave steps it die
        end

    end
end
