function LENGTH=checkFitness(CH,PLATE)
% Визначення фітнесу хромосоми CH
% Аргументи:
%       CH  - хромосома
%       PLATE - розміри великої пластини
% Результат:
%       LENGTH - значення функції фітнесу

% визначаємо кількість пластинок
[m,PLATES]=size(CH);
PLATES=floor(PLATES/5);

% утворюємо усі можливі лінії розрізу - межі пластинок
% всього ліній - PLATES*4
LINES=zeros(PLATES*4,4);
% записуємо усі лінії розрізу
for i=1:PLATES
    LINES((i-1)*4+1,:)=[CH(1,(i-1)*5+2) CH(1,(i-1)*5+3) CH(1,(i-1)*5+2)+CH(1,(i-1)*5+4) CH(1,(i-1)*5+3)];
    LINES((i-1)*4+2,:)=[CH(1,(i-1)*5+2) CH(1,(i-1)*5+3) CH(1,(i-1)*5+2) CH(1,(i-1)*5+3)-CH(1,(i-1)*5+5)];
    LINES((i-1)*4+3,:)=[CH(1,(i-1)*5+2)+CH(1,(i-1)*5+4) CH(1,(i-1)*5+3) CH(1,(i-1)*5+2)+CH(1,(i-1)*5+4) CH(1,(i-1)*5+3)-CH(1,(i-1)*5+5)];
    LINES((i-1)*4+4,:)=[CH(1,(i-1)*5+2) CH(1,(i-1)*5+3)-CH(1,(i-1)*5+5) CH(1,(i-1)*5+2)+CH(1,(i-1)*5+4) CH(1,(i-1)*5+3)-CH(1,(i-1)*5+5)];
end

% проходимо по всім лініям і викидаємо ті, що знаходяться на границі пластини
i=1;
COUNT=PLATES*4;
while (i<=COUNT)
    if ((LINES(i,1)==0) && (LINES(i,3)==0)) || ((LINES(i,1)==PLATE(1,1)) && (LINES(i,3)==PLATE(1,1))) || ...
        ((LINES(i,2)==0) && (LINES(i,4)==0)) || ((LINES(i,2)==PLATE(1,2)) && (LINES(i,4)==PLATE(1,2)))
        LINES=[LINES(1:i-1,:); LINES(i+1:COUNT,:)];
        COUNT=COUNT-1;
    else
        i=i+1;
    end
end

% обробляємо ті лінії, що залишились, зводячи їх до кількох
i=1;
while (i<COUNT)
    j=i+1;
    while (j<=COUNT)
        % якщо дві лінії мають однакові абсциси і накладаються одна на іншу
        if (LINES(i,1)==LINES(i,3)) && (LINES(j,1)==LINES(j,3)) && (LINES(i,1)==LINES(j,1)) && ...
           (((LINES(j,2)<=LINES(i,2)) && (LINES(j,2)>=LINES(i,4))) || ...
           ((LINES(i,2)<=LINES(j,2)) && (LINES(i,2)>=LINES(j,4))))
            % беремо більше з першої координати та менше з другої
            MAX=max(LINES(i,2),LINES(j,2));
            MIN=min(LINES(i,4),LINES(j,4));
            % записуємо як координати першої лінії
            LINES(i,2)=MAX; LINES(i,4)=MIN;
            % викидаємо другу лінію
            LINES=[LINES(1:j-1,:); LINES(j+1:COUNT,:)];
            % кількість ліній на 1 менша
            COUNT=COUNT-1;
        % інакше якщо дві лінії мають однакові ординати і накладаються одна на іншу
        elseif (LINES(i,2)==LINES(i,4)) && (LINES(j,2)==LINES(j,4)) && (LINES(i,2)==LINES(j,4)) && ...
               (((LINES(j,1)<=LINES(i,3)) && (LINES(j,1)>=LINES(i,1))) || ...
               ((LINES(i,1)<=LINES(j,3)) && (LINES(i,1)>=LINES(j,1))))
            % беремо більше з першої координати та менше з другої
            MAX=max(LINES(i,3),LINES(j,3));
            MIN=min(LINES(i,1),LINES(j,1));
            % записуємо як координати першої лінії
            LINES(i,3)=MAX; LINES(i,1)=MIN;
            % викидаємо другу лінію
            LINES=[LINES(1:j-1,:); LINES(j+1:COUNT,:)];
            % кількість ліній на 1 менша
            COUNT=COUNT-1;
        else
            % переходимо до наступної лінії
            j=j+1;
        end
    end
    i=i+1;
end
            
% обраховуємо довжини тих ліній, що залишились
LENGTH=0;
for i=1:COUNT
    % якщо абсциси співпадають - обраховуємо довжину по OY
    if LINES(i,1)==LINES(i,3)
        LENGTH=LENGTH+LINES(i,2)-LINES(i,4);
    else
        LENGTH=LENGTH+LINES(i,3)-LINES(i,1);
    end
end