function [GAResult,GABestResult]=geneticAlgorithm(ITERATIONS,CHROMOSOMES,PERCMUTATIONS,PLATES,PLATE)
% ��������� ����������� ���������
% ���������� ������� ��������
% �� �������� �������� ��������� �� ������� ���������� ��������� ������ �
% ���������� � ������ ����� (������ ������� �������) ����� ��
% ����������, �� ���� ��������� ������; ���� ����� �������� ����� -
% ���������� ����� �� ���
% ���������: ITERATIONS    - ������� �������� ��
%            CHROMOSOMES   - ������� ��������
%            PERCMUTATIONS - ������� ������� �� ������� ��������
%            PLATES        - ������� ��������� � ������ ����� ��� (�������;������)
%            PLATE         - ������ ������ ��������
% ������ ���������� ����������� � ������ CH �� CHF
% ���������: GAResult      - �������� ������� �� �������� � ���������
%                            �������� ��� ����� ��������
%            GABestResult  - �������� ���������� ������� � ���������, �� ���� ����

% ��������� ������� ������� ��������
[CH,CHF]=getChromosomes(PLATE,PLATES,CHROMOSOMES,0);
% ��������� ������� �� ������� ��������
[n,m]=size(PLATES);
m=CHROMOSOMES;

% ��������� ����� ��� ��������� ����������
GAResult=zeros(ITERATIONS,n*5+1);
% ��������� ��������� ������
I=find(CHF==min(CHF));
% �������� �������� ������� �� �������� ��������� � GAResult
GAResult(1,:)=[CHF(I(1,1),1) CH(I(1,1),:)];
GABestResult=GAResult(1,:);
% �������� ITERATIONS-1 �������� ��
for i=2:ITERATIONS
    % �������� ��������
    [CH,CHF]=doCrossover(CH,CHF,PLATE);
    % �������� �������
    [CH,CHF]=doMutation(CH,CHF,PLATE,0,PERCMUTATIONS);
    % �������� ��������� � ��������� �������� �� �������� � ����� ����������
    I=find(CHF==min(CHF));
    GAResult(i,:)=[CHF(I(1,1),1) CH(I(1,1),:)];
    % ���� �������� ����� �������� ������� - �������� ����
    if GAResult(i,1)<GABestResult(1,1)
        GABestResult=GAResult(i,:);
    end
end
    