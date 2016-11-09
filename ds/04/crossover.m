function [ cr3,cr4 ] = crossover( cr1,cr2 )
    %one point crossover
    n = length( cr1 );
    r =  randi(n-2,1) + 1;
    cr3 = [cr1(1:r) cr2(r+1:n)];
    cr4 = [cr2(1:r) cr1(r+1:n)];
end