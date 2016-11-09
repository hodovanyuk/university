function Form_global_matrix_4;
% В заключение введем порядок элемента, тогда 
% количество узлов будет равно не 2, как сейчас,
% а порядок элемента плюс 1. Это позволит использовать
% процедуру без изменений при работе с квадратичными, 
% кубическими и т.д. элементами. Дополнительно выделим 
% формирование матрицы в отдельную процедуру.

Include_global

for ind_of_element=1:n_elements      % Просматриваем элементы
  for i=1:order_of_element+1
      ind_el(i)=con_matrix(i,ind_of_element);
  end
% ********* Формируем матрицу элемента ****************
  Form_matrix_of_element(ind_el);  
% ********* Обработка элемента  ***********************
  for node=1:order_of_element+1;
  equ_number=ind_el(node);
  
  flag=0;   % Узел, задающий уравнение, на границе?
  for ind_bound=1:n_bound             
     if equ_number==bound_nodes(ind_bound) flag=ind_bound;
     end
  end
            % Он внутри
  if flag==0 

    for ind=1:order_of_element+1;  
        global_matrix(equ_number,ind_el(ind))= ...
            global_matrix(equ_number,ind_el(ind))+Matr(node,ind);
    end    
    right_part(equ_number)=right_part(equ_number)+right_part(node);

  else
          % Он на границе -  обр. граничный узел
     global_matrix(equ_number,equ_number)=1;
          % В flag запомнен номер граничной точки 
     right_part(equ_number)=boundary_condition(flag);
  end

end
end