function Im = loadImage(step)
    
    if step < 11
        Im = (imread(['DATA/ball0000010',int2str(step-1), '.jpg'],'jpg')); 
    else
        Im = (imread(['DATA/ball000001',int2str(step-1), '.jpg'],'jpg')); 
    end
    Im = double(Im);
end