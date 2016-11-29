%Student Dave's tutorial on:  Image processing for object
%tracking  (aka giving eyes to your robot :) 
%Copyright Student Dave's Tutorials 2012
%if you would like to use this code, please feel free, just remember to
%reference and tell your friends! :)
%requires matlabs image processing toolbox


%What the heck does this code do!?
%the code finds the hexbug buy using a series of basic, but effective
%images processing techniques (formal talk for a second -->) :
% 1) Averaged background subtraction
% 2) Noise reduction via image smoothing using 2-d gaussian filter.
% 3) Threshold and point detection in binary image.

clear all;
close all;
set(0,'DefaultFigureWindowStyle','docked') %dock the figures..just a personal preference you don't need this.
% dirName = '/home/matvey/university/course_project/advanced_vision/DATA/';
% f_list = dir([dirName,'/*.jpg']);
base_dir = '/home/matvey/university/course_project/advanced_vision/dataset/abandonedBox/input/';
% base_dir = 'hexbug_frames';
cd(base_dir);

%% get listing of frames so that you can cycle through them easily.
f_list =  dir('*jpg');
% f_list =  dir('*png');


%% make average of background images (i.e. images with no objects of interest)
% Here we just read in a set of images (N) and then take the average of
% them so that we are confident we got a good model of what the background
% looks like (i.e. a template free from any potential weird image artifacts

N = 5; % num of frames to use to make averaged background...that is, images with no bug!
temp = imread(f_list(1).name);
[w,h,C] = size(temp);
img = zeros(w,h,N); %define image stack for averaging (if you don't know what this is, just load the image and  check it with size())
for i = 1:N    
    img_tmp = imread(f_list(i).name); %read in the given image
    img(:,:,i) = img_tmp(:,:,1); % we don't really care about the rgb image values, so we just take the first dimension of the image
end
bck_img = (mean(img,3)); %take the average across the image stack..and bingo! there's your background template!
subplot(121);imagesc(bck_img)
subplot(122);imagesc(img(:,:,1))
colormap(gray)
clear img; % free up memory.

%initialize gaussian filter

%using fspecial, we will make a gaussian template to convolve (pass over)
%over the image to smooth it.
hsize = 20;
sigma = 10;
gaus_filt = fspecial('gaussian',hsize , sigma);
subplot(121); imagesc(gaus_filt)
subplot(122); mesh(gaus_filt)
colormap(jet)

%this one is just for making the coordinate locations more visible.
SE = strel('diamond', 7); %another tool make for making fun matrice :) this one makes a matrice object for passing into imdilate())


%% iteratively (frame by frame) find bug!
CM_idx = zeros(length(f_list),2); % initize the variable that will store the bug locations (x,y)

for i = 1:2:length(f_list) 
   
    img_tmp = double(imread(f_list(i).name)); %load in the image and convert to double too allow for computations on the image
    img = img_tmp(:,:,1); %reduce to just the first dimension, we don't care about color (rgb) values here.
    subplot(221);imagesc(img);
    title('Raw');
    
    %{
    %VERY HARD TRACKING
    %for frames 230:280, make the bug very hard to track    
    if (i > 230) && (i < 280) && (mod(i,3) == 0 )      
        J = imnoise(img,'speckle');
        img = img+J*200;
    end
    %}
  
    
    %subtract background from the image
    sub_img = (img - bck_img);
    subplot(222);imagesc(sub_img);
    title('background subtracted');
    %gaussian blurr the image
    gaus_img = filter2(gaus_filt,sub_img,'same');     
    subplot(223);imagesc(gaus_img);
    title('gaussian smoothed');
    %threshold the image...here i just made a quick histogram to see what
    %value the bug was below
    subplot(224);hist(gaus_img(:));
    thres_img = (gaus_img < -15);
    subplot(224);imagesc(thres_img);
    title('thresholded');
   
    
    %% TRACKING! (i.e. get the coordinates of the bug )
    %quick solution for finding center of mass for a BINARY image
    %basically, just get indices of all locations above threshold (1) and
    %take the average, for both the x and y directions. This will give you
    %the average location in each dimension, and hence the center of the
    %bug..unless of course, something else (like my hand) passes threshold
    %:P  
    %if doesn't find anything, it randomly picks a pixel
    [x,y] = find (thres_img);    
    if ~isempty(x)
        CM_idx(i,:) = ceil([mean(x) mean(y)]+1); % i used ceiling to avoid zero indices, but it makes the system SLIGHTLY biased, meh, no biggie, not the point here :).
    else
%         CM_idx(i,:) = ceil([rand*200 rand*200]);
    end
    
    
   
    %{
    %NOT SO HARD TRACKING
     %for frames 230:280, make the bugtracking just a lil noisy by randomly sampling
    %around the bugtracker
    if (i > 230) && (i < 280) && (mod(i,2) == 0 )  
       CM_idx(i,:) = [round(CM_idx(i,1) + randn*10) round(CM_idx(i,2) + randn*10)];
    end
    %}
    
     %{
    %NO  TRACKING
     %for frames 230:280, make the bugtracking just a lil noisy by randomly sampling
    %around the bugtracker
    if (i > 230) && (i < 280)   
       CM_idx(i,:) = [NaN NaN];
    end
    %}
    
    
    %% now, we visual everything :)
    
    %create a dilated dot at this point for visualize
    %make binary image with single coordinate of bug = 1 and rest zeros.
    %then dilate that point to make a more visible circle.
    bug_img = zeros(size(thres_img)); 
    bug_img(CM_idx(i,1),CM_idx(i,2)) = 1;

    %{
    % if you are running the "no tracking segment above, you'll need to
    % skip over that  segment, and thus use this code
    if ~((i > 230) && (i < 280))
        bug_img(CM_idx(i,1),CM_idx(i,2)) = 1;
    end
    %}
    
    bug_img = imdilate(bug_img, SE);
    subplot(224);imagesc(thres_img + bug_img);
    title('thresholded and extracted (red diamond)');
    axesHandles = get(gcf,'children');
    set(axesHandles, 'XTickLabel', [], 'XTick', []);
    set(axesHandles, 'YTickLabel', [], 'YTick', [])  ;    

    pause(.1)
end

%save out the hexbug coordinates
    
%save('CM_idx_no.mat', 'CM_idx')


     
    %{
    %nice and elegant solution for center of mass of gray scale image 
(i.e. doesn't have to be binary like in our case)----------------------------------
    % http://www.mathworks.com/matlabcentral/newsreader/author/109726
    %These next 4 lines produce a matrix C whose rows are
    % the pixel coordinates of the image A
    C=cellfun(@(n) 1:n, num2cell(size(thres_img)),'uniformoutput',0);
    [C{:}]=ndgrid(C{:});
    C=cellfun(@(x) x(:), C,'uniformoutput',0);
    C=[C{:}]; 
    %This line computes a weighted average of all the pixel coordinates. 
    %The weight is proportional to the pixel value.
    CenterOfMass=thres_img(:).'*C/sum(thres_img(:),'double')
    %---------------------------------------------------------------------
    %}