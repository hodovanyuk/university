clc;clear all;close all;
% init
N = 164;
old = zeros(N,N);
new = old;
f_step = @(t)[cos(deg2rad(t)),sin(deg2rad(t));-sin(deg2rad(t)),cos(deg2rad(t))];
fbreed = 1;
nstarve = 6;
sbreed = 1;
energy_point = 4;
% fbreed = 1;
% nstarve = 6;
% sbreed = 1;
% energy_point = 4;
% add sharks and fishes with rand age
for i=1:N
    for j=1:N
        r = rand;
        if r>0.8
            old(i,j) = 0;
        elseif r<=0.8 && r >=0.3
            old(i,j) = -1;
        else
            old(i,j) = 1;
        end
    end
end
old(1,1) = -1;
old(1,2) = 1;
imh = image(cat(3,(old<0),(old>0),old));
  pause(3.9);
while true
% for step =1:2
    for i=1:N
        for j=1:N
        iup = [ (i-1<1)*N+(i>=1)*(i-1) j ];
        iright = [ i (j+1>N)+(j+1<=N)*(j+1)];
        idown = [ (i+1>N)+(i+1<=N)*(i+1) j ];
        ileft = [ i (j-1<1)*N+(j>=1)*(j-1) ];
        new_idx = [ iup; iright; idown; ileft ];
    % fishes move
            if old(i,j)>0
    % on new layer move fish to new position
                up = (old(iup(1),iup(2))==0);
                right = 2*(old(iright(1),iright(2))==0);
                down = 3*(old(idown(1),idown(2))==0);
                left = 4*(old(ileft(1),ileft(2))==0);
                pos = [up,right,down,left];
                pos = find(pos~=0);
                if ~isempty(pos)
                    %there is  free space around
                    rand_idx = round((length(pos)-1)*rand + 1);
                    new(new_idx(pos(rand_idx), 1),new_idx(pos(rand_idx), 2)) = old(i,j) + 1;  
                    % if old(i,j)/fbreed == 1 ->  put on old fish place one child 
                    if mod( new(new_idx(pos(rand_idx), 1),new_idx(pos(rand_idx), 2)),fbreed) > 1
                        new(i,j) = 1;
                        new(new_idx(pos(rand_idx), 1),new_idx(pos(rand_idx), 2)) = mod( new(new_idx(pos(rand_idx), 1),new_idx(pos(rand_idx), 2)),fbreed);
                    end
                else
                    %there is no free scpace around
                    new(i,j) = old(i,j) + 1;
                    if mod( new(i,j),fbreed) > 1
                        new(i,j) = 1;
                    end
                end

            end
        
            % sharks move
            if old(i,j) < 0
                % if fish is near the shark, shark moves on it place
                % find fishes around shark
                up = ( old(iup(1), iup(2)) > 0 );
                right = 2*( old(iright(1), iright(2)) > 0 );
                down = 3*( old(idown(1), idown(2)) > 0 );
                left = 4*( old(ileft(1), ileft(2)) > 0 );
                % make array of around state
                pos = [up,right,down,left];
                % let stay only places where fish is
                pos = find(pos~=0);
                % check if any fish around
                if ~isempty(pos)
                    % we have at least one fish around
                    % make random choise of future place
                    % shark defently not die from starve
                    rand_idx = round((length(pos)-1)*rand + 1);
                    new(new_idx(pos(rand_idx), 1),new_idx(pos(rand_idx), 2)) = old(i,j) - energy_point;
                    % check if shark could produce breed
                    if abs(new(new_idx(pos(rand_idx), 1),new_idx(pos(rand_idx), 2))) > sbreed
                        if mod(abs(new(new_idx(pos(rand_idx), 1),new_idx(pos(rand_idx), 2))),sbreed) > 0
                            new(i,j) = -1; 
                            new(new_idx(pos(rand_idx), 1),new_idx(pos(rand_idx), 2)) = mod(abs(new(new_idx(pos(rand_idx), 1),new_idx(pos(rand_idx), 2))),sbreed);
                        end
                    end
                else
                    %check if shar still have energy point
                    old(i,j) = old(i,j) + 1;
                    if old(i,j) < 0
                        % there is no fish around, let find free place for
                        % shark
                        up = (old(iup(1),iup(2))~=0);
                        right =  2*(old(iright(1),iright(2))~=0);
                        down = 3*(old(idown(1),idown(2))~=0);
                        left = 4*(old(ileft(1),ileft(2))~=0);
                        pos = [up,right,down,left];
                        pos = find(pos~=0); 
                        % check if there are free places around shark
                        if ~isempty(pos)
                            % there are free places around shark
                            rand_idx = round((length(pos)-1)*rand + 1);
                            new(new_idx(pos(rand_idx), 1),new_idx(pos(rand_idx), 2)) = old(i,j) - 1;
                        else
                            % there is no free places around shark, it will
                            % stay on the same place
                            new(i,j) = old(i,j) - 1;
                        end
                    end
                    
                end
                
            end

        end
    end
    old = new;
    new = zeros(N,N);
    set(imh,'cdata',cat(3,(old<0),(old>0),old))
    drawnow
    pause(1.5);
end