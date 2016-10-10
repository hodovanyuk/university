function updateuiProcessingGA( arg )
% Обновление интерфейса ScheduleBuilder
% в секции "Выполнение ГА"

% 0 - очистка
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
         'String','Лучшая хромосома ГА' );
    set( findobj( 'Tag','textIterationsCA' ),'String','0' );
    set( findobj( 'Tag','textTimeCA' ),'String','0' );
    set( findobj( 'Tag','pushbuttonBestPlanCA' ), ...
         'String','Лучший план КА' );
    set( findobj( 'Tag','pushbuttonGAOneStep' ),'Enable','off' );
    set( findobj( 'Tag','pushbuttonGA' ),'Enable','off' );
case 1
    global paramsGA resultGA;
    % заполнение списка хромосом
    listCH = {};
    for i = 1:paramsGA.nCH
        listCH = [ listCH; ...
                   [ 'хромосома ' num2str( i ) ...
                     ': f = ' num2str( resultGA.popul.fts( i ) ) ] ];
    end
    set( findobj( 'Tag','listboxCurrentPopulation' ), ...
         'String',listCH,'Value',1 );

    % установка количества итераций
    set( findobj( 'Tag','textIterations' ), ...
         'String',num2str( resultGA.GA.iterations ) );

    % установка времени работы
    set( findobj( 'Tag','textTime' ), ...
         'String',num2str( resultGA.GA.processingTime ) );
    
    % установка значения фитнесса лучшей хромосомы
    set( findobj( 'Tag','textBestChromosome' ), ...
         'String',[ 'Лучшая хромосома ГА f = ' ...
                    num2str( resultGA.GA.fts ) ] );
    
    % открытие кнопок выполнения ГА
    set( findobj( 'Tag','pushbuttonGAOneStep' ),'Enable','on' );
    set( findobj( 'Tag','pushbuttonGA' ),'Enable','on' );
case 2
    global paramsGA resultGA;

    % установка количества итераций
    set( findobj( 'Tag','textIterationsCA' ), ...
         'String',num2str( resultGA.CA.iterations ) );

    % установка времени работы
    set( findobj( 'Tag','textTimeCA' ), ...
         'String',num2str( resultGA.CA.processingTime ) );
    
    % установка лучшего найденного времени плана
    set( findobj( 'Tag','pushbuttonBestPlanCA' ), ...
         'String',[ 'Лучший план КА f = ' ...
                    num2str( resultGA.CA.fts ) ] );
end
