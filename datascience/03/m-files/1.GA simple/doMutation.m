function doMutation(PERC)
% �������� ���� ��������� � ������������� �������
% ������� ����������� ���������� ������� �� ������ ���� ����
% ʳ������ ������� - PERC ������� �� ������� �������� (0<PERC<1)
% ���������: ������� �������� CH (��������� �����)
%            PERC - ������� ������� ������� �� ������� ��������
% ���������: ����� ������� �������� �� ������� ��������

global CH;
global CHF;

% ��������� ������� ��������
[m,n]=size(CH);
% ��������� ������� �������
nMutations=floor(m*PERC);
% ��������� �������� ����, ���� ������� ��������� �� �������� ������� �������
CHt=CH;
CHFt=CHF;
% �������� �������
for i=1:nMutations
    % �������� ���������� ����� ���������
    nCH=floor(rand(1)*m)+1;
    if (nCH>m) nCH=m; end
    % �������� �� �������, �� ����� �������
    firstPos=floor(rand(1)*n)+1;
    if (firstPos>n) firstPos=n; end
    secondPos=floor(rand(1)*n)+1;
    if (secondPos>n) secondPos=n; end
    % ������ ���� � ������� ��������, �� ����������� � �������� ��������
    TEMP=CH(nCH,firstPos);
    CH(nCH,firstPos)=CH(nCH,secondPos);
    CH(nCH,secondPos)=TEMP;
    % ����������� �������� ������� ���� ���������
    CHF(nCH,1)=checkFitness(CH(nCH,:));
end
    