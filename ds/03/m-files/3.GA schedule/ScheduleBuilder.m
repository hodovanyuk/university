function varargout = ScheduleBuilder(varargin)
% SCHEDULEBUILDER MATLAB code for ScheduleBuilder.fig
%      SCHEDULEBUILDER, by itself, creates a new SCHEDULEBUILDER or raises the existing
%      singleton*.
%
%      H = SCHEDULEBUILDER returns the handle to a new SCHEDULEBUILDER or the handle to
%      the existing singleton*.
%
%      SCHEDULEBUILDER('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in SCHEDULEBUILDER.M with the given input arguments.
%
%      SCHEDULEBUILDER('Property','Value',...) creates a new SCHEDULEBUILDER or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before ScheduleBuilder_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to ScheduleBuilder_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help ScheduleBuilder

% Last Modified by GUIDE v2.5 25-May-2016 15:07:42

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @ScheduleBuilder_OpeningFcn, ...
                   'gui_OutputFcn',  @ScheduleBuilder_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT

% ============================================== ScheduleBuilder_OpeningFcn
% --- Executes just before ScheduleBuilder is made visible.
function ScheduleBuilder_OpeningFcn( hObject,~,handles,varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to ScheduleBuilder (see VARARGIN)

% Choose default command line output for ScheduleBuilder
handles.output = hObject;
% Update handles structure
guidata(hObject, handles);

% изменения компонента выбора типа кроссовера на выпадающий список
h = findobj( 'Tag','listboxCrossoverType' );
set( h,'Style','popup' );
% изменения компонента выбора типа мутации на выпадающий список
h = findobj( 'Tag','listboxMutationType' );
set( h,'Style','popup' );
% позиционирование окна программы посредине экрана
h = findobj( 'Tag','figureGAMain' );
p = get( h,'Position' );
screen = get( 0,'screensize' );
halfX = round( screen( 3 )/2 - p( 3 )/2 );
p( 1 ) = halfX;
halfY = round( screen( 4 )/2 - p( 4 )/2 );
p( 2 ) = halfY;
set( h,'Position',p );

% настройка и сохранение входных параметров
global inputData;
inputData.nWorkers = 3;
inputData.nJobs = 3;
inputData.minTime = 20;
inputData.maxTime = 50;
% генерация случайного расписания для количества станков и работ по
% умолчанию
inputData.jobs = createJobsSF( inputData.nJobs,inputData.nWorkers, ...
                               inputData.minTime,inputData.maxTime );
updateuiInputData;
set( findobj( 'Tag','uitableJobs' ),'CellEditCallback',@cellEditCallBack );

% настройка и сохранение параметров ГА
global paramsGA;
paramsGA.nCH = 10;
paramsGA.pMutations = 10;
paramsGA.crossoverType = 1;
paramsGA.crossoverFunc = @doCrossoverGOX;
paramsGA.mutationType = 1;
paramsGA.mutationFunc = @doMutationInsert;
paramsGA.iterations = 100;
updateuiParamsGA;

% установка начальных значений результатов
clearResultsGA;
updateuiProcessingGA( 'clear' );

% =============================================== ScheduleBuilder_OutputFcn
% --- Outputs from this function are returned to the command line.
function varargout = ScheduleBuilder_OutputFcn( ~,~,handles ) 
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

% ======================================================== cellEditCallBack
% изменение значения в клетке таблицы работ
function cellEditCallBack( h,eventdata )

% если значение не поменялось - выход
if( eventdata.PreviousData == eventdata.NewData ), return; end

% значение поменялось - корректируем переменные
row = eventdata.Indices( 1 ) + 1;
job = floor( row / 2 );
info_type = mod( row,2 );
op = eventdata.Indices( 2 );
global inputData;
if( info_type == 0 )
    inputData.jobs( job ).workers( op ) = eventdata.NewData;
else
    inputData.jobs( job ).times( op ) = eventdata.NewData;
end
% очищаем результаты
clearResultsGA;
updateuiProcessingGA( 'clear' );

% ============================================== editWorkersNumber_Callback
% изменение количества станков
function editWorkersNumber_Callback( hObject,~,~ )
% hObject    handle to editWorkersNumber (see GCBO)

% читаем и конвертируем записанное число
x = str2num( get( hObject,'String' ) );

global inputData;
% если значение не поменялось - выход из функции
if( x == inputData.nWorkers ), return; end

% значение поменялось - обрабатываем
% если станков указано больше - нужно добавлять значения в массивах
if( x > inputData.nWorkers )
    for i = 1:inputData.nJobs
        n = length( inputData.jobs( i ).workers );
        inputData.jobs( i ).workers = [ inputData.jobs( i ).workers ...
                                        zeros( 1,x - n ) ];
        inputData.jobs( i ).times = [ inputData.jobs( i ).times ...
                                        zeros( 1,x - n ) ];
    end
% если станков указано меньше - удаляем последние значения в массивах
else
    for i = 1:inputData.nJobs
        inputData.jobs( i ).workers = inputData.jobs( i ).workers( 1:x );
        inputData.jobs( i ).times = inputData.jobs( i ).times( 1:x );
    end
end
% меняем значение в глобальной переменной
inputData.nWorkers = x;
% обновляем интерфейс
updateuiInputData;
% очищаем результаты
clearResultsGA;
updateuiProcessingGA( 'clear' );

% ================================================= editJobsNumber_Callback
% изменение количества деталей (работ)
function editJobsNumber_Callback( hObject,~,~ )
% hObject    handle to editJobsNumber (see GCBO)

% читаем и конвертируем записанное число
x = str2num( get( hObject,'String' ) );

global inputData;
% если значение не поменялось - выходим из функции
if( x == inputData.nJobs ), return; end

% значение поменялось - изменяем параметры
% если работ указано больше - нужно добавлять массивы
if( x > inputData.nJobs )
    job.workers = zeros( 1,inputData.nWorkers );
    job.times = job.workers;
    for i = 1:x-inputData.nJobs
        inputData.jobs = [ inputData.jobs job ];
    end
% если работ указано меньше - удаляем последние массивы
else
    inputData.jobs = inputData.jobs( 1:x );
end
% меняем значение в глобальной переменной
inputData.nJobs = x;
% обновляем интерфейс
updateuiInputData
% очищаем результаты
clearResultsGA;
updateuiProcessingGA( 'clear' );

% ======================================================= editMinT_Callback
% изменение минимального времени выполнения операции
function editMinT_Callback( hObject,~,~ )
% hObject    handle to editMinT (see GCBO)

% читаем и конвертируем записанное число
x = str2num( get( hObject,'String' ) );
% сохраняем в глобальную переменную
global inputData;
inputData.minTime = x;

% ======================================================= editMaxT_Callback
% изменение максимального времени выполнения операции
function editMaxT_Callback( hObject,~,~ )
% hObject    handle to editMaxT (see GCBO)

% читаем и конвертируем записанное число
x = str2num( get( hObject,'String' ) );
% сохраняем в глобальную переменную
global inputData;
inputData.maxTime = x;

% ==================================================== editCHCount_Callback
% изменение количества хромосом в популяции
function editCHCount_Callback( hObject,~,~ )
% hObject    handle to editCHCount (see GCBO)

% читаем и конвертируем записанное число
x = str2num( get( hObject,'String' ) );

global paramsGA;
% если значение не поменялось - выходим из функции
if( x == paramsGA.nCH ), return; end

% значение поменялось - сохраняем
paramsGA.nCH = x;
% очищаем результаты
clearResultsGA( 'GA' );
updateuiProcessingGA( 'clear' );
global resultGA;
if( ~isnan( resultGA.CA.fts ) ), updateuiProcessingGA( 'CA' ); end

% ============================================== editMutationsPerc_Callback
% изменение процента мутаций
function editMutationsPerc_Callback( hObject,~,~ )
% hObject    handle to editMutationsPerc (see GCBO)

% читаем и конвертируем записанное число
x = str2num( get( hObject,'String' ) );

global paramsGA;
% если значение не поменялось - выходим из функции
if( x == paramsGA.pMutations ), return; end

% значение поменялось - сохраняем
paramsGA.pMutations = x;
% очищаем результаты
clearResultsGA( 'GA' );
updateuiProcessingGA( 'clear' );
global resultGA;
if( ~isnan( resultGA.CA.fts ) ), updateuiProcessingGA( 'CA' ); end

% =========================================== listboxCrossoverType_Callback
% выбор функции кроссовера
function listboxCrossoverType_Callback( hObject,~,~ )
% hObject    handle to listboxCrossoverType (see GCBO)

% читаем номер выбранного элемента списка
x = get( hObject,'Value' );

global paramsGA;
% если значение не поменялось - выходим из функции
if( x == paramsGA.crossoverType ), return; end

% значение поменялось - сохраняем
paramsGA.crossoverType = x;
switch( x )
case 1
    paramsGA.crossoverFunc = @doCrossoverGOX;
case 2
    paramsGA.crossoverFunc = @doCrossoverGPMX;
case 3
    paramsGA.crossoverFunc = @doCrossoverPPX;
end
% очищаем результаты
clearResultsGA( 'GA' );
updateuiProcessingGA( 'clear' );
global resultGA;
if( ~isnan( resultGA.CA.fts ) ), updateuiProcessingGA( 'CA' ); end

% ============================================ listboxMutationType_Callback
% выбор функции мутации
function listboxMutationType_Callback( hObject,~,~ )
% hObject    handle to listboxMutationType (see GCBO)

% читаем номер выбранного элемента списка
x = get( hObject,'Value' );

global paramsGA;
% если значение не поменялось - выходим из функции
if( x == paramsGA.mutationType ), return; end

% значение поменялось - сохраняем
paramsGA.mutationType = x;
switch( x )
case 1
    paramsGA.mutationFunc = @doMutationInsert;
case 2
    paramsGA.mutationFunc = @doMutationExchange;
end
% очищаем результаты
clearResultsGA( 'GA' );
updateuiProcessingGA( 'clear' );
global resultGA;
if( ~isnan( resultGA.CA.fts ) ), updateuiProcessingGA( 'CA' ); end

% =========================================== editIterationsNumber_Callback
% изменение количества итераций ГА
function editIterationsNumber_Callback( hObject,~,~ )
% hObject    handle to editIterationsNumber (see GCBO)

% читаем и конвертируем записанное число
x = str2num( get( hObject,'String' ) );

global paramsGA;
% если значение не поменялось - выходим из функции
if( x == paramsGA.iterations ), return; end

% значение поменялось - сохраняем
paramsGA.iterations = x;
% очищаем результаты
clearResultsGA( 'GA' );
updateuiProcessingGA( 'clear' );
global resultGA;
if( ~isnan( resultGA.CA.fts ) ), updateuiProcessingGA( 'CA' ); end

% =============================================== pushbuttonGAInit_Callback
% нажатие на кнопку инициализации ГА
function pushbuttonGAInit_Callback( ~,~,~ )

% очистка результатов
clearResultsGA( 'GA' );

% инициализация ГА
global inputData paramsGA resultGA;
resultGA = gaInitSF( inputData,paramsGA,resultGA );

% обновление графического интерфейса
updateuiProcessingGA( 'GA' );

% ======================================= listboxCurrentPopulation_Callback
% отображение хромосомы из списка
function listboxCurrentPopulation_Callback( hObject,~,~ )
% hObject    handle to listboxCurrentPopulation (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB

global resultGA;

ch = get( hObject,'Value' );
if( ~isempty( ch ) )
    drawSchedulePR( resultGA.popul.schedules{ ch } );
end

% ============================================= textBestChromosome_Callback
% отображение лучшей хромосомы за весь период
function textBestChromosome_Callback( hObject,~,~ )
% hObject    handle to listboxCurrentPopulation (see GCBO)

global resultGA;

if( ~isempty( resultGA.GA.schedule ) )
    drawSchedulePR( resultGA.GA.schedule );
end

% ============================================= textFitnessHistory_Callback
% отображение истории лучшей хромосомы
function textFitnessHistory_Callback( hObject,~,~ )
% hObject    handle to listboxCurrentPopulation (see GCBO)

global resultGA;

if( ~isempty( resultGA.GA.timeHistory ) )
    figure;
    timeLine = [ 0:resultGA.GA.iterations ];
    plot( timeLine,resultGA.GA.timeHistory,'x-k' );
end

% ============================================ pushbuttonGAOneStep_Callback
% выполнение одного шага ГА
function pushbuttonGAOneStep_Callback( ~,~,~ )

global inputData paramsGA resultGA;

% выполнение шага
resultGA = gaOneStepSF( inputData,paramsGA,resultGA );

% обновление графического интерфейса
updateuiProcessingGA( 'GA' );

% =================================================== pushbuttonGA_Callback
% выполнение ГА
function pushbuttonGA_Callback( ~,~,~ )

global inputData paramsGA resultGA;

% выполнение ГА
resultGA = gaSF( inputData,paramsGA,resultGA );

% обновление графического интерфейса
updateuiProcessingGA( 'GA' );

% =================================================== pushbuttonCA_Callback
% выполнение КА
function pushbuttonCA_Callback( ~,~,~ )

global inputData resultGA;

% выполнение КА
resultGA = caSF( inputData,resultGA );

% обновление графического интерфейса
updateuiProcessingGA( 'CA' );

% =========================================== pushbuttonBestPlanCA_Callback
% отображение лучшего плана, найденного для КА
function pushbuttonBestPlanCA_Callback( ~,~,~ )

global resultGA;

if( ~isempty( resultGA.CA.schedule ) )
    drawSchedulePR( resultGA.CA.schedule );
end

% =============================================== menuCleanResults_Callback
% очистка результатов работы ГА и КА
function menuCleanResults_Callback( ~,~,~ )

% очищаем результаты
clearResultsGA;
updateuiProcessingGA( 'clear' );

% ========================================== menuMakeRanomInitData_Callback
% генерация случайных исходных данных
function menuMakeRanomInitData_Callback( ~,~,~ )

global inputData;

% генерация случайного расписания для количества станков и работ по
% умолчанию
inputData.jobs = createJobsSF( inputData.nJobs,inputData.nWorkers, ...
                               inputData.minTime,inputData.maxTime );
updateuiInputData;

% очищаем результаты
clearResultsGA;
updateuiProcessingGA( 'clear' );

% =============================================== menuSaveInitData_Callback
% сохранение исходных данных в файл
function menuSaveInitData_Callback( ~,~,~ )

[ filename,pathname ] = uiputfile( ...
       {'*.init', 'файлы с исходными данными (*.init)' }, ...
        'Сохранить исходные данные в...');

if( filename ~= 0 )
    global inputData;
    tmpDumbVariable = inputData;
    save( [ pathname filename ],'tmpDumbVariable' );
    clear tmpDumbVariable;
end

% ============================================= menuSaveParameters_Callback
% сохранение параметров ГА в файл
function menuSaveParameters_Callback( ~,~,~ )

[ filename,pathname ] = uiputfile( ...
       {'*.pars', 'файлы с параметрами ГА (*.pars)' }, ...
        'Сохранить параметры в...');

if( filename ~= 0 )
    global paramsGA;
    tmpDumbVariable = paramsGA;
    save( [ pathname filename ],'tmpDumbVariable' );
    clear tmpDumbVariable;
end

% =============================================== menuLoadInitData_Callback
% чтение исходных данных из файла
function menuLoadInitData_Callback( ~,~,~ )

[ filename,pathname ] = uigetfile( ...
       {'*.init', 'файлы с исходными данными (*.init)' }, ...
        'Читать файл с исходными данными');

if( filename ~= 0 )
    global inputData;
    load( [ pathname filename ],'-mat' );
    inputData = tmpDumbVariable;
    updateuiInputData;
    % очищаем результаты
    clearResultsGA;
    updateuiProcessingGA( 'clear' );
    clear tmpDumbVariable;
end

% ============================================= menuLoadParameters_Callback
% чтение параметров из файла
function menuLoadParameters_Callback( ~,~,~ )

[ filename,pathname ] = uigetfile( ...
       {'*.pars', 'файлы с параметрами ГА (*.pars)' }, ...
        'Читать файл с параметрами');

if( filename ~= 0 )
    global paramsGA;
    load( [ pathname filename ],'-mat' );
    paramsGA = tmpDumbVariable;
    updateuiParamsGA;
    % очищаем результаты
    clearResultsGA( 'GA' );
    updateuiProcessingGA( 'clear' );
    clear tmpDumbVariable;
    global resultGA;
    if( ~isnan( resultGA.CA.fts ) ), updateuiProcessingGA( 'CA' ); end
end

% ================================================ menuSaveResults_Callback 
% сохранение результатов в текстовый файл
function menuSaveResults_Callback( ~,~,~ )

[ filename,pathname ] = uiputfile( ...
       {'*.txt', 'текстовый файл (*.txt)' }, ...
        'Сохранение результата в текстовый файл');

if( filename ~= 0 )
    f = fopen( [ pathname filename ],'w' );
    % сохраняем исходные данные
    global inputData;
    fprintf( f,'\nСтанков: %d\n',inputData.nWorkers );
    fprintf( f,'Работ:   %d\n\n',inputData.nJobs );
    for i = 1:inputData.nJobs
        fprintf( f,'Работа %d:',i );
        for j = 1:inputData.nWorkers
            fprintf( f,' %d(%d) ',inputData.jobs( i ).workers( j ),...
                                  inputData.jobs( i ).times( j ) );
        end
        fprintf( f,'\n' );
    end
    fprintf( f,'\n-----------------------------------------------\n\n' );

    % сохраняем параметры ГА
    global paramsGA;
    fprintf( f,'Хромосом в популяции:     %d\n',paramsGA.nCH );
    fprintf( f,'Процент мутаций:          %d\n',paramsGA.pMutations );
    switch( paramsGA.crossoverType )
    case 1
        fprintf( f,'Тип оператора кроссовера: GOX\n' );
    case 2
        fprintf( f,'Тип оператора кроссовера: GPMX\n' );
    case 3
        fprintf( f,'Тип оператора кроссовера: PPX\n' );
    end
    switch( paramsGA.mutationType )
    case 1
        fprintf( f,'Тип оператора мутации:    insert\n' );
    case 2
        fprintf( f,'Тип оператора мутации:    exchange\n' );
    end
    fprintf( f,'Количество итераций ГА:   %d\n\n',paramsGA.iterations );
    fprintf( f,'-----------------------------------------------\n\n' );

    % сохраняем лучший результат ГА
    global resultGA;
    fprintf( f,'ГЕНЕТИЧЕСКИЙ АЛГОРИТМ\n' );
    fprintf( f,'Выполнено итераций: %d\n',resultGA.GA.iterations );
    fprintf( f,'Время работы ГА:    %0.4f c\n',resultGA.GA.processingTime );
    fprintf( f,'Значение фитнесса:  %d\n',resultGA.GA.fts );
    fprintf( f,'Лучшая хромосома:   %s\n',num2str( resultGA.GA.ch ) );
    % сохраняем лучший план
    fprintf( f,'\nЛучшее расписание, полученное ГА:\n\n' );
    saveSchedule2txt( f,resultGA.GA.schedule );
    fprintf( f,'\n-----------------------------------------------\n\n' );

    % сохраняем лучший результат КА
    global resultGA;
    fprintf( f,'КОМБИНАТОРНЫЙ АЛГОРИТМ\n' );
    fprintf( f,'Выполнено итераций: %d\n',resultGA.CA.iterations );
    fprintf( f,'Время работы КА:    %0.4f c\n',resultGA.CA.processingTime );
    fprintf( f,'Значение фитнесса:  %d\n',resultGA.CA.fts );
    % сохраняем лучший план
    fprintf( f,'\nЛучшее расписание, полученное КА:\n\n' );
    saveSchedule2txt( f,resultGA.CA.schedule );
    fprintf( f,'\n' );
    
    fclose( f );
end
