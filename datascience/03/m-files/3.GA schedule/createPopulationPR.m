function population = createPopulationPR( inputData,n )
% Создание популяции хромосом вида "перестановки с повторениями"
% для заданного множества работ
% Вход:
%       inputData - структура с исходными данными
%       n         - количество хромосом в популяции
% Выход:
%       population - результирующая популяция - массив ( n x genes )

% строим начальную последовательность индексов для каждой работы
indexes = [];
for i = 1:length( inputData.jobs )
    % определяем количество операций для текущей работы и создаем массив
    % с нужным количеством индексов данной работы
    idx = ones( 1,length( inputData.jobs( i ).workers ) ) * i;
    % добавляем к уже построенным индексам
    indexes = [ indexes idx ];
end

% каждая хромосома получается выстраиванием индексов операций в случайном
% порядке
m = length( indexes );
population = zeros( n,m );
for i = 1:n
    idx = randperm( m );
    population( i,: ) = indexes( idx );
end
