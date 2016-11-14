clc
clear all

n=64;
 
old = zeros(n,n);
new = zeros(n,n);
count = zeros(n,n);
old(32, 32) = 1;
imh = image(cat(3,old,old,old));
set(imh, 'erasemode', 'none')
axis equal
axis tight
% 0 = health
% 1 = sick
% 2 = not sick

for k=1:100
    
    for i=2:n-1
        for j=2:n-1
            
            if old(i,j)==1
                 
               
                if count(i,j) == 6
                    count(i,j) = 0;
                    new(i,j) = 2;
                else
                    
                    for x=i-1:i+1
                        for y=j-1:j+1
                            if rand()<0.3 && old(x,y)==0
                                new(x,y) = 1;
                                
                            end
                        end
                    end
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
    pause (0.9)
end

