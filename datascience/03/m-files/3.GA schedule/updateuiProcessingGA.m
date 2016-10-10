function updateuiProcessingGA( arg )
% ���������� ���������� ScheduleBuilder
% � ������ "���������� ��"

% 0 - �������
if( nargin == 0 )
    action = 0;
elseif( strcmp( arg,'clear' ) == 1 )
    action = 0;
elseif( strcmp( arg,'GA' ) == 1 )
    action = 1;
elseif( strcmp( arg,'CA' ) == 1 )
    action = 2;
else
    action = 0;
end

switch( action )
case 0
    set( findobj( 'Tag','listboxCurrentPopulation' ),'String',[] );
    set( findobj( 'Tag','textIterations' ),'String','0' );
    set( findobj( 'Tag','textTime' ),'String','0' );
    set( findobj( 'Tag','textBestChromosome' ), ...
         'String','������ ��������� ��' );
    set( findobj( 'Tag','textIterationsCA' ),'String','0' );
    set( findobj( 'Tag','textTimeCA' ),'String','0' );
    set( findobj( 'Tag','pushbuttonBestPlanCA' ), ...
         'String','������ ���� ��' );
    set( findobj( 'Tag','pushbuttonGAOneStep' ),'Enable','off' );
    set( findobj( 'Tag','pushbuttonGA' ),'Enable','off' );
case 1
    global paramsGA resultGA;
    % ���������� ������ ��������
    listCH = {};
    for i = 1:paramsGA.nCH
        listCH = [ listCH; ...
                   [ '��������� ' num2str( i ) ...
                     ': f = ' num2str( resultGA.popul.fts( i ) ) ] ];
    end
    set( findobj( 'Tag','listboxCurrentPopulation' ), ...
         'String',listCH,'Value',1 );

    % ��������� ���������� ��������
    set( findobj( 'Tag','textIterations' ), ...
         'String',num2str( resultGA.GA.iterations ) );

    % ��������� ������� ������
    set( findobj( 'Tag','textTime' ), ...
         'String',num2str( resultGA.GA.processingTime ) );
    
    % ��������� �������� �������� ������ ���������
    set( findobj( 'Tag','textBestChromosome' ), ...
         'String',[ '������ ��������� �� f = ' ...
                    num2str( resultGA.GA.fts ) ] );
    
    % �������� ������ ���������� ��
    set( findobj( 'Tag','pushbuttonGAOneStep' ),'Enable','on' );
    set( findobj( 'Tag','pushbuttonGA' ),'Enable','on' );
case 2
    global paramsGA resultGA;

    % ��������� ���������� ��������
    set( findobj( 'Tag','textIterationsCA' ), ...
         'String',num2str( resultGA.CA.iterations ) );

    % ��������� ������� ������
    set( findobj( 'Tag','textTimeCA' ), ...
         'String',num2str( resultGA.CA.processingTime ) );
    
    % ��������� ������� ���������� ������� �����
    set( findobj( 'Tag','pushbuttonBestPlanCA' ), ...
         'String',[ '������ ���� �� f = ' ...
                    num2str( resultGA.CA.fts ) ] );
end
