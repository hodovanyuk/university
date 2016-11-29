function plotTargets(figName,bitMap,targets,Imwork)
    [N,W] = size(targets);
    figure(figName)
    hold on
    clf
%     imshow(Imwork)
    imshow(bitMap)
    velUnit = 1;
    for i=1:N
        figure(1)
        hold on
        x =  targets(i).Centroid(1);
        y =  targets(i).Centroid(2);
        
        if isfield(targets, 'Vel')
            vel = targets(i).Vel;
            if ~isempty(vel)
                viscircles([x,y], [vel],'LineStyle','--');
            else
                viscircles([x,y], [velUnit],'LineStyle','--');
            end
            plot(x,y,'*r')
        end
        
    end

end