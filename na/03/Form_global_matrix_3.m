function Form_global_matrix_3;
% Теперь заполнение столбцов глобальной матрицы
% тоже можно оформить циклом. Одновременно отпадает
% необходимость отдельно запоминать номера левого и
% правого узлов

Include_global

for ind_of_element=1:n_elements      % Просматриваем элементы
    
                                     % Выбираем узлы элемента
ind_el(1)=con_matrix(1,ind_of_element);
ind_el(2)=con_matrix(2,ind_of_element);
  
% ********* Формируем матрицу элемента ****************
  h=points(ind_el(2))-points(ind_el(1));

  M2=[-1/h  1/h;      %  Матрица  для 2-й  производной              
       1/h -1/h];

  M1=[-0.5 0.5;       %  Матрица  для 1-й  производной             
     -0.5 0.5];

  M0=[h/3 h/6;        %  Матрица  для линейного члена
      h/6 h/3];
                      %  Уравнение было задано в виде
                      %  c2*d2ydx2+c1*dydx+c0*y=d
  Matr=c2*M2+c1*M1+c0*M0; 
  rp=[d*h/2; d*h/2];
  
% ********* Обработка элемента  ***********************
  for node=1:2
  equ_number=ind_el(node);
  
  flag=0;   % Он на границе?
  for ind_bound=1:n_bound             
     if equ_number==bound_nodes(ind_bound) flag=ind_bound;
     end
  end
            % Он внутри
  if flag==0 
%*******************   Было  *****************
%     global_matrix(equ_number,ind_el(1))=global_matrix(equ_number,ind_el(1))+Matr(node,1);
%     global_matrix(equ_number,ind_el(2))=global_matrix(equ_number,ind_el(2))+Matr(node,2);

    for ind=1:2  
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