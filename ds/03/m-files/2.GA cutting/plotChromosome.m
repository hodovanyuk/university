function plotChromosome(CH,PLATE,Fittness)
% Відображує на екрані хромосому (пластинки, отримані внаслідок побудови)
% Аргументи:
% CH       - хромосома
% PLATE    - розміри вихідної пластинки
% Fittness - значення функції фітнеса

% визначаємо кількість пластинок
[m,nPLATES]=size(CH);
nPLATES=floor(nPLATES/5);

% відкриваємо нове вікно
f=figure;
% відображуємо велику пластину
plot([0 0 PLATE(1,1) PLATE(1,1) 0],[0 PLATE(1,2) PLATE(1,2) 0 0],'k');
if PLATE(1,1)>PLATE(1,2)
    set(get(f,'Children'),'YLim',[0 PLATE(1,1)]);
else
    set(get(f,'Children'),'XLim',[0 PLATE(1,2)]);
end
set(get(get(f,'Children'),'Title'),'String',num2str(Fittness));
axis square;
hold on

% проходимо по всім пластинкам та відображуємо їх на екрані
for i=1:nPLATES
    plot([CH(1,(i-1)*5+2) CH(1,(i-1)*5+2)+CH(1,(i-1)*5+4) CH(1,(i-1)*5+2)+CH(1,(i-1)*5+4) CH(1,(i-1)*5+2) CH(1,(i-1)*5+2)],...
         [CH(1,(i-1)*5+3) CH(1,(i-1)*5+3) CH(1,(i-1)*5+3)-CH(1,(i-1)*5+5) CH(1,(i-1)*5+3)-CH(1,(i-1)*5+5) CH(1,(i-1)*5+3)],'k');
    text(floor(CH(1,(i-1)*5+2)+CH(1,(i-1)*5+4)/2),floor(CH(1,(i-1)*5+3)-CH(1,(i-1)*5+5)/2),int2str(CH(1,(i-1)*5+1)));
end