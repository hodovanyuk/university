clc
clear all
%input
X = 4;
Y = 2;

% init global variables
global users2groups ;
global clubs ;
global DONE;
DONE = 0;
global NOT_DONE;
NOT_DONE = 1;
global LAST_USER ;
LAST_USER = 2;
global SMALL_GROUP;
SMALL_GROUP = 3;
global FINISH;
FINISH = 4;
% list of current users
circleIdx = []
% list of current groups
% circleGroups = []
% list of groupes removed from circles
% circleGroupsRemoved = []

% read file
makeLists();

% check users with groups >= x
temp = [];
iTemp = 0;
for i = 1:length(users2groups)
    if length(users2groups{i}) > X
        iTemp = iTemp + 1;
        temp{iTemp} = users2groups{i};
    end
end
users2groups = temp;
clearvars temp iTemp i;

while( true )
    
    disp('p');
    break;
%         res = checkAndWrite()
%         if( res == SMALL_GROUP ):
%             res = changeLastUser()
%             while( res == NOT_DONE ):
%                 res = changeLastUser()
%             if( res == FINISH ):
%                 break
%         else:
%             res = addNewUser()
%             if( res == NOT_DONE ):
%                 while( res == NOT_DONE ):
%                     res = changeLastUser()
%                 if( res == FINISH ):
%                     break
%                 end
%                 end
%             end
%             end
%             end
%         end
end

%     n = len( users )
%     circleIdx.append( 0 )
%     circleGroups.extend( users2groups[ users[ 0 ] ] )
%     circleGroupsRemoved.append( [] )
