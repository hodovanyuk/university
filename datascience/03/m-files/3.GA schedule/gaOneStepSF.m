function resultGA = gaOneStepSF( inputData,paramsGA,resultGA )
% ���������� ������ ���� ������������� ��������� 
% ��� ������������� � ������� Job Shop + job Flow
% ����:
%       inputData - ��������� � ���������� ��������� ������
%       paramsGA  - ��������� � ����������� ������������� ���������
%       resultGA  - ��������� � ����������� ������������
% �����:
%       resultGA  - ��������� � ������������ ���������� �����������

% ����� ������ ������ ��
tic;

% ������������ �������� ��������
fitness = max( resultGA.popul.fts ) - resultGA.popul.fts + 1;
% ������������ ����� �� ��������� � ������
pFitness = fitness / sum( fitness );
pFitness = pFitness.^2;
pFitness = pFitness / sum( pFitness );
% ������������ ������������ �����
fSums = cumsum( pFitness );

% ������������ ����� ��������� � ���������
n = 0;
newPopul = [];
while( n < paramsGA.nCH )
    % �������� ��� ��������� �������
    x = rand( 1,2 );
    % �������� ������ ��� ������ ���������
    idx1 = find( fSums >= x( 1 ) ); idx1 = idx1( 1 );
    % �������� ������ ��� ������ ���������
    idx2 = find( fSums >= x( 2 ) ); idx2 = idx2( 1 );
    % disp( [ idx1 idx2 ] );
    % ���� ������� ���������� - ��������� �� ������ �����
    if( idx1 == idx2 )
        continue;
    end
    % ������� ��������� - ��������� ����� ���������
    ch = paramsGA.crossoverFunc( resultGA.popul.chs( idx1,: ), ...
                                 resultGA.popul.chs( idx2,: ) );
    % ��������� ��������� � ����� ���������
    newPopul = [ newPopul; ch ];
    n = n + 1;
end
% ������������ ���������� �������
pMutations = floor( paramsGA.nCH * paramsGA.pMutations / 100 );
% ��������� ������ ���������� �������
n = 0;
while( n < pMutations )
    % �������� �������� ��������� ��� �������
    idx = floor( rand( 1 ) * ( paramsGA.nCH - 1 ) + 1 );
    % ��������� �������
    newPopul( idx,: ) = paramsGA.mutationFunc( newPopul( idx,: ) );
    n = n + 1;
end

% ��������� ��� ����������� ��������� ������
% ���������� ������� ��������
resultGA.popul.chs = newPopul;
% ������� ������ ��� ������ �� ��������
resultGA.popul.schedules = {};
resultGA.popul.fts = [];
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
if( bestTime < resultGA.GA.fts )
    resultGA.GA.fts = bestTime;
    resultGA.GA.ch = resultGA.popul.chs( idxBestTime,: );
    resultGA.GA.schedule = resultGA.popul.schedules{ idxBestTime };
end

% ���������� ������� ������� ������� ����������
resultGA.GA.timeHistory = [ resultGA.GA.timeHistory; ...
                            bestTime ];

% ����������� ���������� ��������
resultGA.GA.iterations = resultGA.GA.iterations + 1;

% ��������� ����� ������ ��
resultGA.GA.processingTime = resultGA.GA.processingTime + toc;
