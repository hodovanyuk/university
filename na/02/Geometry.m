function Geometry;
global points con_matrix global_matrix right_part_of_system n bound_left bound_right length_of_region n

h=length_of_region/(n-1);

for i=0:n-1
    points(i+1)=i*h;
end

for i=1:n-1
    con_matrix(1,i)=i;
    con_matrix(2,i)=i+1;
end