function resultGA = gaSF( inputData,paramsGA,resultGA )
% ¬ыполнение генетического алгоритма 
% дл€ использовани€ в задачах Job Shop + job Flow
% ¬ход:
%       inputData - структура с начальными услови€ми задачи
%       paramsGA  - структура с параметрами генетического алгоритма
%       resultGA  - структура с предыдущими результатами
% ¬ыход:
%       resultGA  - структура с обновленными значени€ми результатов

% если ткущее количество больше или равно максимальному - выход
if( resultGA.GA.iterations >= paramsGA.iterations ), return; end

% не больше - выполн€ем шаги до достижени€ указанного количества итераций
h = waitbar( 0,'¬ыполнение √ј...' );
for i = resultGA.GA.iterations:paramsGA.iterations
    resultGA = gaOneStepSF( inputData,paramsGA,resultGA );
    waitbar( i / paramsGA.iterations,h );
end
close( h );
