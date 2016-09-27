
import re
import string
import sys

x = 0
y = 0

DONE        = 0
NOT_DONE    = 1
LAST_USER   = 2
SMALL_GROUP = 3
FINISH      = 4

groupNames = dict()
groupValues = dict()
users2groups = dict()               # user: group1,group2,...

# list of current users
circleIdx = []
# list of current groups
circleGroups = []
# list of groupes removed from circles
circleGroupsRemoved = []

# users
users = []
# n
n     = 0

cUsers  = []
cGroups = []

usersPopularity = dict()

def makeLists():
    global users2groups,groupNames,groupValues

    ngroups = 0
    f = open( 'data.txt','r' )
    for line in f.readlines():
        items = re.findall( '(\([^)]+\))',line )
        if( len( items ) > 0 ):
            for i in range( 0,len( items ) ):
                pars = items[ i ]
                newpars = string.replace( pars,',','_' )
                line = string.replace( line,pars,newpars )
        items = re.findall( '([^,]+)',line )
        user = int( items[ 0 ] )
        users2groups[ user ] = []
        for i in range( 1,len( items )-1 ):
            name = items[ i ]
            if( not groupNames.has_key( name ) ):
                ngroups = ngroups + 1
                value = ngroups
                groupNames[ name ] = value
                groupValues[ value ] = name
            else:
                value = groupNames[ name ]
            users2groups[ user ].append( value )
    f.close()

def intersectAndDifference(a, b):
    intersect = list( set(a) & set(b) )
    diffA = list( set(a) - set(intersect) )
    return ( intersect,diffA )

def changeLastUser():
    global users2groups
    global users,n
    global circleIdx,circleGroups,circleGroupsRemoved
    global DONE,NOT_DONE,FINISH

    idx = circleIdx.pop()
    groups = circleGroupsRemoved.pop()
    circleGroups.extend( groups )
    if( len( circleIdx ) > 0 ):
        if( idx < n-1 ):
            idx = idx + 1
            circleIdx.append( idx )
            user = users[ idx ]
            groups = users2groups[ user ]
            ( groupsIn,groupsOut ) = intersectAndDifference( circleGroups,groups )
            circleGroups = groupsIn
            circleGroupsRemoved.append( groupsOut )
            return DONE
        else:
            return NOT_DONE
    else:
        if( idx == n-1 ):
            return FINISH
        else:
            idx = idx + 1
            circleIdx.append( idx )
            user = users[ idx ]
            groups = users2groups[ user ]
            circleGroups = groups
            circleGroupsRemoved.append( [] )
            return DONE

def addNewUser():
    global users2groups
    global users,n
    global circleIdx,circleGroups,circleGroupsRemoved
    global DONE,NOT_DONE

    idx = circleIdx[ len( circleIdx )-1 ]
    if( idx < n-1 ):
        idx = idx + 1
        user = users[ idx ]
        groups = users2groups[ user ]
        circleIdx.append( idx )
        ( groupsIn,groupsOut ) = intersectAndDifference( circleGroups,groups )
        circleGroups = groupsIn
        circleGroupsRemoved.append( groupsOut )
        return DONE
    else:
        return NOT_DONE

def checkAndWrite():
    global x,users,groupNames
    global circleIdx, circleGroups
    global DONE,SMALL_GROUP
    global cUsers,cGroups

    if( len( circleGroups ) >= x ):
        if( len( circleIdx ) > 1 ):
            users4print = [ users[ circleIdx[ i ] ] for i in range( 0,len( circleIdx ) ) ]
            groups4print = [ groupValues[ circleGroups[ i ] ] for i in range( 0,len( circleGroups ) ) ]
            #print users4print,': ',groups4print
            cUsers.append( users4print )
            cGroups.append( groups4print )            
        return DONE
    else:
        return SMALL_GROUP

def removeDups():
    global cUsers,cGroups

    cUsersNew  = []
    cGroupsNew = []

    while( len( cUsers ) > 0 ):
        currU = cUsers[ 0 ]
        currG = cGroups[ 0 ]
        idx = [ 0 ];
        for i in range( 1,len( cUsers ) ):
            if( set( currG ) == set( cGroups[ i ] ) ):
                idx.append( i )
                currU = list( set( currU ) | set( cUsers[ i ] ) )
        cUsersNew.append( currU )
        cGroupsNew.append( currG )
        ii = range( 0,len( idx ) )
        ii.reverse()
        for i in ii:
            del cUsers[ i ]
            del cGroups[ i ]

    cUsers = cUsersNew
    cGroups = cGroupsNew

def printUG():
    global cUsers,cGroups

    f = open( 'circles.txt','w' )
    for i in range( 0,len( cUsers ) ):
        s1 = ','.join( map( str,cUsers[ i ] ) )
        s2 = ','.join( map( str,cGroups[ i ] ) )
        print s1, '\t', s2
        forWrite = ''.join( ( s1,'\t',s2,'\n' ) )
        f.write( forWrite )
    f.close()

def calcPopularity():
    global cUsers,cGroups
    global usersPopularity

    for i in range( 0,len( cUsers ) ):
        usrs = cUsers[ i ]
        for j in range( 0,len( usrs ) ):
            if( usersPopularity.has_key( usrs[ j ] ) ):
                usersPopularity[ usrs[ j ] ] = usersPopularity[ usrs[ j ] ] + 1
            else:
                usersPopularity[ usrs[ j ] ] = 1

def printPopularity():
    global usersPopularity
    global y

    f = open( 'popular.txt','w' )
    for i in usersPopularity.keys():
        if( usersPopularity[ i ] >= y ):
#            print str( i ),'\t',str( usersPopularity[ i ] )
            forWrite = ''.join( ( str( i ),'\t',str( usersPopularity[ i ] ),'\n' ) )
            f.write( forWrite )
    f.close()

def main():
    global users,n
    global circleIdx,circleGroups,circleGroupsRemoved
    global x,y

    if( len( sys.argv ) < 3 ):
        print 'Not enough parameters!'
        sys.exit(1)

    x = int( sys.argv[ 1 ] )
    print 'x = ',x
    y = int( sys.argv[ 2 ] )
    print 'y = ',y

    makeLists()

    # check users with groups >= x
    users = users2groups.keys()
    for user in users:
        if( len( users2groups[ user ] ) < x ):
            del users2groups[ user ]
    users = users2groups.keys()

    n = len( users )
    circleIdx.append( 0 )
    circleGroups.extend( users2groups[ users[ 0 ] ] )
    circleGroupsRemoved.append( [] )

    while( True ):
        res = checkAndWrite()
        if( res == SMALL_GROUP ):
            res = changeLastUser()
            while( res == NOT_DONE ):
                res = changeLastUser()
            if( res == FINISH ):
                break
        else:
            res = addNewUser()
            if( res == NOT_DONE ):
                while( res == NOT_DONE ):
                    res = changeLastUser()
                if( res == FINISH ):
                    break

    printUG()

    removeDups()
    print '\nAfter removeDups():'
    printUG()

    calcPopularity()
#    print ''
    printPopularity()

    print 'DONE!'

if __name__ == "__main__":

    main()
