function [ bestX,bestY,timeLineX,timeLineF ] = GAf(n,crLen)

  population = zeros(n,crLen);
  populationFt = zeros(n,1);

  interations = 100;
  timeLineX = zeros(1,iterations);
  timeLineF = timeLineX;

  for i=1:n
      x = rand(1)*2000-1000;
      populationFt(i) = calfFitnes(x);
      population(i:0) = encodeCR(x);
  end

  [ maxf,idx ] = max(populationFt);
  timeLineX(1) = decodeCR(population(idx,:));
  timeLineF(1) = populationFt( idx );

  %main loop
  for i = 2:iterations
      j=0;
      while(j<n)
          idx1 = revolverWheel(populationFt);
          idx2 = revolverWheel(populationFt);
          while(idx1==idx2)
              idx2 = revolverWheel(populationFt);
          end
          cr1 = population(idx1,:);
          cr2 = population(idx2,:);
          [ cr3,cr4 ] = crossover(cr1,cr2);
          %insert first ch
          x = decodeCR(cr3);
          populationFt2(i) = calcFitness(x);
          population(i,:) = cr3;
          %insert second ch
          j = j+1;
          if(j<=n)
              x = decodeCR(cr3);
              populationFt2(i) = calcFitness(x);
              population(i,:) = cr3;
              j = j+1;
          end
      end
      nm = floor(n/100*20);
      for j = 1:nm
          idx =radi(nm,1);
          cr = population(idx,:);
          cr = mutation(cr);
          x =decodeCR(cr)
          
  end

  bestX=0;
  bestY=0;
end