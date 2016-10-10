function resultGA = gaOneStepSF( inputData,paramsGA,resultGA )
% Выполнение одного шага генетического алгоритма 
% для использования в задачах Job Shop + job Flow
% Вход:
%       inputData - структура с начальными условиями задачи
%       paramsGA  - структура с параметрами генетического алгоритма
%       resultGA  - структура с предыдущими результатами
% Выход:
%       resultGA  - структура с обновленными значениями результатов

% время начала работы ГА
tic;

% рассчитываем значения фитнесса
fitness = max( resultGA.popul.fts ) - resultGA.popul.fts + 1;
% рассчитываем части по отношению к целому
pFitness = fitness / sum( fitness );
pFitness = pFitness.^2;
pFitness = pFitness / sum( pFitness );
% рассчитываем кумулятивные суммы
fSums = cumsum( pFitness );

% рассчитываем новые хромосомы в популяции
n = 0;
newPopul = [];
while( n < paramsGA.nCH )
    % выбираем две хромосомы предков
    x = rand( 1,2 );
    % выбираем индекс для первой хромосомы
    idx1 = find( fSums >= x( 1 ) ); idx1 = idx1( 1 );
    % выбираем индекс для второй хромосомы
    idx2 = find( fSums >= x( 2 ) ); idx2 = idx2( 1 );
    % disp( [ idx1 idx2 ] );
    % если индексы одинаковые - переходим на начало цикла
    if( idx1 == idx2 )
        continue;
    end
    % индексы различные - формируем новую хромосому
    ch = paramsGA.crossoverFunc( resultGA.popul.chs( idx1,: ), ...
                                 resultGA.popul.chs( idx2,: ) );
    % добавляем хромосому к новой популяции
    newPopul = [ newPopul; ch ];
    n = n + 1;
end
% рассчитываем количество мутаций
pMutations = floor( paramsGA.nCH * paramsGA.pMutations / 100 );
% выполняем нужное количество мутаций
n = 0;
while( n < pMutations )
    % выбираем случайно хромосому для мутации
    idx = floor( rand( 1 ) * ( paramsGA.nCH - 1 ) + 1 );
    % выполняем мутацию
    newPopul( idx,: ) = paramsGA.mutationFunc( newPopul( idx,: ) );
    n = n + 1;
end

% обновляем все необходимые структуры данных
% построение массива хромосом
resultGA.popul.chs = newPopul;
% рассчет данных для каждой из хромосом
resultGA.popul.schedules = {};
resultGA.popul.fts = [];
for i = 1:paramsGA.nCH
    % построение расписания
    [ H,ft ] = buildSchedulePR( resultGA.popul.chs( i,: ),inputData );
    
    % добавление построенного расписания к списку расписаний
    resultGA.popul.schedules = [ resultGA.popul.schedules; { H } ];
    % добавление значения функции фитнесса
    resultGA.popul.fts = [ resultGA.popul.fts; ft ];
end

% поиск лучшего значения
[ bestTime,idxBestTime ] = min( resultGA.popul.fts );
if( bestTime < resultGA.GA.fts )
    resultGA.GA.fts = bestTime;
    resultGA.GA.ch = resultGA.popul.chs( idxBestTime,: );
    resultGA.GA.schedule = resultGA.popul.schedules{ idxBestTime };
end

% обновление истории лучшего времени расписания
resultGA.GA.timeHistory = [ resultGA.GA.timeHistory; ...
                            bestTime ];

% увеличиваем количество итераций
resultGA.GA.iterations = resultGA.GA.iterations + 1;

% обновляем время работы ГА
resultGA.GA.processingTime = resultGA.GA.processingTime + toc;
