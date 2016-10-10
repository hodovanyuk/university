function Init;
global points con_matrix global_matrix right_part_of_system n bound_left bound_right length_of_region n_elements

length_of_region=1;
n=32;
n_elements=n-1;
global_matrix=zeros(n,n);
right_part_of_system=zeros(n,1);
bound_left=0;
bound_right=1;
Geometry;