function Form_global_matrix_4;
% � ���������� ������ ������� ��������, ����� 
% ���������� ����� ����� ����� �� 2, ��� ������,
% � ������� �������� ���� 1. ��� �������� ������������
% ��������� ��� ��������� ��� ������ � �������������, 
% ����������� � �.�. ����������. ������������� ������� 
% ������������ ������� � ��������� ���������.

Include_global

for ind_of_element=1:n_elements      % ������������� ��������
  for i=1:order_of_element+1
      ind_el(i)=con_matrix(i,ind_of_element);
  end
% ********* ��������� ������� �������� ****************
  Form_matrix_of_element(ind_el);  
% ********* ��������� ��������  ***********************
  for node=1:order_of_element+1;
  equ_number=ind_el(node);
  
  flag=0;   % ����, �������� ���������, �� �������?
  for ind_bound=1:n_bound             
     if equ_number==bound_nodes(ind_bound) flag=ind_bound;
     end
  end
            % �� ������
  if flag==0 

    for ind=1:order_of_element+1;  
        global_matrix(equ_number,ind_el(ind))= ...
            global_matrix(equ_number,ind_el(ind))+Matr(node,ind);
    end    
    right_part(equ_number)=right_part(equ_number)+right_part(node);

  else
          % �� �� ������� -  ���. ��������� ����
     global_matrix(equ_number,equ_number)=1;
          % � flag �������� ����� ��������� ����� 
     right_part(equ_number)=boundary_condition(flag);
  end

end
end