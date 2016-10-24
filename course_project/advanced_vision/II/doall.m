% full recognition process for 2D rigid geometric parts

% Code: Robert B. Fisher
% Additional comments: Toby P Breckon

function doall

  % basic values - defined as globals (see help global)
   
  global Nummodels Models ModelLength numlines datalines currentimage
  global parallelthresh septhresh overlapthresh scalefactor
  global unarydelta binarydelta
  
  % load pre-defined model representations of our parts (see loadmodels.m)
  
  loadmodels

  % parameters - thresholds etc. for various procedures
  
  parallelthresh = 0.9;
  septhresh = 15;
  overlapthresh = 0.2;
  unarydelta = 0.3;
  binarydelta = 0.2;
  
  % user inputs - X/Y scale factor (assumed uniform in X and Y)
  
    % rescale for this image: TESTDATA1/f = 30.9 pixels/cm
    scalefactor = input('Input model to image scale factor (float)\n?');

    % see if using live data (i.e. from camera)
    livedata = input('Want to use live test data (0,1)\n?');
    
    % TESTDATA1/f
    imagestem = input('Test image file stem (filestem)\n?','s');
  
  % recognition phase (loop)
  
  run=1;
  imagenum=0;
  scatter = zeros(3,4);
  while ~(run == 0)
     imagenum = imagenum + 1;
     
     % get image and convert to grayscale
     
     if livedata == 1
       currentimagergb = liveimagejpg([imagestem,int2str(imagenum),'.jpg']);
     else
       currentimagergb = imread([imagestem,int2str(imagenum),'.jpg'],'jpg');
     end
     currentimage = rgb2gray(currentimagergb);

        % uncomment these following 3 lines to display greayscale image:
        
        %     figure(1)
        %     colormap(gray)
        %     imshow(currentimage)

     % threshold using IVR threshold method (getbinary.m)
     
        % uncomment following line to see the various stages/items of
        % thresholding:
     
        %     Image = getbinary(currentimage,2,3,4,5,6)
     
     Image = getbinary(currentimage,0,0,0,0,0);
     
     % get size of image as H,W
     
     [H,W] = size(Image);
     
     % extract boundary pixels using method of lectures
     
     [r,c] = find( bwperim(Image,4) == 1 );
     
     % uncomment following lines to display boundary:
     
           %	  figure(10)
           %	  clf
           %	  plot(c,r,'.')
           %	  axis ij
           %	  axis([0,W,0,H])

     % clean boundary using method presented in lectures (removespurs.m)
           
           % changes last parameter to 7 to display result
           % in figure 7
     
     [sr,sc] = removespurs(r,c,H,W,0);          %fig7
     
     
     % track boundary using method presented in lectures (boundarytrack.m)
     
     
     [tr,tc] = boundarytrack(sr,sc,H,W,0);      %fig8

     datalines = zeros(100,4);         % space for results
     numlines = 0;
     
     % segment boundary using method presented in lectures (findcorners.m)
     
     findcorners(tr,tc,H,W,9,6);
     
     datalines(1:numlines,:)
     
     % recognition using model matching (IT algorithm), 
     % pose estimation and verification approach (geomrecognize.m)
     
     identity = geomrecognize(Nummodels,Models,ModelLength);

     % get true class for scatter matrix
     
     trueclass=input(['true class (1..3)\n?']);
     scatter(trueclass,identity) = scatter(trueclass,identity) + 1;

     % loop through further images in filestem provided
     
     run = input(['Want to process another image ',int2str(imagenum+1),' (0,1)\n?']);
  end

  % output scatter matrix
  
  % ['scatter matrix (rows are true, cols are classified - last col is unrecognized)']
  % scatter

