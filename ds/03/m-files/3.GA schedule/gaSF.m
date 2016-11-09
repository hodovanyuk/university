function resultGA = gaSF( inputData,paramsGA,resultGA )
% ���������� ������������� ��������� 
% ��� ������������� � ������� Job Shop + job Flow
% ����:
%       inputData - ��������� � ���������� ��������� ������
%       paramsGA  - ��������� � ����������� ������������� ���������
%       resultGA  - ��������� � ����������� ������������
% �����:
%       resultGA  - ��������� � ������������ ���������� �����������

% ���� ������ ���������� ������ ��� ����� ������������� - �����
if( resultGA.GA.iterations >= paramsGA.iterations ), return; end

% �� ������ - ��������� ���� �� ���������� ���������� ���������� ��������
h = waitbar( 0,'���������� ��...' );
for i = resultGA.GA.iterations:paramsGA.iterations
    resultGA = gaOneStepSF( inputData,paramsGA,resultGA );
    waitbar( i / paramsGA.iterations,h );
end
close( h );
