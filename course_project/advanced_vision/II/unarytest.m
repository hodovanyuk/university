% data line length lies between (1-delta) and (1+delta) of model line length
function success = unarytest(model,m,d,delta)

  global datalines Models unarydelta scalefactor
  
  lend = norm([datalines(d,3)-datalines(d,1),datalines(d,4)-datalines(d,2)]);
  lenm = norm([Models(model,m,3)-Models(model,m,1), ...
		Models(model,m,4)-Models(model,m,2)]);
  success = 0;
%lend
%scalefactor*lenm
%pause
  
  if scalefactor*lenm*(1-unarydelta) <= lend & lend <= scalefactor*lenm*(1+unarydelta)
    success = 1;
  end
