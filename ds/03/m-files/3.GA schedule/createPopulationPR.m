function population = createPopulationPR( inputData,n )
% �������� ��������� �������� ���� "������������ � ������������"
% ��� ��������� ��������� �����
% ����:
%       inputData - ��������� � ��������� �������
%       n         - ���������� �������� � ���������
% �����:
%       population - �������������� ��������� - ������ ( n x genes )

% ������ ��������� ������������������ �������� ��� ������ ������
indexes = [];
for i = 1:length( inputData.jobs )
    % ���������� ���������� �������� ��� ������� ������ � ������� ������
    % � ������ ����������� �������� ������ ������
    idx = ones( 1,length( inputData.jobs( i ).workers ) ) * i;
    % ��������� � ��� ����������� ��������
    indexes = [ indexes idx ];
end

% ������ ��������� ���������� ������������� �������� �������� � ���������
% �������
m = length( indexes );
population = zeros( n,m );
for i = 1:n
    idx = randperm( m );
    population( i,: ) = indexes( idx );
end
