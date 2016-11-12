clc;clear all;
%init
n = 64;
old = ones(n,n);
%depth of field
d = 2;
%board
old(:,1) = zeros(n,1);
old(:,n) = old(:,1);
old(1,:) = old(:,1);
old(n,:) = old(:,1);
%gate
old(1,n/2-1:n/2+1) = 1;
%wall
old(n/2-5,n/2-3:n/2+3) = 0;
old(n/2+5,n/2-3:n/2+3) = 0;
% empty template
template = old;
%crowd
old(5,n-5) = 2;
old(n/2,n/2) = 2;
%old = round((n-5).*rand(5,2)+5);
new = template;
imh = image(cat(3,old,old,old));
%main loop
while true
    %analisys
    %loop over all board
    for i=1+d:n-d
        for j=1+d:n-d
            %if cell is human work with it
            if old(i,j)==2
                %calculate probability to walk up left right
                pu = 1 - 1/d * sum( old( i-d : i-1, j ) ); 
                pl = 1 - 1/d * sum( old( i, j-d : j-1 ) );
                pr = 1 - 1/d * sum( old( i, j+1 : j+d ) );
                %	chose max probability
                [~,idx] = min([ pu, pl, pr]);
                %make step
%                 f_step = @(t)[cos(deg2rad(t)),sin(deg2rad(t));-sin(deg2rad(t)),cos(deg2rad(t))];
%                 step =  round([0 1]*f_step(m_idx*270));
%                 new(i+step(1),j+step(2)) = 2;
                if idx == 1
                    new(i-1,j) = 2;
                elseif idx == 2
                    new(i,j-1) = 2;
                elseif idx == 3
                    new(i,j+1) = 2;
                end
            end	
        end
    end
    % update old state
    old = new;
    % clear new
    new = template;
    %draw
    set(imh,'cdata',cat(3,(old==2),old,old))
    drawnow
    pause(.9);
end



%plot(crowd_old(:, 1),crowd_old(: ,2),'.')
%axis([0 n 0 n])
