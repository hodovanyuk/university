function cleanIm = erode(Imwork,Imback)
    [MR,MC] = size(Imwork);
 % subtract background & select pixels with a big difference
    fore = zeros(MR,MC);
    fore = (abs(Imwork(:,:,1)-Imback(:,:,1)) > 10) ...
     | (abs(Imwork(:,:,2) - Imback(:,:,2)) > 10) ...
     | (abs(Imwork(:,:,3) - Imback(:,:,3)) > 10);
    % erode to remove small noise
    cleanIm = bwmorph(fore,'erode',2);
end