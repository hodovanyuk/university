rows=288;
cols=384;
bgsigma=zeros(rows,cols);
bgsave=uint8(zeros(rows,cols,3,50));
bghistory = zeros(rows,cols,3,50);
bgdiff=zeros(49,1);

% use first 50 images to estiamte statistics
for i = 0 : 50
i
  % load image
  if i < 10
    currentimagergb = imread(['JPEGS/Browse1000',int2str(i),'.jpg'],'jpg');
    bgsave(:,:,:,i+1)=currentimagergb;
  elseif i < 100
    currentimagergb = imread(['JPEGS/Browse100',int2str(i),'.jpg'],'jpg');
    bgsave(:,:,:,i+1)=currentimagergb;

% initialize background model for (normalised red, normalised green, saturation)
    if i==49
      for r = 1:rows
r
        for c = 1 : cols
          % convert to chromaticity
	  for k = 1 : 50
	    R=double(bgsave(r,c,1,k)); 
	    G=double(bgsave(r,c,2,k)); 
	    B=double(bgsave(r,c,3,k)); 
            rgbsum=(R+G+B);
            sat = rgbsum/3;
            if rgbsum == 0
	      rgbsum=1;
            end
            red = R/rgbsum;
            green = G/rgbsum;
            bghistory(r,c,1,k)= red;
            bghistory(r,c,2,k)= green;
            bghistory(r,c,3,k)= sat;
          end

          % estimate sigma using robust estimator to avoid outliers
	  for k = 1 : 49
	    bgdiff(k) = abs(bghistory(r,c,1,k) - bghistory(r,c,1,k+1));
          end

          % compute sigma
          bgsigma(r,c)=median(bgdiff)/(0.68*sqrt(2));
          
          % hypothesise initial history with median value in case foreground present
          rmed = median(bghistory(r,c,1,:));
          bghistory(r,c,1,:) = rmed + bgsigma(r,c)*randn(50,1);
          gmed = median(bghistory(r,c,2,:));
          bghistory(r,c,2,:) = gmed + bgsigma(r,c)*randn(50,1);
          smed = median(bghistory(r,c,3,:));
          bghistory(r,c,3,:) = smed + bgsigma(r,c)*randn(50,1);
        end
      end

      % show std deviation across image
      figure(1)
      image(bgsigma*2000)
      colormap(gray)
      figure(2)

      % plot reconstructed distribution
      for k=1:50
	x(k) = bghistory(100,100,1,k);
        xc(k) = k/50;
      end
      xh = hist(x,xc);
      plot(xc,xh)

      % save background model for detection
      save bginitp bgsigma bghistory
    end

  else
    currentimagergb = imread(['JPEGS/Browse10',int2str(i),'.jpg'],'jpg');
  end

end
