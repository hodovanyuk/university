function saveSchedule2txt( f,sh )

if( isempty( sh ) ), return; end

% индексы для хранения времен выполнения операций
iStartTime = 1;      % время начала выполнения операции
iFinishTime = 2;     % времы окончания выполнения операции
iTimeFromPrev = 3;   % начало текущей - окончание предыдущей операций
iJob = 4;            % номер работы
iOperation = 5;      % номер операции

for i = 1:length( sh )
    worker = sh{ i };
    fprintf( f,'Станок %d:',i );
    for j = 2:size( worker,2 )
        fprintf( f,' %d(%d-%d)',worker( iJob,j ), ...
                                worker( iStartTime,j ), ...
                                worker( iFinishTime,j ) );
    end
    fprintf( f,'\n' );
end
