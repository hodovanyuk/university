% Load 2D geometric models as global variables

% Code: Robert B. Fisher
% Additional comments: Toby P Breckon

global Nummodels Models ModelLength

Nummodels = 3;
Models = zeros(Nummodels,10,4);
ModelLength = [8,6,6];

%% Models indexed as Models(ModelNumber, PointNumber ...)

% coordinates go row1,col1,row2,col2
Models(1,1,:) = [0,0,0,12];
Models(1,2,:) = [0,12,4,12];
Models(1,3,:) = [4,12,4,8];
Models(1,4,:) = [4,8,12,8];
Models(1,5,:) = [12,8,12,4];
Models(1,6,:) = [12,4,4,4];
Models(1,7,:) = [4,4,4,0];
Models(1,8,:) = [4,0,0,0];

Models(2,1,:) = [0,0,0,12];
Models(2,2,:) = [0,12,4,12];
Models(2,3,:) = [4,12,4,2.5];
Models(2,4,:) = [4,2.5,8,2.5];
Models(2,5,:) = [8,2.5,8,0];
Models(2,6,:) = [8,0,0,0];

Models(3,1,:) = [0,0,0,12];
Models(3,2,:) = [0,12,8,12];
Models(3,3,:) = [8,12,8,8];
Models(3,4,:) = [8,8,4,8];
Models(3,5,:) = [4,8,4,0];
Models(3,6,:) = [4,0,0,0];


