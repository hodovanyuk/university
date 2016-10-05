function makeLists

    users2groups = 0;
    iusers2groups = 0;
    global users2groups ;
    users2groups = [];
    global clubs ;
    clubs = [];
    file = fopen( 'data.txt' );
    while( ~feof( file ) )
        str = fgets(file);
        substr = regexp( str, ',', 'split' );
        iusers2groups = iusers2groups + 1;
        users2groups{ iusers2groups } = substr(1:length(substr)-1);
%       disp(users2groups{ iusers2groups })
        groupName =  substr(2:length(substr)-1);
        for i = 1: length(groupName)
            if length(clubs) == 0
                clubs = [clubs groupName(i)] ;
            else
                for j =1:length(clubs)
                    if ~(compare(clubs,groupName(i)))
                        clubs = [clubs groupName(i)] ;
                    end
                end
            end
        end
    end
    fclose('all');
end