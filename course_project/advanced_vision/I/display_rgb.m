%% display a loaded image in regular RGB form and with each of the
%% separate colour channels

% Author / Copyright: T. Breckon, Jan. 2006.
% License: http://www.gnu.org/licenses/gpl.txt

function display_rgb(Image)

%% set display prefs.

iptsetpref('ImshowBorder', 'tight');
iptsetpref('ImshowAxesVisible', 'off');
iptsetpref('ImshowInitialMagnification', 100);
figure(1);
set(1, 'MenuBar', 'none');
set(1, 'ToolBar', 'none');
set(1, 'Name', 'RGB Colour Channel Separation');

%% get image size and set up channel a mask of appropriate size

[sizeX, sizeY, colourDepth] = size(Image);

if (colourDepth ~= 3)
    display 'Error: image not an RGB image'
    return
end

mask = zeros(sizeX, sizeY);

%% display RGB image

figure(1);
subplot(2, 2, 1);
imshow(Image);
xlabel('RGB Image');
    
%% display Red Channel (channel 1, mask out 2 and 3)
   
IRed = Image;
IRed(:,:,2) = mask;
IRed(:,:,3) = mask;
   
subplot(2, 2, 2);
imshow(IRed);
xlabel('Red Colour Channel');
   
%% display Green Channel (channel 2, mask out 1 and 3)
   
IGreen = Image;
IGreen(:,:,1) = mask;
IGreen(:,:,3) = mask;
   
subplot(2, 2, 3);
imshow(IGreen);
xlabel('Green Colour Channel');

%% display Blue Channel (channel 3, mask out 1 and 2)
   
IBlue = Image;
IBlue(:,:,1) = mask;
IBlue(:,:,2) = mask;
   
subplot(2, 2, 4);  
imshow(IBlue);
xlabel('Blue Colour Channel');
