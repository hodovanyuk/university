function Add_to_matrix_left(node_number,ind_left,ind_right);
global points con_matrix global_matrix right_part_of_system n bound_left bound_right length_of_region n

[coeff_left,coeff_right,rp]=Element_matrix_left(ind_left,ind_right);

global_matrix(node_number,ind_left)=global_matrix(node_number,ind_left)+coeff_left;
global_matrix(node_number,ind_right)=global_matrix(node_number,ind_right)+coeff_right;

right_part_of_system(node_number)=right_part_of_system(node_number)+rp;