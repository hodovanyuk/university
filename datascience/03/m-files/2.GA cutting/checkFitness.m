function LENGTH=checkFitness(CH,PLATE)
% ���������� ������� ��������� CH
% ���������:
%       CH  - ���������
%       PLATE - ������ ������ ��������
% ���������:
%       LENGTH - �������� ������� �������

% ��������� ������� ���������
[m,PLATES]=size(CH);
PLATES=floor(PLATES/5);

% ��������� �� ������ �� ������ - ��� ���������
% ������ ��� - PLATES*4
LINES=zeros(PLATES*4,4);
% �������� �� �� ������
for i=1:PLATES
    LINES((i-1)*4+1,:)=[CH(1,(i-1)*5+2) CH(1,(i-1)*5+3) CH(1,(i-1)*5+2)+CH(1,(i-1)*5+4) CH(1,(i-1)*5+3)];
    LINES((i-1)*4+2,:)=[CH(1,(i-1)*5+2) CH(1,(i-1)*5+3) CH(1,(i-1)*5+2) CH(1,(i-1)*5+3)-CH(1,(i-1)*5+5)];
    LINES((i-1)*4+3,:)=[CH(1,(i-1)*5+2)+CH(1,(i-1)*5+4) CH(1,(i-1)*5+3) CH(1,(i-1)*5+2)+CH(1,(i-1)*5+4) CH(1,(i-1)*5+3)-CH(1,(i-1)*5+5)];
    LINES((i-1)*4+4,:)=[CH(1,(i-1)*5+2) CH(1,(i-1)*5+3)-CH(1,(i-1)*5+5) CH(1,(i-1)*5+2)+CH(1,(i-1)*5+4) CH(1,(i-1)*5+3)-CH(1,(i-1)*5+5)];
end

% ��������� �� ��� ���� � �������� �, �� ����������� �� ������� ��������
i=1;
COUNT=PLATES*4;
while (i<=COUNT)
    if ((LINES(i,1)==0) && (LINES(i,3)==0)) || ((LINES(i,1)==PLATE(1,1)) && (LINES(i,3)==PLATE(1,1))) || ...
        ((LINES(i,2)==0) && (LINES(i,4)==0)) || ((LINES(i,2)==PLATE(1,2)) && (LINES(i,4)==PLATE(1,2)))
        LINES=[LINES(1:i-1,:); LINES(i+1:COUNT,:)];
        COUNT=COUNT-1;
    else
        i=i+1;
    end
end

% ���������� � ��, �� ����������, ������� �� �� ������
i=1;
while (i<COUNT)
    j=i+1;
    while (j<=COUNT)
        % ���� �� �� ����� ������� ������� � ������������ ���� �� ����
        if (LINES(i,1)==LINES(i,3)) && (LINES(j,1)==LINES(j,3)) && (LINES(i,1)==LINES(j,1)) && ...
           (((LINES(j,2)<=LINES(i,2)) && (LINES(j,2)>=LINES(i,4))) || ...
           ((LINES(i,2)<=LINES(j,2)) && (LINES(i,2)>=LINES(j,4))))
            % ������ ����� � ����� ���������� �� ����� � �����
            MAX=max(LINES(i,2),LINES(j,2));
            MIN=min(LINES(i,4),LINES(j,4));
            % �������� �� ���������� ����� ��
            LINES(i,2)=MAX; LINES(i,4)=MIN;
            % �������� ����� ���
            LINES=[LINES(1:j-1,:); LINES(j+1:COUNT,:)];
            % ������� ��� �� 1 �����
            COUNT=COUNT-1;
        % ������ ���� �� �� ����� ������� �������� � ������������ ���� �� ����
        elseif (LINES(i,2)==LINES(i,4)) && (LINES(j,2)==LINES(j,4)) && (LINES(i,2)==LINES(j,4)) && ...
               (((LINES(j,1)<=LINES(i,3)) && (LINES(j,1)>=LINES(i,1))) || ...
               ((LINES(i,1)<=LINES(j,3)) && (LINES(i,1)>=LINES(j,1))))
            % ������ ����� � ����� ���������� �� ����� � �����
            MAX=max(LINES(i,3),LINES(j,3));
            MIN=min(LINES(i,1),LINES(j,1));
            % �������� �� ���������� ����� ��
            LINES(i,3)=MAX; LINES(i,1)=MIN;
            % �������� ����� ���
            LINES=[LINES(1:j-1,:); LINES(j+1:COUNT,:)];
            % ������� ��� �� 1 �����
            COUNT=COUNT-1;
        else
            % ���������� �� �������� ��
            j=j+1;
        end
    end
    i=i+1;
end
            
% ���������� ������� ��� ���, �� ����������
LENGTH=0;
for i=1:COUNT
    % ���� ������� ���������� - ���������� ������� �� OY
    if LINES(i,1)==LINES(i,3)
        LENGTH=LENGTH+LINES(i,2)-LINES(i,4);
    else
        LENGTH=LENGTH+LINES(i,3)-LINES(i,1);
    end
end