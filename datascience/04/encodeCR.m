function CR = encodeCR(x,nd,nfl)
    CR = zeros(1,(1+nd+nfl));
    if(x>=0),CR(1) = 1; end
    xInteger = floor(x);
    xFractional = x - xInteger;
    
    for i=nd+1:-1:2
        CR(i) = mod( xInteger,2 );
        xInteger = bitsheft( xInteger,-1 );
    end
    
    
end