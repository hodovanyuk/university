% tries to recognize the given set of Lines with the set of Models

function identity = geomrecognize(Nummodels,Models,ModelLength)

    % start interpretation tree
    
    pairs = zeros(100,2);
    
    for i = 1 : Nummodels
      currentmodel=i
      success = itree(i,ModelLength(i),0,ModelLength(i)-1,pairs,0);
      if success
        ['Model ',int2str(i),' found in this image']
        identity = i;
        return
      end
    end
    if ~success
      ['no models recognised in this image']
    end
    identity = Nummodels+1;


        
        

