function Form_global_matrix;

Include_global

for ind_of_element=1:n_elements      % Просматриваем элементы
                                     % Выбираем узлы элемента
  ind_left =con_matrix(1,ind_of_element);
  ind_right=con_matrix(2,ind_of_element);
  
% ********* Формируем матрицу элемента ****************
  h=points(ind_right)-points(ind_left);

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
  
% ********* Обработка левого узла  ********************
  
  equ_number=ind_left;
  flag=0;   % Он на границе?
  for ind_bound=1:n_bound             
     if ind_left==bound_nodes(ind_bound) flag=ind_bound;
     end
  end
            % Он внутри - случай "элемент справа"
  if flag==0 
%   Из матрицы элемента достаем содержимое строки и правой части                                      
     coeff_left=Matr(1,1);
     coeff_right=Matr(1,2);
     rp=right_part(1);

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
  
 % ********* Обработка правого узла  ********************

  equ_number=ind_right;
  flag=0;   % Он на границе?           
  for ind_bound=1:n_bound             
     if ind_right==bound_nodes(ind_bound) flag=ind_bound;
     end
  end
            % Он внутри - обр. случай "элемент слева"
            % Он внутри - случай "элемент справа"
  if flag==0 
%   Из матрицы элемента достаем содержимое строки и правой части                                      
     coeff_left=Matr(2,1);
     coeff_right=Matr(2,2);
     rp=right_part(2);

%  Делаем добавки в строку матрицы номер уйг_number,
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