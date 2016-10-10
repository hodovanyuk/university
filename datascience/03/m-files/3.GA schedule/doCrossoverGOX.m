function CH = doCrossoverGOX( CH1,CH2 )
% ���������� �������� ������������� ����������
% GOX (generalised order crossover) ��� ����������� ����
% "������������ � ������������"
% ����:
%      CH1,CH2 - ������������ ��������� ���� "������������ � ������������"
% �����:
%      CH - ���������-������� ���� "������������ � ������������"

% ���������� ����� ��������
n = length( CH1 );
% ���������� ��� ��������� ������� ��� ������ ����������� ����������
m1 = round( rand * (n - 1) + 1 );
m2 = round( rand * (n - 1) + 1 );
% ���� ��� ������� ������� ��� ���������� - ��������� ���������
while( ( m1 == m2 ) || ...
       ( ismember( m1,[ 1 n ] ) && ismember ( m2,[ 1 n ] ) ) )
    m1 = round( rand * (n - 1) + 1 );
    m2 = round( rand * (n - 1) + 1 );
end
% ���������� ������� �������, ���� m2 ������ �� m1
if( m1 > m2 ), t = m1; m1 = m2; m2 = t; end

% ��������, �������� �� �������� ���
if( ismember( m1,[ 1 n ] ) || ismember ( m2,[ 1 n ] ) )
    % ��������
    % �������� ����������� ����� �� ��������� 2
    part = CH2( m1:m2 );
    % ������������ ���������� ������� ���� � ���������� �����
    [ genes,count ] = countGenes( part );
    % ������� �� ��������� ����, ������� ���� � ����������� �����
    CH = CH1;
    for i = 1:length( genes )
        % ������� ������� ���������� ����
        idx = find( CH == genes( i ) );
        % �������� ������ ������ ���������� ��������
        idx = idx( 1:count( i ) );
        % ������� ������ count �������� �� ���������
        CH( idx ) = [];
    end
    % ��������� � ������ ��������� ���������� �����
    CH = [ part CH ];
    % ������� �� ��������� ����, ������� ���� � ����������� � ����� �����
    for i = 1:length( genes )
        % ������� ������� ���������� ����
        idx = find( CH == genes( i ) );
        % �������� ������ ������ ���������� ��������
        idx = idx( length( idx ) - count( i ) + 1:length( idx ) );
        % ������� ��������� count �������� �� ���������
        CH( idx ) = [];
    end
    % ��������� � ����� ��������� ���������� �����
    CH = [ CH part ];
else
    % �������� ��� �� ��������
    % ���������� ������ ������� ���������
    m = round( rand * (n - 2) + 2 );
    % �������� ����������� ����� �� ��������� 2
    part = CH2( m1:m2 );
    % ������������ ���������� ������� ���� � ���������� �����
    [ genes,count ] = countGenes( part );
    % ������� �� ���������, ������� � �����, ����, ������� ���� �
    % ����������� �����
    CH = CH1;
    for i = 1:length( genes )
        % ������� ������� ���������� ����
        idx = find( CH == genes( i ) );
        % �������� ������ ������ ���������� ��������
        idx = idx( length( idx ) - count( i ) + 1:length( idx ) );
        % ������������ ������ ����� �������
        m = m - sum( idx < m );
        % ������� ��������� count �������� �� ���������
        CH( idx ) = [];
    end
    % ��������� � ��������� ���������� �����
    CH = [ CH( 1:m-1 ) part CH( m:end ) ];
end