function Form_global_matrix_1;
% Замечаем, что обработки узлов совершенно одинаковы
% Поэтому их вполне можно оформить циклом.
% Но для этого номера узлов элемента нужно оформить в виде массива,
% а не отдельных чисел. Тогда их можно перебирать в цикле.
% Индекс также появится при выборе строки матрицы.

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
  ind_left=ind_el(1);
  ind_right=ind_el(2);
  flag=0;   % Он на границе?
  for ind_bound=1:n_bound             
     if ind_el(node)==bound_nodes(ind_bound) flag=ind_bound;
     end
  end
            % Он внутри
  if flag==0 
%   Из матрицы элемента достаем содержимое строки и правой части                                      
     coeff_left=Matr(node,1);
     coeff_right=Matr(node,2);
     rp=right_part(node);

%  Делаем добавки в строку матрицы номер equ_number,
%  в столбцы с номерами ind_left и ind_right
%  и в правую часть системы

     global_matrix(equ_number,ind_left)=global_matrix(equ_number,ind_left)+coeff_left;
     global_matrix(equ_number,ind_right)=global_matrix(equ_number,ind_right)+coeff_right;
     right_part(equ_number)=right_part(equ_number)+rp;
  else
          % Он на границе -  обр. граничный узел
     global_matrix(equ_number,equ_number)=1;
          % В flag запомнен номер граничной точки 
     right_part(equ_number)=boundary_condition(flag);
  end

end
end