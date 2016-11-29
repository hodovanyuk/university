
global dimension
%------  Сетка --------------------------------
global points n_points               % Точки
global bound_points                  % Граничные точки
global n_bound_points                % К-во граничных точек
% ------ Краевые условия ---------------------
global n_Dir_points
global Dir_bound_points              % Граничные точки Дирихле
global Dir_bound_values              % Значения граничных условий
global Neu_bound_points              % Граничные точки Неймана
global Neu_bound_values              % Значения граничных условий
%------ Матрица связи -------------------------
global con_matrix n_elements         % Матрица связи
%----- Описание элемента первого типа ----------------
global n_nodes_of_el                 % Всего узлов
% ------ Координаты узлов эл-та в выч. плоскости ---
global ksi_all eta_all
% ------ Базисные функции и их производные в выч. плоскости ---
global fi_glob dfi_dksi_glob dfi_deta_glob
% ------ Узлы и веса Гаусса ------------------
global n_Gauss_nodes xg yg weight xgb ygb weightb

global lx_low lx_high lx_left lx_right
global ly_low ly_high ly_left ly_right
% Пуассон - матрицы и параметры
global Matr Right
%% Собственно решение
global Sol
