function Solution_of_system;
global points con_matrix global_matrix right_part_of_system n bound_left bound_right length_of_region n solution

solution=inv(global_matrix)*right_part_of_system;
for i=1:n
    z(i)=1/6*(points(i)^3+5*points(i));
end
plot(points,solution,'r',points,z,'b')