function Geometry;

Include_global

h=length_of_region/(n_nodes-1);

for i=0:n_nodes-1
    points(i+1)=i*h;
end

for i=1:n_nodes-1
    con_matrix(1,i)=i;
    con_matrix(2,i)=i+1;
end
end