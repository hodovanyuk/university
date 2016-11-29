  function [fi,dfi_dksi]=Basis_fun(ksi);

% Находим компоненты базисных функций - многочленов Лагранжа
fi_ksi_min=0.5*(ksi-1)*ksi; fi_ksi_0=(1-ksi)*(1+ksi);  fi_ksi_pls=0.5*(1+ksi)*ksi;  
dfi_ksi_min_dksi=ksi-0.5;   dfi_ksi_0_dksi=-2*ksi;     dfi_ksi_pls_dksi=0.5+ksi;

fi(1)=fi_ksi_min;
fi(2)=fi_ksi_pls;
fi(3)=fi_ksi_0;
%******************************************
dfi_dksi(1)=dfi_ksi_min_dksi;
dfi_dksi(2)=dfi_ksi_pls_dksi;
dfi_dksi(3)=dfi_ksi_0_dksi;
end 