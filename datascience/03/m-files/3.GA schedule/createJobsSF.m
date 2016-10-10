function jobs = createJobsSF( jobsCount,workersCount, ...
                              minWorkerTime,maxWorkerTime )
% �������� ��������� ����� �� ��������� ������� ������
% ��� ������������� � ������� Job Shop + job Flow
% ����:
%       jobsCount     - ���������� �����, ������� ���� �������������
%       workersCount  - ���������� ������������ (�������)
%       minWorkerTime - ����������� ����� ���������� �������� ( def = 1 )
%       maxWorkerTime - ������������ ����� ���������� �������� ( def = 1 )
% �����:
%       jobs - ������ �������� � �������������������� �������� �
%              ��������� �� ���������� �������������

% ���� �� ������� ������������ ����� ���������� �������� - ����� 50
if( nargin < 4 ), maxWorkerTime = 50; end
% ���� �� ������� ����������� ����� ���������� �������� - ����� 1
if( nargin < 3 ), minWorkerTime = 1; end

% �������� ����� ��� ������ ��������
jobs = [];
% ���������� ������
for i = 1:jobsCount
    % ��������� ��������� ������
    % ������� ���������� ��������
    job.workers = randperm( workersCount );
    % ������� ���������� ��������
    job.times = floor( rand( 1,workersCount ) * ...
                       ( maxWorkerTime - minWorkerTime - 1 ) + ...
                       minWorkerTime + 1 );
    % ���������� ��������������� ������
    jobs = [ jobs job ];
end
