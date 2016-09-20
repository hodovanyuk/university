clc
X = 2;
Y = 2;
f = fopen( 'data.txt.old.1_1' );
k = 0;
A = [];
Clubs = [];
while( ~feof( f ) )
    str = fgets( f );
    subs = regexp( str, ',', 'split' );
    k = k + 1;
    A{ k } = subs(1:length(subs)-1);
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
UnianMatrix = zeros([1,length(Clubs)]);
for i=1:length(A)
    for j=1:length(A{i})
        if indexOf(Clubs,A{1,i}{1,j}) > 0
            M(i, indexOf(Clubs,A{1,i}{1,j})) = 1;
            UnianMatrix(indexOf(Clubs,A{1,i}{1,j})) = UnianMatrix(indexOf(Clubs,A{1,i}{1,j})) + 1;
    
        end
    end
%     for j=1:length(Clubs)
%         disp(A{i,j})
% %         if A{i,j}
% %             disp(' i ->',i);
% %         end
%     end
end

% for i=1:length(M)
%     for j=1:
% end
