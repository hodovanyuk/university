function resultGA = caSF( inputData,resultGA )
% ���������� �������������� ��������� 
% ��� ������������� � ������� Job Shop + job Flow
% ����:
%       inputData - ��������� � ���������� ��������� ������
%       resultGA  - ��������� � ����������� ������������
% �����:
%       resultGA  - ��������� � ������������ ���������� �����������

h = waitbar( 0,'���������� ��...' );
n = inputData.nJobs * inputData.nWorkers;
m = factorial( n ) / ...
    ( factorial( inputData.nWorkers ) ^ inputData.nJobs ) / ...
    inputData.nJobs;

% ����� ������ ������
tic;

% ������ �������� ������������������ �����
CH = repmat( [ 1:inputData.nJobs ],inputData.nWorkers,1 );
CH = reshape( CH,1,n );
resultGA.CA.fts = Inf;

% disp( num2str( inputData ) );
% ��������� ����������
idx = CH( 1:end-1 ) < CH( 2: end );
iterations = 0;
while( sum( idx ) )
    % ���������� ����������
    iterations = iterations + 1;
    if( mod( iterations,500 ) == 0 )
        disp( [ num2str( iterations ) ' �� ' num2str( m ) ] ); end
    waitbar( iterations / m,h );
    
    % disp( num2str( CH ) );
    [ H,fts ] = buildSchedulePR( CH,inputData );
    if( resultGA.CA.fts > fts )
        resultGA.CA.fts = fts;
        resultGA.CA.schedule = H;
    end
    
    idx1 = find( idx );
    idx1 = idx1( end );
    part = CH( idx1+1:end );
    [ element,idx ] = min( part( part > CH( idx1 ) ) );
    part( idx ) = [];
    
    if( idx1 ~= 1 )
        CH = [ CH( 1:idx1-1 ) element CH( idx1 ) sort( part ) ];
    else
        CH = [ element CH( idx1 ) sort( part ) ];
    end
    % disp( num2str( inputData ) );
    
    idx = CH( 1:end-1 ) < CH( 2:end );
end

% ���������� ������� ����������
resultGA.CA.processingTime = toc;

resultGA.CA.iterations = iterations;

close( h );