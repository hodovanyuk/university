function [ timeLineX, timeLineY, timeLineF, bestX, bestY ] = GAf( n )

population = zeros( n,54 );
populationFt = zeros( n,1 );

iterations = 1000;
timeLineX = zeros( 1,iterations );
timeLineY = zeros( 1,iterations );
timeLineF = timeLineX;

% generate start population
for i = 1:n
    x(1) = rand( 1 ) * 2000 - 1000;
    x(2) = rand( 1 ) * 2000 - 1000;
    populationFt( i ) = calcFitness( x );
    population( i,: ) = encodeCR( x );
end
[ maxf,idx ] = max( populationFt );

temp = decodeCR( population( idx,: ) );
timeLineX( 1 ) = temp(1);
timeLineY( 1 ) = temp(2);
timeLineF( 1 ) = populationFt( idx );

bestX = timeLineX( 1 );
bestY = timeLineY( 1 );
bestF = timeLineF( 1 );

% main loop
for i = 2:iterations
    % build next population
    j = 1;
    population2 = zeros( n,54 );
    populationFt2 = zeros( n,1 );
    while( j < n )
        idx1 = revolverWheel( populationFt );
        idx2 = revolverWheel( populationFt );
        while( idx1 == idx2 )
            idx2 = revolverWheel( populationFt );
        end
        cr1 = population( idx1,: );
        cr2 = population( idx2,: );
        [ cr3,cr4 ] = crossover( cr1,cr2 );
        % insert first ch
        x = decodeCR( cr3 );
        populationFt2( j ) = calcFitness( x );
        population2( j,: ) = cr3;
        % insert second ch
        j = j + 1;
        if( j <= n )
            x = decodeCR( cr4 );
            populationFt2( j ) = calcFitness( x );
            population2( j,: ) = cr3;
            j = j + 1;
        end
    end
    nm = floor( n / 100 * 20 );
    for j = 1:nm
        idx = randi( nm,1 );
        cr = population2( idx,: );
        cr = mutation( cr );
        x = decodeCR( cr );
        populationFt2( idx ) = calcFitness( x );
        population2( idx,: ) = cr;
    end
    % save best values
    population = population2;
    populationFt = populationFt2;
    [ maxf,idx ] = max( populationFt );
    temp = decodeCR( population( idx,: ) );
    timeLineX( i ) = temp(1);
    timeLineY( i ) = temp(2);
    timeLineF( i ) = populationFt( idx );
    if( bestF < timeLineF( i ) )
        bestX = timeLineX( i );
        bestY = timeLineY( i );
        bestF = timeLineF( i );
    end
    
end

figure;
plot( timeLineF,'.k' );
title( 'fitness' );
figure;
plot( timeLineX,'.k' );
title( 'x' );