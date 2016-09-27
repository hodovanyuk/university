function checkAndWrite()
    global x,users,groupNames
    global circleIdx, circleGroups
    global DONE,SMALL_GROUP
    global cUsers,cGroups
% 
%     if( len( circleGroups ) >= x ):
%         if( len( circleIdx ) > 1 ):
%             users4print = [ users[ circleIdx[ i ] ] for i in range( 0,len( circleIdx ) ) ]
%             groups4print = [ groupValues[ circleGroups[ i ] ] for i in range( 0,len( circleGroups ) ) ]
%             #print users4print,': ',groups4print
%             cUsers.append( users4print )
%             cGroups.append( groups4print )            
%         return DONE
%     else:
%         return SMALL_GROUP