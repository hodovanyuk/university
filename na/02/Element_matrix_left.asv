function [c_left,c_right,rp]=Element_matrix_left(ind_left,ind_right);
global points con_matrix global_matrix right_part_of_system n bound_left bound_right length_of_region 

h=points(ind_right)-points(ind_left);

c_left=1/h;
c_right=-1/h;

rp=h/3*function_right(points(ind_left))+h/6*function_right(points(ind_right));
