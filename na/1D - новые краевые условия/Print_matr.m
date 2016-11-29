function Print_matr(M,tolerance);

n_arg=nargin;
if n_arg==1, tol=0;         end
if n_arg==2, tol=tolerance; end

ss=size(M);
ni=ss(1); 
nj=ss(2);
% fprintf(name); 
% fprintf('\n');

fprintf('%3.0f ',0);
for j=1:nj
    fprintf('  %3.0f   ',j)
end
fprintf('\n');
for i=1:ni
    fprintf('%3.0f ',i);
    for j=1:nj
        tmp=M(i,j);
        if abs(tmp) < tol, tmp=0; end;
        if tmp ~= 0
        fprintf('%7.3f ',tmp);
        else
        fprintf('    %1.0f   ',tmp);
        end
    end
    fprintf('\n');
end
fprintf('\n');
end
