function Set_Gauss_nodes_and_weights;

Include_global

n_Gauss_nodes=3;
Gauss_point=sqrt(0.6); 
xg(1)=-Gauss_point; weight(1)=5/9;
xg(2)= Gauss_point; weight(2)=5/9;
xg(3)= 0.0;         weight(3)=8/9; 

end