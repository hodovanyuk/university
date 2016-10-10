function drawSchedulePR( H )
% ����������� ����������
% ����:
%       H - ����������
% �����:
%       ������ ����������

% ������� ��� �������� ������ ���������� ��������
iStartTime = 1;      % ����� ������ ���������� ��������
iFinishTime = 2;     % ����� ��������� ���������� ��������
iTimeFromPrev = 3;   % ������ ������� - ��������� ���������� ��������
iJob = 4;            % ����� ������
iOperation = 5;      % ����� ��������

% ���������� ���������� �����
workers = length( H );
maxjobs = 0;
for w = 1:workers
    % ����� �������� �����������
    hh = H{ w };
    % ��������� ������������ �������� ������
    maxjobs = max( maxjobs,max( hh( iJob,: ) ) );
end

% ������ �������� ����������
jobs = 0;
linesX = cell( 1,maxjobs );
linesY = linesX;
% �������� �� ���� ������������
for w = 1:workers
    % ����� �������� �����������
    hh = H{ w };
    % �������� �� ��������� �����������
    for j = 2:size( hh,2 )
        job = hh( iJob,j );
        % ������ ����� ��� ������� ��������
        linesX( job ) = { [ linesX{ job } ...
                          hh( iStartTime,j ) hh( iFinishTime,j ) ...
                          NaN ] };
        linesY( job ) = { [ linesY{ job } w w NaN ] };
    end
    jobs = max( jobs,size( hh,2 )-1 );
end

% ��������� ����� �������
figure;
legendString = {};
% ������ ������ ������
colors = linspace( 0.25,0.75,jobs );
idx1 = 1:jobs;
idx13 = floor( jobs/3 );
idx2 = [ idx1( idx13+1:end ) idx1( 1:idx13 ) ];
idx3 = [ idx2( idx13+1:end ) idx1( 1:idx13 ) ];
colors = colors';
colors = [ colors colors( idx2 ) colors( idx3 ) ];
% �������� �� ���� ������� � ������ �������
for i = 1:jobs
    p = plot( linesX{ i },linesY{ i },'.-k' );
    set( p,'LineWidth',5,'Color',colors( i,: ) );
    hold on
    legendString = [ legendString; { [ ' job ' num2str( i ) ] } ];
end
ylim( [ -9 workers+10 ] );
set( gca,'YTick',1:workers );
legend( legendString );
xlabel( 'time (time units)' );
ylabel( 'worker' );
