function CH = doMutationExchange( CH )
% ћутаци€ хромосомы вида "перестановки с повторени€ми"
% ¬ход:
%       CH - исходна€ хромосома
% ¬ыход:
%       CH - мутировавша€ хромосома

% определ€ем количество генов
n = length( CH );
% определ€ем гены, которые надо обмен€ть
m1 = round( rand * ( n - 1 ) + 1 );
m2 = round( rand * ( n - 1 ) + 1 );
while( m2 == m1 )
    m2 = round( rand * ( n - 1 ) + 1 );
end

% обмениваем гены
gene = CH( m1 );
CH( m1 ) = CH( m2 );
CH( m2 ) = gene;
