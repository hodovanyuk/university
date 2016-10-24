% use probabilistic method of foreground detection

rows=288;
cols=384;
alpha=0.8;
beta=1.2;
tau=0.05;
SIGMAFUDGE=6;

bgsigma=zeros(rows,cols);
fgprob=zeros(rows,cols);
bgthresh=zeros(rows,cols);
bghistory = zeros(rows,cols,3,50);

% load bg history model
load bginitp bgsigma bghistory

% process first 99 images
for i = 0 : 99
i
  if i < 10
    currentimagergb = imread(['JPEGS/Browse1000',int2str(i),'.jpg'],'jpg');
  elseif i < 100
    currentimagergb = imread(['JPEGS/Browse100',int2str(i),'.jpg'],'jpg');
  else
    currentimagergb = imread(['JPEGS/Browse10',int2str(i),'.jpg'],'jpg');
  end

      for r = 1:rows %200:250%1:rows/10 %14:14 %1:rows/10
[i,r]
        for c = 1 : cols%200:250%1 : cols/10 %25:25 %1 : cols/10

            % compute cromaticity coordinates
            R=double(currentimagergb(r,c,1)); 
            G=double(currentimagergb(r,c,2)); 
            B=double(currentimagergb(r,c,3)); 
            rgbsum=(R+G+B);
            sat = rgbsum/3;  % and saturation
            if rgbsum == 0
              rgbsum=1;
            end
            red = R/rgbsum;
            green = G/rgbsum;
            sigma = bgsigma(r,c);
            if sigma == 0
              sigma=0.05;
            end

            % search history at pixel for samples that satisfy saturation ratio test
            prob = 0;
            count=0;
            for k = 1 : 50
              if bghistory(r,c,3,k) > 0
                ratio = sat/bghistory(r,c,3,k);
              else
	        ratio = sat/10;
              end
              if alpha < ratio && ratio < beta
                count = count+1;
                prob = prob + kernel(sigma,red-bghistory(r,c,1,k))* ...
                       kernel(sigma,green-bghistory(r,c,2,k));
              end
            end
            if count > 0 
              p_x_b = (prob/count);
              p_b = 0.99;     % rough estimate of % a pixel is BG. Should compute.
              p_x_f= 0.001;   % rough estimate of prob that this foreground pixel value
                              % is chosen. Assumes all FG values possible uniformly and
                              % there are 1000 FG values. Ought to compute this given
                              % some (r,g) samples
              p_b_x = (p_x_b * p_b) / (p_x_f * (1-p_b) + p_x_b * p_b);

              fgprob(r,c)=1-p_b_x; % prob of foreground
              if fgprob(r,c) > (1-tau)
                % colour different enough that foreground
                bgthresh(r,c)=1;
              else
                % found background pixel, so update background model
                bgthresh(r,c)=0;
                bghistory(r,c,1,mod(i,50)+1) = red;
                bghistory(r,c,2,mod(i,50)+1) = green;
                bghistory(r,c,3,mod(i,50)+1) = sat;
              end
            else
              % saturation different enough that foreground
              fgprob(r,c)=1;
              bgthresh(r,c)=1;
            end
          end
        end

        figure(1)  
        image(fgprob*50)
        colormap(gray)
	figure(2)  
        image(bgthresh*100)
        colormap(gray)

  if i < 10
    imwrite(bgthresh,['RESULTS/BGTHRESH/bgthresh1000',int2str(i),'.jpg'],'jpg');
  elseif i < 100
    imwrite(bgthresh,['RESULTS/BGTHRESH/bgthresh100',int2str(i),'.jpg'],'jpg');
  else
    imwrite(bgthresh,['RESULTS/BGTHRESH/bgthresh10',int2str(i),'.jpg'],'jpg');
  end
end
