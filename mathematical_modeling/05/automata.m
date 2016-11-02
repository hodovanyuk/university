% клеточный автомат "Жизнь"
clear all
clc
n = 64;

% инициализация масивов
z = zeros(n,n);
cells = z; 
sum = z;    

% задаем начальную конфигурацию
cells(n/2,.25*n:.75*n) = 1;
cells(.25*n:.75*n,n/2) =1 ;

%cells = (rand(n,n))<.5;

% создаем картинку
% cat - объеденяет масив
imh = image(cat(3,z,cells,z));
set(imh,'erasemode', 'none');
axis equal
axis tight

% pause;
% задаем индексы внутрених точек
x= 2:n-1;
y= 2:n-1;


% проверяем правило
for i=1:3000
    sum(x,y) = cells(x, y-1)  +cells(x,y+1)+...
               cells(x-1, y)  +cells(x+1,y)+...
               cells(x-1, y-1)+cells(x-1,y+1)+...
               cells(x+1,y-1)+cells(x+1,y+1);
           
    cells = (sum==3)|(sum==2 & cells);
    set(imh,'cdata',cat(3,z,cells,z))
    drawnow
    pause(0.2);
end
