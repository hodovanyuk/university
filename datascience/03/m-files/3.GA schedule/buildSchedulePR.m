function [ H,fitness ] = buildSchedulePR( CH,inputData )
% ���������� ���������� � ���������� ������� �������� �� ���������
% ��������� ���� "������������ � ������������"
% ����:
%       CH        - ���������
%       inputData - ������� ������ ����� � ��������
% �����:
%       H       - ����������
%       fitness - �������� ������� ��������

% ������� ��� �������� ������ ���������� ��������
iStartTime = 1;      % ����� ������ ���������� ��������
iFinishTime = 2;     % ����� ��������� ���������� ��������
iTimeFromPrev = 3;   % ������ ������� - ��������� ���������� ��������
iJob = 4;            % ����� ������
iOperation = 5;      % ����� ��������
iEndIndexH = iOperation; % ���������� ��� �������� ���������� �������
% �������� ������� ��� �������� ���������� � ������� ���������� ��������
op = zeros( iEndIndexH,1 );
% �������� ������� ����������
H = repmat( { op },inputData.nWorkers,1 );
% ���������� ������ �������� � ����������
job = CH( 1 );
worker = inputData.jobs( job ).workers( 1 );
time = inputData.jobs( job ).times( 1 );
tmp = [ 0; time; 0; job; 1 ];
H( worker ) = { [ H{ worker } tmp ] };

% ������� ��� �������� ���������� �� ������
iEarlyTime = 1;      % ����� ������ ��������� ������ ���������� ��������
iLastOperation = 2;  % ����� ��������� ������������ ��������
iEndIndexJ = iLastOperation; % ���������� ��� �������� ���������� �������
% �������� ���������������� ������� �� �������
J = zeros( iEndIndexJ,length( inputData.jobs ) );
% ���������� ������ �������� �� ������� ������
J( :,job ) = [ time; 1 ];

% ����� ��������� � ���������� �������� � ����������
for i = 2:length( CH )
    % ����������� ��������� ������
    job = CH( i );
    % ����������� ����������� �������� ��� ������� ������
    operation = J( iLastOperation,job ) + 1;
    % ����������� �����������
    worker = inputData.jobs( job ).workers( operation );
    % ����������� ������� ���������� ��������
    time = inputData.jobs( job ).times( operation );
    % ����������� ������������ ������� ������ ��������
    earlyTime = J( iEarlyTime,job );
    % ������ ���������� ��� �������� �����������
    hh = H{ worker };
    % ���� ������� �������� � ����������� �������� ��������� ��������
    idx1 = find( hh( iFinishTime,: ) >= earlyTime ) + 1;
    % ���� ������� �������� � ����������� �������� �� ���������� ��������
    idx2 = find( hh( iTimeFromPrev,: ) >= time );
    % ���� ����������� ��������
    idx = intersect( idx1,idx2 );
    % ���� ����� ������ �� ������ - ��������� � ����� ������ ����� ��������
    if( isempty( idx ) )
        earlyTime = max( hh( iFinishTime,end ),earlyTime );
        hh = [ hh [ earlyTime; earlyTime + time; ...
                    earlyTime - hh( iFinishTime,end ); ...
                    job; operation ] ];
    else
        % ����� ������ ���� - ��������� ������� ����� ������ ���������
        idx = idx( 1 );
        % ���� �������� ������� ������ �������
        earlyTime = hh( iFinishTime,idx - 1 );
        hh1 = [ earlyTime; earlyTime + time; ...
                earlyTime - hh( iFinishTime,idx - 1 ); ...
                job; operation ];
        hh = [ hh( :,1:idx - 1 ) hh1 hh( :,idx:end ) ];
        % ��������� ����� �� ���������� �������� ��� ����. ��������
        hh( iTimeFromPrev,idx + 1 ) = ...
          hh( iStartTime,idx + 1 ) - hh( iFinishTime,idx );
    end
    % ��������� ����������
    H( worker ) = { hh };
    % ��������� ��������������� ������ �����
    J( :,job ) = [ earlyTime + time; operation ];
end

% ���������� �������� ������� ��������
fitness = max( J( iEarlyTime,: ) );
