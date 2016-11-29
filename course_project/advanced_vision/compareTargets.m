function newTargets = compareTargets(oldTargets,newTargets)
velocityCoeficient = 1; 
maxJump = 120;
minArea = 20;
    if ~isempty(oldTargets)
%         do compare
        newTargets = newTargets([newTargets(:).Area] > minArea);
        nNewTargets = size(newTargets,1);
        
%         find pair
        if isfield(oldTargets, 'Vel')
%             velocity is exist and we make wiser prediction
%             make triangle for curent target
            
%             check what new 
        else
%             there is no velocity and pares will built with closest
            for i=1:nNewTargets
                minDist = inf;
                iMin = 0;
                vX = 0;
                vY = 0;
                x1 = newTargets(i).Centroid(1);
                y1 = newTargets(i).Centroid(2);
                nOldTargets = size(oldTargets,1);
                if size(oldTargets,2) ~= 0
                    for j=1:nOldTargets
                        if sqrt((newTargets(i).Area-oldTargets(j).Area)^2) < newTargets(i).Area*2

                            x2 = oldTargets(j).Centroid(1);
                            y2 = oldTargets(j).Centroid(2);
                            dist = sqrt((x1-x2)^2+(y1-y2)^2);
                            jump = dist*2;
                            if dist < minDist && dist < jump
                                minDist = dist;
                                iMin = j;
                                vX = x1 - x2;
                                vY = y1 - y2;
                            end
                        end
                    end
                    if iMin ~= 0 
                        newTargets(i).Vel = minDist*velocityCoeficient;
                        newTargets(i).dir = [vX,vY];
                        oldTargets(iMin) = [];
                    end
                end
            end
        end

%         make prediction triangle from speed vector
        
%         make Radius eq to difference between previus and curent position
    end
    
end