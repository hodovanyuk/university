function [ num,count ] = countGenes( CH )
% ������� ������ ����� � ��������� ���� "������������ � ������������"
% ����:
%       CH - ���������
% �����:
%       num   - ������ ������ �����
%       count - ���������� ���������� ���������������� ����

% ���������� �������� ����
m = max( CH );
% �������� ����� ��� �������
num = zeros( 1,m );
count = num;

% �������� �� ������� ���� � ���������� ����������
for gene = 1:m
    % ������� ������� ���� � ���������
    idx = find( CH == gene );
    % ��������� ����������
    if( ~isempty( idx ) )
        num( gene ) = gene;
        count( gene ) = length( idx );
    end
end

% ������� �������� � ������� ����������� �����
idx = find( count > 0 );
num = num( idx );
count = count( idx );
