function [CH,CHF]=getChromosomes(PLATE,PLATES,ARG,ORDER)
% ������ ARG ��������, �� � ��������� ��������� ������� � ��������
% ��������� ORDER �� �������� �� ������� �������
% ���������:
% PLATE  - ��������� ������ �������� (������� �� ������)
% PLATES - ���� ���������, ������� �� �������� �� �������; ������
%          �������� - ��������� ������ ��������
% ARG    - ������� �������� ��� ������
% ORDER  - ������� ���������:
%                            0 - ����-�������, �����-����
%                            1 - � ����� ����������� ��������
%                            2 - � �������� ����������� ��������
% ���������:
% CH  - ���� �������� � ��������� ����� CH � ������ 
%       ����� �������� - X �� Y ��������� ����� ���� -
%       ������ - ������
% CHF - ���� ������� ������� � ��������� ����� CHF

if (nargin==1) || ((ORDER~=1) && (ORDER~=2))
    ORDER=0;
end

% �������� ������� �������
[m,n]=size(PLATES);
% ��������� ����� ��� ���������� ��������
CH=zeros(ARG,m*5);
% ��������� ����� ��� ���������� ������� ������� ��������
CHF=zeros(ARG,1);

% ��������� �� ����� �������� �� ������ ��
i=1;
while (i<=ARG)
    % ��������� ����� ������ ������� �� ������������ �� �������
    NUMBERS=1:m;
    COUNT=m;
    % ���������� ����� �������� ����� ��������
    nPlate=floor(rand(1)*COUNT)+1;
    % ���������� ����� �������� �� ���������
    nPosition=floor(rand(1)+0.5);
    % ������������ ����� ��������
    CH(i,1)=NUMBERS(nPlate);    % ����� ��������
    if nPosition==0
        CH(i,4)=PLATES(CH(i,1),1); CH(i,5)=PLATES(CH(i,1),2);   % ������ - ������
    else
        CH(i,4)=PLATES(CH(i,1),2); CH(i,5)=PLATES(CH(i,1),1);   % ������ - ������
    end
    % �������� ����� ������� ��������
    if nPlate==1
        NUMBERS=NUMBERS(2:COUNT);
    elseif nPlate==COUNT
        NUMBERS=NUMBERS(1:COUNT-1);
    else
        NUMBERS=[NUMBERS(1:nPlate-1) NUMBERS(nPlate+1:COUNT)];
    end
    COUNT=COUNT-1; index=2;
    % ��������� �� �� �� ������������ ���������
    while (COUNT>=1)
        % ���������� ����� �������� �������� ��������
        nPlate=floor(rand(1)*COUNT)+1;
        % ���������� ����� �������� �� ���������
        nPosition=floor(rand(1)+0.5);
        % ������������ ��������
        CH(i,(index-1)*5+1)=NUMBERS(nPlate);            % ����� ��������
        if nPosition==0
            CH(i,(index-1)*5+4)=PLATES(NUMBERS(nPlate),1);  % ������ - ������
            CH(i,(index-1)*5+5)=PLATES(NUMBERS(nPlate),2);
        else
            CH(i,(index-1)*5+4)=PLATES(NUMBERS(nPlate),2);  % ������ - ������
            CH(i,(index-1)*5+5)=PLATES(NUMBERS(nPlate),1);
        end            
        % �������� ����� ������� ��������
        if nPlate==1
            NUMBERS=NUMBERS(2:COUNT);
        elseif nPlate==COUNT
            NUMBERS=NUMBERS(1:COUNT-1);
        else
            NUMBERS=[NUMBERS(1:nPlate-1) NUMBERS(nPlate+1:COUNT)];
        end
        COUNT=COUNT-1;
        index=index+1;
    end
    % ��������� ������� ���������
    CH(i,:)=getPositions(CH(i,:),PLATE,ORDER);
    % ���� ��������� ����������� �� ������� - ��������� ��������
    % ���������
    if (CH(i,1)~=0)
        % �������� �������� ������� �������
        CHF(i,1)=checkFitness(CH(i,:),PLATE);
        i=i+1;
    end
end        