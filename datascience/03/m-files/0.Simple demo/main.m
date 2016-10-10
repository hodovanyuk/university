function main(m)

[X,F]=create_population(m);
globalX = [X(1)];
globalF = [F(1)];
for iteration=1:1000
    xnew=zeros(m,1);
    fnew=xnew;
    for i=1:m
        [X1,F1]=getchromosome(X,F);
        [X2,F2]=getchromosome(X,F);
        [X3,X4]=crossover(X1,X2);
        F3=-X3^2-6*X3+24;
        F4=-X4^2-6*X4+24;
        if(F3>F4)
            xnew(i)=X3;
            fnew(i)=F3;
        else
            xnew(i)=X4;
            fnew(i)=F4;
        end
    end
    i=floor(rand*(m-1)+1);
    X1=mutation(xnew(i));
    F1=-X1^2-6*X1+24;
    xnew(i)=X1;
    fnew(i)=F1;
    X=xnew;
    F=fnew;
    [t,idx]=max(F);
    globalX = [globalX X(idx)];
    globalF = [globalF F(idx)];
    disp(iteration)
end
plot(globalX)
figure
plot(globalF)
