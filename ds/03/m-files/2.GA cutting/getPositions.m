function CH=getPositions(CH,PLATE,ORDER)
% ���������� ��������� ��� �������� �� ������ �������;
% ������� ���������� 2 �� 3 � ���������� ������
% ���������:
% CH    - ���������, � ���� �� ����������� ������� ���������
% PLATE - ������� �� ������ ������ ��������
% ORDER - ������� ������� ������ �����
% ���������:
% CH  - ������� ���� ��������

% ��������� ������� �������� �� ������� ���������
[CHROMOSOMES,PLATES]=size(CH);
PLATES=floor(PLATES/5);
% ��������� ����� ����� (����� ��������� * 4)
POINTS=zeros(PLATES*4,2);
CPOINTS=0;
% ��������� �� ����� �������� �� ���������� ��
for i=1:CHROMOSOMES
    % ������������ ����� ���������
    CH(i,2)=0; CH(i,3)=PLATE(1,2);
    % �������� ��� ����� ��������� � �����
    POINTS(1,:)=[CH(i,2)+CH(i,4) CH(i,3)];      % x+l W
    POINTS(2,:)=[CH(i,2) CH(i,3)-CH(i,5)];      % x   W-w
    POINTS(3,:)=[POINTS(1,1) POINTS(2,2)];      % x+l W-w
    CPOINTS=3;
    % ������� ������Ͳ ��������
    % �������� �� ��� ��������� ���������
    j=2;
    while (j<=PLATES)
        % ���������� ������ ����� �� ������� �� ���� �������� �
        % ���������� �� ����������
        iPOINT=1; POINT=POINTS(iPOINT,:);
        while (iPOINT<=CPOINTS) && (checkPosition(CH(i,:),j,POINT,PLATE)==0)
            iPOINT=iPOINT+1;
            if (iPOINT<=CPOINTS)
                POINT=POINTS(iPOINT,:);
            end
        end
        % ���� ��������� ��� �� ����� - ��������� �� ��������
        if (iPOINT>CPOINTS)
            CH(i,1)=0;
            j=PLATES+1;
        else
            % ��������� �������� - �������� �����
            CH(i,(j-1)*5+2)=POINT(1,1); CH(i,(j-1)*5+3)=POINT(1,2);
            % �������� �����, � ��� ��������� ��������
            if (iPOINT==1)
                POINTS=POINTS(2:CPOINTS,:);
            elseif (iPOINT==CPOINTS)
                POINTS=POINTS(1:CPOINTS-1,:);
            else
                POINTS=[POINTS(1:iPOINT-1,:); POINTS(iPOINT+1:CPOINTS,:)];
            end
            % �������� ������� �����
            CPOINTS=CPOINTS-1;
            % �������� ��� �����, �� ����������
            POINTS(CPOINTS+1,:)=[CH(i,(j-1)*5+2)+CH(i,(j-1)*5+4) CH(i,(j-1)*5+3)];      % x+l W
            POINTS(CPOINTS+2,:)=[CH(i,(j-1)*5+2) CH(i,(j-1)*5+3)-CH(i,(j-1)*5+5)];      % x   W-w
            POINTS(CPOINTS+3,:)=[POINTS(CPOINTS+1,1) POINTS(CPOINTS+2,2)];              % x+l W-w
            CPOINTS=CPOINTS+3;
            % ������� ����� �� X, ���� �� Y
            POINTS(:,2)=PLATE(1,2)-POINTS(:,2);
            POINTS=sortrows(POINTS,[2 1]);
            POINTS(:,2)=PLATE(1,2)-POINTS(:,2);
            j=j+1;
        end
    end
end