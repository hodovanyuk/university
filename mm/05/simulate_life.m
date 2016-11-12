function [] = simulate_life(myseed, niter, name, ext)
% [] = simulate_life(myseed, niter [,name, ext])
% simulate Conway's Game of Life
% myseed is 2d array with values 0 or 1
% 0 is a dead cell
% 1 is a live cell
% niter is number of iterations to simulate
% name (optional) name of simulation
% ext (optionsal) extension of image file (default gif)
%
% Author: John F. McGowan, Ph.D.
% E-Mail: jmcgowan11@earthlink.net
%
% to make an animated gif of the game of life
%
% Install ImageMagick on your computer
% command prompt>convert -delay 10 -loop 0 life*.gif game.gif
% to make game.gif animated gif
%
% any good web browser (such as FireFox) can display animated GIF video
%

if (nargin < 2)
	printf("ERROR: too few arguments!\n");
	printf("Usage: simulate_life(myseed, number_of_iterations [,simulation_name])\n");
	fflush(stdout);
	return;
end

if nargin < 3
	name = 'life';
end

if nargin < 4
	ext = 'gif';
end

nx = rows(myseed);
ny = columns(myseed);

previous = myseed;
update = zeros(size(previous));

display_array = life_grid(myseed);

imshow(!display_array);
title('SEED');
pause(1);

seed_name = sprintf("%s000.%s", name, ext);

print(seed_name);

total_live = sum(sum(previous));
printf("%d live cells in seed\n", total_live);
fflush(stdout);

for iter = 1:niter

% simulate one iteration/update of game
%
for ix = 1:nx
	for iy = 1:ny
			lowx = max(ix-1,1);
			hix = min(ix+1, nx);
			lowy = max(iy-1,1);
			hiy = min(iy+1, ny);
			nlive = sum(sum(previous(lowx:hix,lowy:hiy))); % add up number of live cells in neighborhood

			% handle four (4) corner cases
			if (ix == 1 && iy == 1)	|| (ix == 1 && iy == ny) || (ix == nx && iy == ny) || (ix == nx && iy == 1)
					n11 = previous(cycle(ix-1,nx), cycle(iy-1,ny));
					n12 = previous(ix      , cycle(iy-1, ny));
					n13 = previous(cycle(ix+1,nx), cycle(iy-1,ny));
					n21 = previous(cycle(ix-1,nx), iy);
					n22 = previous(ix, iy); % center cell (current cell)
					n23 = previous(cycle(ix+1,nx), iy);
					n31 = previous(cycle(ix-1,nx), cycle(iy+1, ny));
					n32 = previous(ix      , cycle(iy+1, ny));
					n33 = previous(cycle(ix+1, nx), cycle(iy+1, ny));
					nlive = n11 + n12 + n13 + n21 + n22 + n23 + n31 + n32 + n33;
			else
			% non corner cases

				% handle cells at edge of universe (treat as closed universe)
				if ix == 1
					nlive = nlive + sum(previous(nx,lowy:hiy));
				end

				if ix == nx
					nlive = nlive + sum(previous(1,lowy:hiy));
				end

				if iy == 1
					nlive = nlive + sum(previous(lowx:hix, ny));
				end

				if iy == ny
					nlive = nlive + sum(previous(lowx:hix, 1));
				end

			end % else non corner cases

			if previous(ix,iy) == 1
				nlive = nlive - 1; % don't count center cell
				printf("live cell %d %d has %d live neighbors\n", ix, iy, nlive);
				fflush(stdout);
			end

			if nlive < 2  % cell with fewer than 2 live neighbors dies
				update(ix, iy) = 0; % cell dies
			elseif (nlive ==2 || nlive ==3) % cell lives on if it has 2 or 3 neighbors
				if(previous(ix,iy) == 0 && nlive == 3)
					update(ix, iy) = 1; % dead cell comes alive if it has exactly 3 live neighbors (reproduction)
				else
					update(ix, iy) = previous(ix,iy);
				end
			elseif nlive > 3 % cell dies due to overpopulation
				update(ix, iy) = 0;
			else
				update(ix, iy) = previous(ix,iy);
				printf("error if got here\n");
				fflush(stdout);
			end

	end % loop over columns
end % loop over rows

total_live = sum(sum(update));
printf("%d live cells at iteration %d\n", total_live, iter);
fflush(stdout);

previous = update;
filename = sprintf("%s%03d.%s", name, iter, ext); % write image sequence to disk
%imshow(!previous);
display_array = life_grid(previous);
imshow(!display_array);

title(filename);
pause(1);
print(filename);

end % loop over iterations

end % function simulate_life