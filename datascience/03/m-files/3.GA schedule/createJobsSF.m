function jobs = createJobsSF( jobsCount,workersCount, ...
                              minWorkerTime,maxWorkerTime )
% Создание множества работ на основании входных данных
% для использования в задачах Job Shop + job Flow
% Вход:
%       jobsCount     - количество работ, которые надо сгенерировать
%       workersCount  - количество исполнителей (станков)
%       minWorkerTime - минимальное время выполнения операции ( def = 1 )
%       maxWorkerTime - максимальное время выполнения операции ( def = 1 )
% Выход:
%       jobs - массив структур с последовательностями операций и
%              временами их выполнения исполнителями

% если не указано максимальное время выполнения операции - берем 50
if( nargin < 4 ), maxWorkerTime = 50; end
% если не указано минимальное время выполнения операции - берем 1
if( nargin < 3 ), minWorkerTime = 1; end

% выделяем место под массив структур
jobs = [];
% генерируем работы
for i = 1:jobsCount
    % генерация очередной работы
    % порядок выполнения операций
    job.workers = randperm( workersCount );
    % времена выполнения операций
    job.times = floor( rand( 1,workersCount ) * ...
                       ( maxWorkerTime - minWorkerTime - 1 ) + ...
                       minWorkerTime + 1 );
    % добавление сгенерированной работы
    jobs = [ jobs job ];
end
