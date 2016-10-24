function val=kernel(sigma,x)
     val = (1/(sqrt(2*pi)*sigma))*exp(-(x*x)/(2*sigma*sigma));
