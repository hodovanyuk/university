function drawSchedulePR( H )
% Отображение расписания
% Вход:
%       H - расписание
% Выход:
%       график расписания

% индексы для хранения времен выполнения операций
iStartTime = 1;      % время начала выполнения операции
iFinishTime = 2;     % времы окончания выполнения операции
iTimeFromPrev = 3;   % начало текущей - окончание предыдущей операций
iJob = 4;            % номер работы
iOperation = 5;      % номер операции

% определяем количество работ
workers = length( H );
maxjobs = 0;
for w = 1:workers
    % берем текущего исполнителя
    hh = H{ w };
    % вычисляем максимальное значение работы
    maxjobs = max( maxjobs,max( hh( iJob,: ) ) );
end

% задаем значения переменных
jobs = 0;
linesX = cell( 1,maxjobs );
linesY = linesX;
% проходим по всем исполнителям
for w = 1:workers
    % берем текущего исполнителя
    hh = H{ w };
    % проходим по операциям исполнителя
    for j = 2:size( hh,2 )
        job = hh( iJob,j );
        % строим линию для текущей операции
        linesX( job ) = { [ linesX{ job } ...
                          hh( iStartTime,j ) hh( iFinishTime,j ) ...
                          NaN ] };
        linesY( job ) = { [ linesY{ job } w w NaN ] };
    end
    jobs = max( jobs,size( hh,2 )-1 );
end

% открываем новый рисунок
figure;
legendString = {};
% строим массив цветов
colors = linspace( 0.25,0.75,jobs );
idx1 = 1:jobs;
idx13 = floor( jobs/3 );
idx2 = [ idx1( idx13+1:end ) idx1( 1:idx13 ) ];
idx3 = [ idx2( idx13+1:end ) idx1( 1:idx13 ) ];
colors = colors';
colors = [ colors colors( idx2 ) colors( idx3 ) ];
% проходим по всем работам и строим графики
for i = 1:jobs
    p = plot( linesX{ i },linesY{ i },'.-k' );
    set( p,'LineWidth',5,'Color',colors( i,: ) );
    hold on
    legendString = [ legendString; { [ ' job ' num2str( i ) ] } ];
end
ylim( [ -9 workers+10 ] );
set( gca,'YTick',1:workers );
legend( legendString );
xlabel( 'time (time units)' );
ylabel( 'worker' );
