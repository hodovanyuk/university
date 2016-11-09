function Form_global_matrix;
global points con_matrix global_matrix right_part_of_system n bound_left bound_right length_of_region n_elements

% просматриваем все элементы
    for node_number=2:n-1
      for ind_of_element=1:n_elements
        if con_matrix(1,ind_of_element)==node_number
            ind_left=node_number;
            ind_right=con_matrix(2,ind_of_element);
            Add_to_matrix_right(node_number,ind_left,ind_right);
        end
        if con_matrix(2,ind_of_element)==node_number
            ind_right=node_number;
            ind_left=con_matrix(1,ind_of_element);
            Add_to_matrix_left(node_number,ind_left,ind_right);
        end
     end
    end


global_matrix(1,1)=1;
right_part_of_system(1)=bound_left;
global_matrix(n,n)=1;
right_part_of_system(n)=bound_right;
