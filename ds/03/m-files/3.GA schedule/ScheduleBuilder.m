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

% ��������� ���������� ������ ���� ���������� �� ���������� ������
h = findobj( 'Tag','listboxCrossoverType' );
set( h,'Style','popup' );
% ��������� ���������� ������ ���� ������� �� ���������� ������
h = findobj( 'Tag','listboxMutationType' );
set( h,'Style','popup' );
% ���������������� ���� ��������� ��������� ������
h = findobj( 'Tag','figureGAMain' );
p = get( h,'Position' );
screen = get( 0,'screensize' );
halfX = round( screen( 3 )/2 - p( 3 )/2 );
p( 1 ) = halfX;
halfY = round( screen( 4 )/2 - p( 4 )/2 );
p( 2 ) = halfY;
set( h,'Position',p );

% ��������� � ���������� ������� ����������
global inputData;
inputData.nWorkers = 3;
inputData.nJobs = 3;
inputData.minTime = 20;
inputData.maxTime = 50;
% ��������� ���������� ���������� ��� ���������� ������� � ����� ��
% ���������
inputData.jobs = createJobsSF( inputData.nJobs,inputData.nWorkers, ...
                               inputData.minTime,inputData.maxTime );
updateuiInputData;
set( findobj( 'Tag','uitableJobs' ),'CellEditCallback',@cellEditCallBack );

% ��������� � ���������� ���������� ��
global paramsGA;
paramsGA.nCH = 10;
paramsGA.pMutations = 10;
paramsGA.crossoverType = 1;
paramsGA.crossoverFunc = @doCrossoverGOX;
paramsGA.mutationType = 1;
paramsGA.mutationFunc = @doMutationInsert;
paramsGA.iterations = 100;
updateuiParamsGA;

% ��������� ��������� �������� �����������
clearResultsGA;
updateuiProcessingGA( 'clear' );

% =============================================== ScheduleBuilder_OutputFcn
% --- Outputs from this function are returned to the command line.
function varargout = ScheduleBuilder_OutputFcn( ~,~,handles ) 
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

% ======================================================== cellEditCallBack
% ��������� �������� � ������ ������� �����
function cellEditCallBack( h,eventdata )

% ���� �������� �� ���������� - �����
if( eventdata.PreviousData == eventdata.NewData ), return; end

% �������� ���������� - ������������ ����������
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
% ������� ����������
clearResultsGA;
updateuiProcessingGA( 'clear' );

% ============================================== editWorkersNumber_Callback
% ��������� ���������� �������
function editWorkersNumber_Callback( hObject,~,~ )
% hObject    handle to editWorkersNumber (see GCBO)

% ������ � ������������ ���������� �����
x = str2num( get( hObject,'String' ) );

global inputData;
% ���� �������� �� ���������� - ����� �� �������
if( x == inputData.nWorkers ), return; end

% �������� ���������� - ������������
% ���� ������� ������� ������ - ����� ��������� �������� � ��������
if( x > inputData.nWorkers )
    for i = 1:inputData.nJobs
        n = length( inputData.jobs( i ).workers );
        inputData.jobs( i ).workers = [ inputData.jobs( i ).workers ...
                                        zeros( 1,x - n ) ];
        inputData.jobs( i ).times = [ inputData.jobs( i ).times ...
                                        zeros( 1,x - n ) ];
    end
% ���� ������� ������� ������ - ������� ��������� �������� � ��������
else
    for i = 1:inputData.nJobs
        inputData.jobs( i ).workers = inputData.jobs( i ).workers( 1:x );
        inputData.jobs( i ).times = inputData.jobs( i ).times( 1:x );
    end
end
% ������ �������� � ���������� ����������
inputData.nWorkers = x;
% ��������� ���������
updateuiInputData;
% ������� ����������
clearResultsGA;
updateuiProcessingGA( 'clear' );

% ================================================= editJobsNumber_Callback
% ��������� ���������� ������� (�����)
function editJobsNumber_Callback( hObject,~,~ )
% hObject    handle to editJobsNumber (see GCBO)

% ������ � ������������ ���������� �����
x = str2num( get( hObject,'String' ) );

global inputData;
% ���� �������� �� ���������� - ������� �� �������
if( x == inputData.nJobs ), return; end

% �������� ���������� - �������� ���������
% ���� ����� ������� ������ - ����� ��������� �������
if( x > inputData.nJobs )
    job.workers = zeros( 1,inputData.nWorkers );
    job.times = job.workers;
    for i = 1:x-inputData.nJobs
        inputData.jobs = [ inputData.jobs job ];
    end
% ���� ����� ������� ������ - ������� ��������� �������
else
    inputData.jobs = inputData.jobs( 1:x );
end
% ������ �������� � ���������� ����������
inputData.nJobs = x;
% ��������� ���������
updateuiInputData
% ������� ����������
clearResultsGA;
updateuiProcessingGA( 'clear' );

% ======================================================= editMinT_Callback
% ��������� ������������ ������� ���������� ��������
function editMinT_Callback( hObject,~,~ )
% hObject    handle to editMinT (see GCBO)

% ������ � ������������ ���������� �����
x = str2num( get( hObject,'String' ) );
% ��������� � ���������� ����������
global inputData;
inputData.minTime = x;

% ======================================================= editMaxT_Callback
% ��������� ������������� ������� ���������� ��������
function editMaxT_Callback( hObject,~,~ )
% hObject    handle to editMaxT (see GCBO)

% ������ � ������������ ���������� �����
x = str2num( get( hObject,'String' ) );
% ��������� � ���������� ����������
global inputData;
inputData.maxTime = x;

% ==================================================== editCHCount_Callback
% ��������� ���������� �������� � ���������
function editCHCount_Callback( hObject,~,~ )
% hObject    handle to editCHCount (see GCBO)

% ������ � ������������ ���������� �����
x = str2num( get( hObject,'String' ) );

global paramsGA;
% ���� �������� �� ���������� - ������� �� �������
if( x == paramsGA.nCH ), return; end

% �������� ���������� - ���������
paramsGA.nCH = x;
% ������� ����������
clearResultsGA( 'GA' );
updateuiProcessingGA( 'clear' );
global resultGA;
if( ~isnan( resultGA.CA.fts ) ), updateuiProcessingGA( 'CA' ); end

% ============================================== editMutationsPerc_Callback
% ��������� �������� �������
function editMutationsPerc_Callback( hObject,~,~ )
% hObject    handle to editMutationsPerc (see GCBO)

% ������ � ������������ ���������� �����
x = str2num( get( hObject,'String' ) );

global paramsGA;
% ���� �������� �� ���������� - ������� �� �������
if( x == paramsGA.pMutations ), return; end

% �������� ���������� - ���������
paramsGA.pMutations = x;
% ������� ����������
clearResultsGA( 'GA' );
updateuiProcessingGA( 'clear' );
global resultGA;
if( ~isnan( resultGA.CA.fts ) ), updateuiProcessingGA( 'CA' ); end

% =========================================== listboxCrossoverType_Callback
% ����� ������� ����������
function listboxCrossoverType_Callback( hObject,~,~ )
% hObject    handle to listboxCrossoverType (see GCBO)

% ������ ����� ���������� �������� ������
x = get( hObject,'Value' );

global paramsGA;
% ���� �������� �� ���������� - ������� �� �������
if( x == paramsGA.crossoverType ), return; end

% �������� ���������� - ���������
paramsGA.crossoverType = x;
switch( x )
case 1
    paramsGA.crossoverFunc = @doCrossoverGOX;
case 2
    paramsGA.crossoverFunc = @doCrossoverGPMX;
case 3
    paramsGA.crossoverFunc = @doCrossoverPPX;
end
% ������� ����������
clearResultsGA( 'GA' );
updateuiProcessingGA( 'clear' );
global resultGA;
if( ~isnan( resultGA.CA.fts ) ), updateuiProcessingGA( 'CA' ); end

% ============================================ listboxMutationType_Callback
% ����� ������� �������
function listboxMutationType_Callback( hObject,~,~ )
% hObject    handle to listboxMutationType (see GCBO)

% ������ ����� ���������� �������� ������
x = get( hObject,'Value' );

global paramsGA;
% ���� �������� �� ���������� - ������� �� �������
if( x == paramsGA.mutationType ), return; end

% �������� ���������� - ���������
paramsGA.mutationType = x;
switch( x )
case 1
    paramsGA.mutationFunc = @doMutationInsert;
case 2
    paramsGA.mutationFunc = @doMutationExchange;
end
% ������� ����������
clearResultsGA( 'GA' );
updateuiProcessingGA( 'clear' );
global resultGA;
if( ~isnan( resultGA.CA.fts ) ), updateuiProcessingGA( 'CA' ); end

% =========================================== editIterationsNumber_Callback
% ��������� ���������� �������� ��
function editIterationsNumber_Callback( hObject,~,~ )
% hObject    handle to editIterationsNumber (see GCBO)

% ������ � ������������ ���������� �����
x = str2num( get( hObject,'String' ) );

global paramsGA;
% ���� �������� �� ���������� - ������� �� �������
if( x == paramsGA.iterations ), return; end

% �������� ���������� - ���������
paramsGA.iterations = x;
% ������� ����������
clearResultsGA( 'GA' );
updateuiProcessingGA( 'clear' );
global resultGA;
if( ~isnan( resultGA.CA.fts ) ), updateuiProcessingGA( 'CA' ); end

% =============================================== pushbuttonGAInit_Callback
% ������� �� ������ ������������� ��
function pushbuttonGAInit_Callback( ~,~,~ )

% ������� �����������
clearResultsGA( 'GA' );

% ������������� ��
global inputData paramsGA resultGA;
resultGA = gaInitSF( inputData,paramsGA,resultGA );

% ���������� ������������ ����������
updateuiProcessingGA( 'GA' );

% ======================================= listboxCurrentPopulation_Callback
% ����������� ��������� �� ������
function listboxCurrentPopulation_Callback( hObject,~,~ )
% hObject    handle to listboxCurrentPopulation (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB

global resultGA;

ch = get( hObject,'Value' );
if( ~isempty( ch ) )
    drawSchedulePR( resultGA.popul.schedules{ ch } );
end

% ============================================= textBestChromosome_Callback
% ����������� ������ ��������� �� ���� ������
function textBestChromosome_Callback( hObject,~,~ )
% hObject    handle to listboxCurrentPopulation (see GCBO)

global resultGA;

if( ~isempty( resultGA.GA.schedule ) )
    drawSchedulePR( resultGA.GA.schedule );
end

% ============================================= textFitnessHistory_Callback
% ����������� ������� ������ ���������
function textFitnessHistory_Callback( hObject,~,~ )
% hObject    handle to listboxCurrentPopulation (see GCBO)

global resultGA;

if( ~isempty( resultGA.GA.timeHistory ) )
    figure;
    timeLine = [ 0:resultGA.GA.iterations ];
    plot( timeLine,resultGA.GA.timeHistory,'x-k' );
end

% ============================================ pushbuttonGAOneStep_Callback
% ���������� ������ ���� ��
function pushbuttonGAOneStep_Callback( ~,~,~ )

global inputData paramsGA resultGA;

% ���������� ����
resultGA = gaOneStepSF( inputData,paramsGA,resultGA );

% ���������� ������������ ����������
updateuiProcessingGA( 'GA' );

% =================================================== pushbuttonGA_Callback
% ���������� ��
function pushbuttonGA_Callback( ~,~,~ )

global inputData paramsGA resultGA;

% ���������� ��
resultGA = gaSF( inputData,paramsGA,resultGA );

% ���������� ������������ ����������
updateuiProcessingGA( 'GA' );

% =================================================== pushbuttonCA_Callback
% ���������� ��
function pushbuttonCA_Callback( ~,~,~ )

global inputData resultGA;

% ���������� ��
resultGA = caSF( inputData,resultGA );

% ���������� ������������ ����������
updateuiProcessingGA( 'CA' );

% =========================================== pushbuttonBestPlanCA_Callback
% ����������� ������� �����, ���������� ��� ��
function pushbuttonBestPlanCA_Callback( ~,~,~ )

global resultGA;

if( ~isempty( resultGA.CA.schedule ) )
    drawSchedulePR( resultGA.CA.schedule );
end

% =============================================== menuCleanResults_Callback
% ������� ����������� ������ �� � ��
function menuCleanResults_Callback( ~,~,~ )

% ������� ����������
clearResultsGA;
updateuiProcessingGA( 'clear' );

% ========================================== menuMakeRanomInitData_Callback
% ��������� ��������� �������� ������
function menuMakeRanomInitData_Callback( ~,~,~ )

global inputData;

% ��������� ���������� ���������� ��� ���������� ������� � ����� ��
% ���������
inputData.jobs = createJobsSF( inputData.nJobs,inputData.nWorkers, ...
                               inputData.minTime,inputData.maxTime );
updateuiInputData;

% ������� ����������
clearResultsGA;
updateuiProcessingGA( 'clear' );

% =============================================== menuSaveInitData_Callback
% ���������� �������� ������ � ����
function menuSaveInitData_Callback( ~,~,~ )

[ filename,pathname ] = uiputfile( ...
       {'*.init', '����� � ��������� ������� (*.init)' }, ...
        '��������� �������� ������ �...');

if( filename ~= 0 )
    global inputData;
    tmpDumbVariable = inputData;
    save( [ pathname filename ],'tmpDumbVariable' );
    clear tmpDumbVariable;
end

% ============================================= menuSaveParameters_Callback
% ���������� ���������� �� � ����
function menuSaveParameters_Callback( ~,~,~ )

[ filename,pathname ] = uiputfile( ...
       {'*.pars', '����� � ����������� �� (*.pars)' }, ...
        '��������� ��������� �...');

if( filename ~= 0 )
    global paramsGA;
    tmpDumbVariable = paramsGA;
    save( [ pathname filename ],'tmpDumbVariable' );
    clear tmpDumbVariable;
end

% =============================================== menuLoadInitData_Callback
% ������ �������� ������ �� �����
function menuLoadInitData_Callback( ~,~,~ )

[ filename,pathname ] = uigetfile( ...
       {'*.init', '����� � ��������� ������� (*.init)' }, ...
        '������ ���� � ��������� �������');

if( filename ~= 0 )
    global inputData;
    load( [ pathname filename ],'-mat' );
    inputData = tmpDumbVariable;
    updateuiInputData;
    % ������� ����������
    clearResultsGA;
    updateuiProcessingGA( 'clear' );
    clear tmpDumbVariable;
end

% ============================================= menuLoadParameters_Callback
% ������ ���������� �� �����
function menuLoadParameters_Callback( ~,~,~ )

[ filename,pathname ] = uigetfile( ...
       {'*.pars', '����� � ����������� �� (*.pars)' }, ...
        '������ ���� � �����������');

if( filename ~= 0 )
    global paramsGA;
    load( [ pathname filename ],'-mat' );
    paramsGA = tmpDumbVariable;
    updateuiParamsGA;
    % ������� ����������
    clearResultsGA( 'GA' );
    updateuiProcessingGA( 'clear' );
    clear tmpDumbVariable;
    global resultGA;
    if( ~isnan( resultGA.CA.fts ) ), updateuiProcessingGA( 'CA' ); end
end

% ================================================ menuSaveResults_Callback 
% ���������� ����������� � ��������� ����
function menuSaveResults_Callback( ~,~,~ )

[ filename,pathname ] = uiputfile( ...
       {'*.txt', '��������� ���� (*.txt)' }, ...
        '���������� ���������� � ��������� ����');

if( filename ~= 0 )
    f = fopen( [ pathname filename ],'w' );
    % ��������� �������� ������
    global inputData;
    fprintf( f,'\n�������: %d\n',inputData.nWorkers );
    fprintf( f,'�����:   %d\n\n',inputData.nJobs );
    for i = 1:inputData.nJobs
        fprintf( f,'������ %d:',i );
        for j = 1:inputData.nWorkers
            fprintf( f,' %d(%d) ',inputData.jobs( i ).workers( j ),...
                                  inputData.jobs( i ).times( j ) );
        end
        fprintf( f,'\n' );
    end
    fprintf( f,'\n-----------------------------------------------\n\n' );

    % ��������� ��������� ��
    global paramsGA;
    fprintf( f,'�������� � ���������:     %d\n',paramsGA.nCH );
    fprintf( f,'������� �������:          %d\n',paramsGA.pMutations );
    switch( paramsGA.crossoverType )
    case 1
        fprintf( f,'��� ��������� ����������: GOX\n' );
    case 2
        fprintf( f,'��� ��������� ����������: GPMX\n' );
    case 3
        fprintf( f,'��� ��������� ����������: PPX\n' );
    end
    switch( paramsGA.mutationType )
    case 1
        fprintf( f,'��� ��������� �������:    insert\n' );
    case 2
        fprintf( f,'��� ��������� �������:    exchange\n' );
    end
    fprintf( f,'���������� �������� ��:   %d\n\n',paramsGA.iterations );
    fprintf( f,'-----------------------------------------------\n\n' );

    % ��������� ������ ��������� ��
    global resultGA;
    fprintf( f,'������������ ��������\n' );
    fprintf( f,'��������� ��������: %d\n',resultGA.GA.iterations );
    fprintf( f,'����� ������ ��:    %0.4f c\n',resultGA.GA.processingTime );
    fprintf( f,'�������� ��������:  %d\n',resultGA.GA.fts );
    fprintf( f,'������ ���������:   %s\n',num2str( resultGA.GA.ch ) );
    % ��������� ������ ����
    fprintf( f,'\n������ ����������, ���������� ��:\n\n' );
    saveSchedule2txt( f,resultGA.GA.schedule );
    fprintf( f,'\n-----------------------------------------------\n\n' );

    % ��������� ������ ��������� ��
    global resultGA;
    fprintf( f,'������������� ��������\n' );
    fprintf( f,'��������� ��������: %d\n',resultGA.CA.iterations );
    fprintf( f,'����� ������ ��:    %0.4f c\n',resultGA.CA.processingTime );
    fprintf( f,'�������� ��������:  %d\n',resultGA.CA.fts );
    % ��������� ������ ����
    fprintf( f,'\n������ ����������, ���������� ��:\n\n' );
    saveSchedule2txt( f,resultGA.CA.schedule );
    fprintf( f,'\n' );
    
    fclose( f );
end
