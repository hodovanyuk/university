function [ H,fitness ] = buildSchedulePR( CH,inputData )
% Построение расписания и вычисление функции фитнесса на основании
% хромосомы вида "перестановки с повторениями"
% Вход:
%       CH        - хромосома
%       inputData - входные данные работ и операций
% Выход:
%       H       - расписание
%       fitness - значение функции фитнесса

% индексы для хранения времен выполнения операций
iStartTime = 1;      % время начала выполнения операции
iFinishTime = 2;     % времы окончания выполнения операции
iTimeFromPrev = 3;   % начало текущей - окончание предыдущей операций
iJob = 4;            % номер работы
iOperation = 5;      % номер операции
iEndIndexH = iOperation; % переменная для указания последнего индекса
% создание массива для хранения информации о времени выполнения операции
op = zeros( iEndIndexH,1 );
% создание массива расписания
H = repmat( { op },inputData.nWorkers,1 );
% добавление первой операции в расписание
job = CH( 1 );
worker = inputData.jobs( job ).workers( 1 );
time = inputData.jobs( job ).times( 1 );
tmp = [ 0; time; 0; job; 1 ];
H( worker ) = { [ H{ worker } tmp ] };

% индексы для хранения информации по работе
iEarlyTime = 1;      % самое раннее возможное начало выполнения операции
iLastOperation = 2;  % номер последней выполненнной операции
iEndIndexJ = iLastOperation; % переменная для указания последнего индекса
% создание вспомогательного массива по работам
J = zeros( iEndIndexJ,length( inputData.jobs ) );
% добавление первой операции по текущей работе
J( :,job ) = [ time; 1 ];

% обход хромосомы и добавление операций в расписание
for i = 2:length( CH )
    % определение очередной работы
    job = CH( i );
    % определение выполняемой операции для текущей работы
    operation = J( iLastOperation,job ) + 1;
    % определение исполнителя
    worker = inputData.jobs( job ).workers( operation );
    % определение времени выполнения операции
    time = inputData.jobs( job ).times( operation );
    % определение минимального времени начала операции
    earlyTime = J( iEarlyTime,job );
    % чтение расписания для текущего исполнителя
    hh = H{ worker };
    % ищем индексы столбцов с достаточным временем окончания операции
    idx1 = find( hh( iFinishTime,: ) >= earlyTime ) + 1;
    % ищем индексы столбцов с достаточным временем до предыдущей операции
    idx2 = find( hh( iTimeFromPrev,: ) >= time );
    % ищем пересечение индексов
    idx = intersect( idx1,idx2 );
    % если такой индекс не найден - добавляем в конец списка новую операцию
    if( isempty( idx ) )
        earlyTime = max( hh( iFinishTime,end ),earlyTime );
        hh = [ hh [ earlyTime; earlyTime + time; ...
                    earlyTime - hh( iFinishTime,end ); ...
                    job; operation ] ];
    else
        % такой индекс есть - вставляем столбик перед данным элементом
        idx = idx( 1 );
        % надо вставить столбец внутрь матрицы
        earlyTime = hh( iFinishTime,idx - 1 );
        hh1 = [ earlyTime; earlyTime + time; ...
                earlyTime - hh( iFinishTime,idx - 1 ); ...
                job; operation ];
        hh = [ hh( :,1:idx - 1 ) hh1 hh( :,idx:end ) ];
        % обновляем время до предыдущей операции для след. элемента
        hh( iTimeFromPrev,idx + 1 ) = ...
          hh( iStartTime,idx + 1 ) - hh( iFinishTime,idx );
    end
    % обновляем расписание
    H( worker ) = { hh };
    % обновляем вспомогательный массив работ
    J( :,job ) = [ earlyTime + time; operation ];
end

% вычисление значения функции фитнесса
fitness = max( J( iEarlyTime,: ) );
