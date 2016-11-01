function Print_matr(M);

ss=size(M);
ni=ss(1); 
nj=ss(2);
% fprintf(name); 
% fprintf('\n');

fprintf('%4.0f ',0);
for i=1:ni
    fprintf('    %2.0f  ',i)
end
fprintf('\n');
for j=1:nj
    fprintf('%4.0f  ',j);
    for i=1:ni
        if M(i,j) ~= 0
        fprintf('%8.3f ',M(i,j));
        else
        fprintf('     %1.0f   ',M(i,j));
        end
    end
    fprintf('\n');
end
end
