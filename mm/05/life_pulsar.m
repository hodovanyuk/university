function [result] = life_pulsar(myseed, pulsar_x, pulsar_y)
% [result] = life_pulsar(myseed, pulsar_x, pulsar_y)
% add a "pulsar" oscilaltor to Conway's game of life
% myseed -- the universe array (2D)
% pulsar_x -- x coordinate of pulsar
% pulsar_y -- y coordinate of pulsar
%
% Author: John F. McGowan, Ph.D.
% Web: http://www.jmcgowan.com/
% E-Mail: jmcgowan11@earthlink.net
%

pulsar = [ 0 0 1 1 1 0 0 0 1 1 1 0 0;
 0 0 0 0 0 0 0 0 0 0 0 0 0;
 1 0 0 0 0 1 0 1 0 0 0 0 1;
 1 0 0 0 0 1 0 1 0 0 0 0 1;
 1 0 0 0 0 1 0 1 0 0 0 0 1;
 0 0 1 1 1 0 0 0 1 1 1 0 0;
 0 0 0 0 0 0 0 0 0 0 0 0 0;
 0 0 1 1 1 0 0 0 1 1 1 0 0;
 1 0 0 0 0 1 0 1 0 0 0 0 1;
 1 0 0 0 0 1 0 1 0 0 0 0 1;
 1 0 0 0 0 1 0 1 0 0 0 0 1;
 0 0 0 0 0 0 0 0 0 0 0 0 0;
 0 0 1 1 1 0 0 0 1 1 1 0 0;
 ];

result = myseed;

result(pulsar_x:pulsar_x+rows(pulsar)-1, pulsar_y:pulsar_y+columns(pulsar)-1) = pulsar;

end % function life_pulsar