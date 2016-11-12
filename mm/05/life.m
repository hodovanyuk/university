% John Conway's Game of Life in Octave
%
% Author: John F. McGowan, Ph.D.
% Web: http://www.jmcgowan.com/
% E-Mail: jmcgowan11@earthlink.net
%
clc;clear all;
nx = 20;
ny = 20;

niter = 10; % number of iterations of game to simulate

% 0 is a dead cell, 1 is a live cell
%
% blinker
% myseed = repmat(0, nx, ny); % create seed for game of life
% myseed(nx/2, ny/2) = 1;
% myseed((nx/2)+1, ny/2) = 1;
% myseed((nx/2)+2, ny/2) = 1;

% simulate_life(myseed, niter);	

% glider
myseed = repmat(0, nx, ny);

glider_x = nx/2 + 7;
glider_y = ny/2 + 7;

%myseed = life_glider(myseed, glider_x, glider_y);

% add a toad oscillator
%myseed = life_toad(myseed, nx/2, ny/2);

% blinker at corner
% myseed(1,ny) = 1;
% myseed(nx,ny) = 1;
% myseed(nx-1, ny) = 1;

% add a pulsar oscillator (period 3 iterations)
myseed = life_pulsar(myseed, 5,5);
simulate_life(myseed, 10, "pulsar");

% END OF FILE (Conway's Game of Life in Octave)