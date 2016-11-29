% ********* Формируем матрицу элемента ****************    
xx=points(ind_el);
        
function_Right_script;   % Вектор правых частей
Find_Det_Jacob_and_derivatives_script; 

M2x=zeros(1);
M0 =zeros(1);
for ind_Gauss=1:n_Gauss_nodes
    JW=Det_Jacob*weight(ind_Gauss);
    dfi_dx(1,:)=dfi_dksi_glob(ind_Gauss,:)*dksi_dx;
    M2x=M2x+dfi_dx'*dfi_dx*JW;
    M0 =M0+fi_glob(ind_Gauss,:)'*fi_glob(ind_Gauss,:)*JW;
end
M_el=-M2x;
Rp_el=M0*Rp;   % Умножаем на матрицу аппроксимации лин. членов