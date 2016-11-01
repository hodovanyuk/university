function Init;

Include_global

%  Уравнение задаем в виде
%  c2*d2ydx2+c1*dydx+c0*y=d

c2=3;
c1=-2;
c0=1;
d=1;

length_of_region=1;
n_nodes=32;
n_elements=n_nodes-1;
order_of_element=1;
global_matrix=zeros(n_nodes,n_nodes);
right_part=zeros(n_nodes,1);
n_bound=2;
bound_nodes=[1 n_nodes];
boundary_condition=[0 1];
Geometry;
end