clc
clear all

n=64;
 
old = zeros(n,n);
new = zeros(n,n);
count = zeros(n,n);
imh = image(cat(3,old,old,old));
set(imh, 'erasemode', 'none')
axis equal
axis tight
% 0 = health
% 1 = sick
% 2 = not sick
old(32, 32) = 1;
for k=1:100
    
    
    for i=2:n-1
        for j=2:n-1
            
            if old(i,j)==1
                 if rand()<0.5
                    switch 1 + round((8-1)*rand)
                        case 1
                            if old(i-1,j-1) == 0
                                new(i-1,j-1) = 1;
                                count(i-1,j-1) = 0;
                            end
                        case 2
                            if old(i,j-1) ==0
                               new(i,j-1) =1;
                                count(i,j-1) = 0;
                            end
                        case 3
                            if old(i-1,j+1) == 0
                                new(i-1,j+1) =1;
                                 count(i-1,j+1) = 0;
                            end
                        case 4
                            if old(i,j+1) == 0
                                new(i,j+1) = 1;
                                 count(i,j+1) = 0;
                            end
                        case 5
                            if old(i+1,j+1) == 0
                                new(i+1,j+1) = 1;
                                 count(i+1,j+1) = 0;
                            end
                        case 6
                            if old(i+1,j) == 0
                                new(i+1,j) = 1;
                                 count(i+1,j) = 0;
                            end
                        case 7
                            if old(i+1,j-1) == 0
                                new(i+1,j-1) = 1;
                                 count(i+1,j-1) = 0;
                            end
                        otherwise
                            if old(i-1,j) == 0
                                new(i-1,j) = 1;
                                 count(i-1,j) = 0;
                            end
                    end
                    
                end
                if count(i,j) == 6
                    count(i,j)= 0;
                    new(i,j) = 2;
                else
                    count(i,j)= count(i,j)+1;
                end
            end
            
            if old(i,j)==2
                if count(i,j) == 4
                    count(i,j) =0;
                    new(i,j)=0;
                else
                    count(i,j)= count(i,j)+1;
                end
            end
            
        end
    end
   
   
    set(imh, 'cdata', cat(3,(old==1),(old==0),(old==2)))
    drawnow
    old = new;
    pause (0.1)
end

