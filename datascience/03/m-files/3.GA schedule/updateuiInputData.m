function updateuiInputData
% Обновление интерфейса ScheduleBuilder
% в секции "Входные данные"

global inputData;
% обновление параметров
set( findobj( 'Tag','editWorkersNumber' ), ...
     'String',num2str( inputData.nWorkers ) );
set( findobj( 'Tag','editJobsNumber' ), ...
     'String',num2str( inputData.nJobs ) );
set( findobj( 'Tag','editMinT' ), ...
     'String',num2str( inputData.minTime ) );
set( findobj( 'Tag','editMaxT' ), ...
     'String',num2str( inputData.maxTime ) );

% создание таблицы для отображения
jobsTable = [];
for i = 1:inputData.nJobs
    jobsTable = [ jobsTable; ...
                  inputData.jobs( i ).workers; ...
                  inputData.jobs( i ).times ];
end

% настройка параметров отображения таблицы
h = findobj( 'Tag','uitableJobs' );
columnName = 1:inputData.nWorkers;
columnName = cellstr( num2str( columnName' ) );
columnName = columnName';
columnWidth = num2cell( ones( 1,inputData.nWorkers ) * 40 );
columnEditable = logical( ones( 1,inputData.nWorkers ) );
columnFormat = cellstr( repmat( 'numeric',inputData.nWorkers,1 ) );
columnFormat = columnFormat';

rowName = {};
for i = 1:inputData.nJobs
    rowName = [ rowName { [ 'Операции ' num2str( i ) ] } ...
                        { [ 'Время ' num2str( i ) ] } ];
end

% отображение таблицы
set( h,'ColumnName',columnName,'RowName',rowName, ...
       'ColumnWidth',columnWidth, ...
       'ColumnEditable',columnEditable, ...
       'ColumnFormat',columnFormat, ...
       'Data',jobsTable );
