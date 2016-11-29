function Init;

Include_global;

points=[-4:1:4 -5 5];
   
con_matrix=[2 4 3;
            4 6 5; 
            6 8 7; 
            10 2 1;
            8 11 9];        
n_points=11;
n_elements=5;
n_nodes_of_el=3;

Dir_bound_points=[10 11];
Dir_bound_values=[10 20];
n_Dir_points=length(Dir_bound_points);

Neu_bound_points=[];
Neu_bound_values=[5];

Set_coordinates_of_element_in_ksi_eta;
Set_Gauss_nodes_and_weights;
for ind_Gauss=1:n_Gauss_nodes
    x0=xg(ind_Gauss);
    [fi1,dfi_dksi1]=Basis_fun(x0);
    fi_glob(ind_Gauss,:)=fi1(:);
    dfi_dksi_glob(ind_Gauss,:)=dfi_dksi1(:);
end
end
