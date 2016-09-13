clc
f = fopen( 'data.txt' );
i = 0;
A = [];
Clubs = [];
while( ~feof( f ) )
    str = fgets( f );
    subs = regexp( str, ',', 'split' );
%     A = [A subs];
    i = i + 1;
    A{ i } = subs;
    temp =  subs(2:length(subs)-1);
    for i = 1: length(temp)
        if length(Clubs) == 0
            Clubs = [Clubs temp(i)] ;
        else
            for j =1:length(Clubs)
                if ~(compare(Clubs,temp(i)))
                    Clubs = [Clubs temp(i)] ;
                end
            end
        end
    end
end

M = zeros([length(A),length(Clubs)]);

for i=1:length(A)
    for j=1:length(Clubs)
        if A{i,j}
