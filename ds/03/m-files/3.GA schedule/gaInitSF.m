function resultGA = gaInitSF( inputData,paramsGA,resultGA )
% ���������� ������������� ������������� ��������� 
% ��� ������������� � ������� Job Shop + job Flow
% ����:
%       inputData - ��������� � ���������� ��������� ������
%       paramsGA  - ��������� � ����������� ������������� ���������
%       resultGA  - ��������� ��������� � ������������
% �����:
%       resultGA  - ��������� � ������ ���������� �����������

% ����� ������ ������ ��
tic;

% �������� ����� ���������
resultGA.popul.chs = createPopulationPR( inputData,paramsGA.nCH );

% ���������� ���������� ��� ������� ���������
for i = 1:paramsGA.nCH
    % ���������� ����������
    [ H,ft ] = buildSchedulePR( resultGA.popul.chs( i,: ),inputData );
    
    % ���������� ������������ ���������� � ������ ����������
    resultGA.popul.schedules = [ resultGA.popul.schedules; { H } ];
    % ���������� �������� ������� ��������
    resultGA.popul.fts = [ resultGA.popul.fts; ft ];
end

% ����� ������� ��������
[ bestTime,idxBestTime ] = min( resultGA.popul.fts );
resultGA.GA.fts = bestTime;
resultGA.GA.ch = resultGA.popul.chs( idxBestTime,: );
resultGA.GA.schedule = resultGA.popul.schedules{ idxBestTime };

% ���������� ������� ������� ������� ����������
resultGA.GA.timeHistory = [ resultGA.GA.timeHistory; bestTime ];

% ��������� ������� ������
resultGA.GA.processingTime = toc;
