function clearResultsGA( arg )
% Очистка результатов ГА

global resultGA;

resultGA.popul.chs = [];
resultGA.popul.fts = [];
resultGA.popul.schedules = {};
resultGA.GA.ch = [];
resultGA.GA.fts = NaN;
resultGA.GA.schedule = [];
resultGA.GA.timeHistory = [];
resultGA.GA.iterations = 0;
resultGA.GA.processingTime = 0;

if( nargin == 0 )
    resultGA.CA.schedule = [];
    resultGA.CA.fts = NaN;
    resultGA.CA.processingTime = 0;
    resultGA.CA.iterations = 0;
end