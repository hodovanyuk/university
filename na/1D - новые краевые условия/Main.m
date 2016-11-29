
clc
clear all

Include_global

flag_print=0;
Init;

Form_matrix_Diff;
Solve;

hold on
xs=points;
plot(xs,Sol,'*');
grid on