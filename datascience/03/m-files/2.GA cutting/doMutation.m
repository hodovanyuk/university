function [CH,CHF]=doMutation(CH,CHF,PLATE,ORDER,PERC)
% �������� ���� ��������� � ������������� �������
% ������� ����������� ���������� ������� �� ���������� ���������
% ���������: 
%       CH    - ���������
%       CHF   - �������� ������� ��������
%       PLATE - ������ ������ ��������
%       ORDER - ������� ��������� ���������
%       PERC  - ������� �������
% ���������:
%       CH  - ������� ��������
%       CHF - ������� ������� �������

% ��������� ������� ��������
[m,n]=size(CH);
n=floor(n/5);
% �������� �������
i=1;
while (i<=PERC)
    % �������� ���������� ����� ���������
    mCH=floor(rand(1)*m)+1;
    if (mCH>m) mCH=m; end
    % �������� ���������� ����� ���������
    nCH=floor(rand(1)*n)+1;
    if (nCH>n) nCH=n; end
    
    % �������� ���� ���������
    CHCOPY=CH(mCH,:);
    % ������ �������� ���������
    TEMP=CH(mCH,(nCH-1)*5+4);
    CH(mCH,(nCH-1)*5+4)=CH(mCH,(nCH-1)*5+5);
    CH(mCH,(nCH-1)*5+5)=TEMP;
    % ��������� ������� ��������� � ��������
    CH(mCH,:)=getPositions(CH(mCH,:),PLATE,ORDER);
    if CH(mCH,1)~=0
        % ����������� �������� ������� ���� ���������
        CHF(mCH,1)=checkFitness(CH(mCH,:),PLATE);
        i=i+1;
    else
        % ������ ������� ����� ����� ���������
        CH(mCH,:)=CHCOPY;
    end
end
    