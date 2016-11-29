function Form_matrix_Diff

Include_global;

Matr =sparse(n_points,n_points);
Right=sparse(n_points,1);

for ind_of_element=1:n_elements
    ind_el=con_matrix(ind_of_element,:);
    Form_matrix_of_element_script 
%***********************************************************
    M_el=sparse(M_el);
    for node=1:n_nodes_of_el;
        equ_number=ind_el(node);
        Matr(equ_number,ind_el(1,:))= ...
            Matr(equ_number,ind_el(1,:))+M_el(node,:);
        Right(equ_number,1)=Right(equ_number,1)+Rp_el(node);
    end
end

zero_row=sparse(1,n_points);
for i=1:n_Dir_points
    Matr(Dir_bound_points(i),:)=zero_row(:);
    Matr(Dir_bound_points(i),Dir_bound_points(i))=1;
end
Right(Dir_bound_points(:))=Dir_bound_values(:);

if isempty(Neu_bound_points)==0
   Right(Neu_bound_points)=Right(Neu_bound_points)-Neu_bound_values;
end


%***************************************************************
end