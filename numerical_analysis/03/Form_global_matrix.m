function Form_global_matrix;

Include_global

for ind_of_element=1:n_elements      % ������������� ��������
                                     % �������� ���� ��������
  ind_left =con_matrix(1,ind_of_element);
  ind_right=con_matrix(2,ind_of_element);
  
% ********* ��������� ������� �������� ****************
  h=points(ind_right)-points(ind_left);

  M2=[-1/h  1/h;      %  �������  ��� 2-�  �����������              
       1/h -1/h];

  M1=[-0.5 0.5;       %  �������  ��� 1-�  �����������             
     -0.5 0.5];

  M0=[h/3 h/6;        %  �������  ��� ��������� �����
      h/6 h/3];
                      %  ��������� ���� ������ � ����
                      %  c2*d2ydx2+c1*dydx+c0*y=d
  Matr=c2*M2+c1*M1+c0*M0; 
  rp=[d*h/2; d*h/2];
  
% ********* ��������� ������ ����  ********************
  
  equ_number=ind_left;
  flag=0;   % �� �� �������?
  for ind_bound=1:n_bound             
     if ind_left==bound_nodes(ind_bound) flag=ind_bound;
     end
  end
            % �� ������ - ������ "������� ������"
  if flag==0 
%   �� ������� �������� ������� ���������� ������ � ������ �����                                      
     coeff_left=Matr(1,1);
     coeff_right=Matr(1,2);
     rp=right_part(1);

%  ������ ������� � ������ ������� ����� equ_number,
%  � ������� � �������� ind_left � ind_right
%  � � ������ ����� �������

     global_matrix(equ_number,ind_left)=global_matrix(equ_number,ind_left)+coeff_left;
     global_matrix(equ_number,ind_right)=global_matrix(equ_number,ind_right)+coeff_right;
     right_part(equ_number)=right_part(equ_number)+rp;
  else
            % �� �� ������� -  ���. ��������� ����
     global_matrix(equ_number,equ_number)=1;
            % � flag �������� ����� ��������� ����� 
     right_part(equ_number)=boundary_condition(flag);
  end
  
 % ********* ��������� ������� ����  ********************

  equ_number=ind_right;
  flag=0;   % �� �� �������?           
  for ind_bound=1:n_bound             
     if ind_right==bound_nodes(ind_bound) flag=ind_bound;
     end
  end
            % �� ������ - ���. ������ "������� �����"
            % �� ������ - ������ "������� ������"
  if flag==0 
%   �� ������� �������� ������� ���������� ������ � ������ �����                                      
     coeff_left=Matr(2,1);
     coeff_right=Matr(2,2);
     rp=right_part(2);

%  ������ ������� � ������ ������� ����� ���_number,
%  � ������� � �������� ind_left � ind_right
%  � � ������ ����� �������

     global_matrix(equ_number,ind_left)=global_matrix(equ_number,ind_left)+coeff_left;
     global_matrix(equ_number,ind_right)=global_matrix(equ_number,ind_right)+coeff_right;
     right_part(equ_number)=right_part(equ_number)+rp;
  else
            % �� �� ������� -  ���. ��������� ����
     global_matrix(equ_number,equ_number)=1;
            % � flag �������� ����� ��������� ����� 
     right_part(equ_number)=boundary_condition(flag);
  end
end
end