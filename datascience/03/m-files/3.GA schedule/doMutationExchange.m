function CH = doMutationExchange( CH )
% ������� ��������� ���� "������������ � ������������"
% ����:
%       CH - �������� ���������
% �����:
%       CH - ������������ ���������

% ���������� ���������� �����
n = length( CH );
% ���������� ����, ������� ���� ��������
m1 = round( rand * ( n - 1 ) + 1 );
m2 = round( rand * ( n - 1 ) + 1 );
while( m2 == m1 )
    m2 = round( rand * ( n - 1 ) + 1 );
end

% ���������� ����
gene = CH( m1 );
CH( m1 ) = CH( m2 );
CH( m2 ) = gene;
