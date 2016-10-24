% interpretation tree - match model and data lines until Limit are 
% successfully paired or can never get Limit
% model - current model
% numM - number of lines in the model
% mlevel - last matched model feature
% Limit - early termination threshold
% pairs(:,2) - paired model-data features
% numpairs - number of paired features
function success=itree(model,numM,mlevel,Limit,pairs,numpairs)

  global Models numlines datalines

  % check for termination conditions
  if numpairs >= Limit		% enough pairs to verify
model
matchedpairs=pairs(1:numpairs,:)

    [theta,trans] = estimatepose(model,numpairs,pairs)
    for p = 1 : 4
      success = verifymatch(theta(p),trans(p,:)',model,numpairs,pairs);
      if success
      rot_angle = theta(p)
      translation = trans(p,:)'
        return
      end
    end
    return
  end
  if numpairs + numM - mlevel < Limit	% never enough pairs
    success=0;
    return
  end

  % normal case - see if we can extend pair list
  mlevel = mlevel+1;
  for d = 1 : numlines	% try all data lines
%trypair=[mlevel,d]
    if unarytest(model,mlevel,d)
      % do all binary tests
      passed=1;

      for p = 1 : numpairs
        if ~binarytest(model,mlevel,d,pairs(p,1),pairs(p,2))
          passed=0;
          break
        end
      end
%if mlevel==5 & d==7
%passed=0;
%end
      % passed all tests, so add to matched pairs and recurse
      if passed
	pairs(numpairs+1,1)=mlevel;
	pairs(numpairs+1,2)=d;
	success = itree(model,numM,mlevel,Limit,pairs,numpairs+1);
	if success
	  return
	end
      end
    end
  end

  % wildcard case - go to next model line
  success = itree(model,numM,mlevel,Limit,pairs,numpairs);

%   108   177   291   331       model line 6
%   291   331   375   246       model line 7
%   375   246   461   321	model line 8
%   461   321   461   336	model line -
%   461   336   443   358	model line -
%   443   358   219   607	model line 1
%   219   607   127   533	model line 2
%   127   533   202   437	model line 3
%   202   437    21   275	model line 4
%    21   275   108   177       model line 5

