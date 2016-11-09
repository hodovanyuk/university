function [CH,CHF]=getChromosomes(PLATE,PLATES,ARG,ORDER)
% Вибирає ARG хромосом, що є способами розкладки пластин з порядком
% розкладки ORDER та обчислює їх функції фітнесу
% Аргументи:
% PLATE  - параметри великої пластини (довжина та ширина)
% PLATES - набір пластинок, заданий їх довжиною та шириною; останні
%          значення - параметри великої пластини
% ARG    - кількість хромосом для вибору
% ORDER  - порядок розкладки:
%                            0 - зліва-направо, згори-вниз
%                            1 - з першої встановленої пластини
%                            2 - з останньої встановленої пластини
% Результат:
% CH  - набір хромосом у глобальній змінній CH у вигляді 
%       номер пластини - X та Y верхнього лівого кута -
%       ширина - висота
% CHF - набір значень фітнесу у глобальній змінній CHF

if (nargin==1) || ((ORDER~=1) && (ORDER~=2))
    ORDER=0;
end

% отримуємо кількість пластин
[m,n]=size(PLATES);
% створюємо масив для збереження хромосом
CH=zeros(ARG,m*5);
% створюємо масив для збереження значень фітнесу хромосом
CHF=zeros(ARG,1);

% проходимо по кожній хромосомі та будуємо її
i=1;
while (i<=ARG)
    % утворюємо масив номерів пластин та встановлюємо їх кількість
    NUMBERS=1:m;
    COUNT=m;
    % випадковим чином вибираємо першу пластину
    nPlate=floor(rand(1)*COUNT)+1;
    % випадковим чином вибираємо її розміщення
    nPosition=floor(rand(1)+0.5);
    % встановлюємо першу пластину
    CH(i,1)=NUMBERS(nPlate);    % номер пластини
    if nPosition==0
        CH(i,4)=PLATES(CH(i,1),1); CH(i,5)=PLATES(CH(i,1),2);   % ширина - висота
    else
        CH(i,4)=PLATES(CH(i,1),2); CH(i,5)=PLATES(CH(i,1),1);   % висота - ширина
    end
    % викидаємо номер вибраної пластини
    if nPlate==1
        NUMBERS=NUMBERS(2:COUNT);
    elseif nPlate==COUNT
        NUMBERS=NUMBERS(1:COUNT-1);
    else
        NUMBERS=[NUMBERS(1:nPlate-1) NUMBERS(nPlate+1:COUNT)];
    end
    COUNT=COUNT-1; index=2;
    % проходимо по ще не використаним пластинам
    while (COUNT>=1)
        % випадковим чином вибираємо наступну пластину
        nPlate=floor(rand(1)*COUNT)+1;
        % випадковим чином вибираємо її розміщення
        nPosition=floor(rand(1)+0.5);
        % встановлюємо пластину
        CH(i,(index-1)*5+1)=NUMBERS(nPlate);            % номер пластини
        if nPosition==0
            CH(i,(index-1)*5+4)=PLATES(NUMBERS(nPlate),1);  % ширина - висота
            CH(i,(index-1)*5+5)=PLATES(NUMBERS(nPlate),2);
        else
            CH(i,(index-1)*5+4)=PLATES(NUMBERS(nPlate),2);  % висота - ширина
            CH(i,(index-1)*5+5)=PLATES(NUMBERS(nPlate),1);
        end            
        % викидаємо номер вибраної пластини
        if nPlate==1
            NUMBERS=NUMBERS(2:COUNT);
        elseif nPlate==COUNT
            NUMBERS=NUMBERS(1:COUNT-1);
        else
            NUMBERS=[NUMBERS(1:nPlate-1) NUMBERS(nPlate+1:COUNT)];
        end
        COUNT=COUNT-1;
        index=index+1;
    end
    % визначаємо позиції пластинок
    CH(i,:)=getPositions(CH(i,:),PLATE,ORDER);
    % якщо пластинки розміщаються на пластині - створюємо наступну
    % хромосому
    if (CH(i,1)~=0)
        % отримуємо значення функції фітнеса
        CHF(i,1)=checkFitness(CH(i,:),PLATE);
        i=i+1;
    end
end        