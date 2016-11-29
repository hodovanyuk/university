lx =xx(2)-xx(1);
dx_dksi=lx/(ksi_all(2)-ksi_all(1));

Det_Jacob=abs(dx_dksi);

dksi_dx=1/Det_Jacob(1,:);
