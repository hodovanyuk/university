function resultGA = gaInitSF( inputData,paramsGA,resultGA )
% ¬ыполнение инициализации генетического алгоритма 
% дл€ использовани€ в задачах Job Shop + job Flow
% ¬ход:
%       inputData - структура с начальными услови€ми задачи
%       paramsGA  - структура с параметрами генетического алгоритма
%       resultGA  - очищенна€ структура с результатами
% ¬ыход:
%       resultGA  - структура с новыми значени€ми результатов

% врем€ начала работы √ј
tic;

% создание новой попул€ции
resultGA.popul.chs = createPopulationPR( inputData,paramsGA.nCH );

% построение расписаний дл€ текущей попул€ции
for i = 1:paramsGA.nCH
    % построение расписани€
    [ H,ft ] = buildSchedulePR( resultGA.popul.chs( i,: ),inputData );
    
    % добавление построенного расписани€ к списку расписаний
    resultGA.popul.schedules = [ resultGA.popul.schedules; { H } ];
    % добавление значени€ функции фитнесса
    resultGA.popul.fts = [ resultGA.popul.fts; ft ];
end

% поиск лучшего значени€
[ bestTime,idxBestTime ] = min( resultGA.popul.fts );
resultGA.GA.fts = bestTime;
resultGA.GA.ch = resultGA.popul.chs( idxBestTime,: );
resultGA.GA.schedule = resultGA.popul.schedules{ idxBestTime };

% обновление истории лучшего времени расписани€
resultGA.GA.timeHistory = [ resultGA.GA.timeHistory; bestTime ];

% получение времени работы
resultGA.GA.processingTime = toc;
