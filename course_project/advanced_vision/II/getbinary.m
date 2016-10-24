% return a cleaned binary image from the initial parameter
% additional parameters specify figures for display (0 = no display)

% Code: Robert B. Fisher
% Additional comments: Toby P Breckon

function cleanimage = getbinary(image,fig3,fig4,fig5,fig6,fig7)

     hist = dohist(image,fig3);                 % histogram image (dohist.m)
     
     thresh = findthresh(hist,4,fig4);          % find threshold (findthres.m)
     
     binimage = ~im2bw(image,thresh/255);       % do thresholding

     if fig5 > 0
       figure(fig5)
       colormap(gray)
       imshow(binimage)
     end

     largestimage = getlargest(binimage,fig6);   % get biggest region (getlargest.m)
     
     cleanimage = cleanup(largestimage,2,2,fig7); % clean up region (cleanup.m)
                                                        
