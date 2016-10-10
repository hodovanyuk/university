function saveSchedule2txt( f,sh )

if( isempty( sh ) ), return; end

% ������� ��� �������� ������ ���������� ��������
iStartTime = 1;      % ����� ������ ���������� ��������
iFinishTime = 2;     % ����� ��������� ���������� ��������
iTimeFromPrev = 3;   % ������ ������� - ��������� ���������� ��������
iJob = 4;            % ����� ������
iOperation = 5;      % ����� ��������

for i = 1:length( sh )
    worker = sh{ i };
    fprintf( f,'������ %d:',i );
    for j = 2:size( worker,2 )
        fprintf( f,' %d(%d-%d)',worker( iJob,j ), ...
                                worker( iStartTime,j ), ...
                                worker( iFinishTime,j ) );
    end
    fprintf( f,'\n' );
end
