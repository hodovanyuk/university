function [CH,CHF]=doCrossover(CH,CHF,PLATE)
% Побудова нової популяції з використанням кросоверу MOX
% Аргументи:
%       CH    - матриця хромосом
%       CHF   - матриця значень фітнесу хромосом
%       PLATE - розміри великої пластини
% Результат:
%       змінені матриці хромосом та фітнесу хромосом

% визначаємо кількість хромосом
[m,n]=size(CH);
% визначаємо кількість пластинок
n=floor(n/5);

i=0;                                    % кількість хромосом на даний момент
% змінюємо значення фітнеса для використання методом револьверного барабана
tempCHF=max(CHF)-CHF;

COUNT_OF_FAILS=0;
LOG=[];

while (i<m)
    % вибираємо дві хромосоми методом револьверного барабана
    sumCHF=sum(tempCHF);
    valueCHF1=floor(rand(1)*sumCHF);
    valueCHF2=floor(rand(1)*sumCHF);
    % знаходимо першу хромосому
    indexCH1=1;
    valueCH1=tempCHF(indexCH1,1);
    while (valueCHF1>valueCH1) indexCH1=indexCH1+1; valueCH1=valueCH1+tempCHF(indexCH1,1); end
    firstCH=CH(indexCH1,:);
    % знаходимо другу хромосому
    indexCH2=1;
    valueCH2=tempCHF(indexCH2,1);
    while (valueCHF2>valueCH2) indexCH2=indexCH2+1; valueCH2=valueCH2+tempCHF(indexCH2,1); end
    secondCH=CH(indexCH2,:);
    % вибираємо точку кросоверу
    crossoverPoint=floor(rand(1)*n)+1;
    
%    DISP=['index1: ' num2str(indexCH1) '; index2: ' num2str(indexCH2) '; CPoint: ' num2str(crossoverPoint)];
%    disp(DISP)
   
    % записуємо частину першої хромосоми
    i=i+1;
    newCH1=firstCH(1,1:crossoverPoint*5);
    
    % перевпорядковуємо другу частину хромосоми
    for index=1:n
        if ~isempty(find(secondCH(1,(index-1)*5+1)==firstCH(1,crossoverPoint*5+1:5:n*5)))
            newCH1=[newCH1 secondCH(1,(index-1)*5+1:index*5)];
        end
    end
    if i==1
        CHTEMP=newCH1;
    else
        CHTEMP=[CHTEMP; newCH1];
    end
    
    % записуємо частину другої хромосоми
    i=i+1;
    newCH2=secondCH(1,1:crossoverPoint*5);
    
    % перевпорядковуємо другу частину хромосоми
    for index=1:n
        if ~isempty(find(firstCH(1,(index-1)*5+1)==secondCH(1,crossoverPoint*5+1:5:n*5)))
            newCH2=[newCH2 firstCH(1,(index-1)*5+1:index*5)];
        end
    end
    CHTEMP=[CHTEMP; newCH2];
    
    % розкладаємо пластинки
    CHTEMP(i-1,:)=getPositions(CHTEMP(i-1,:),PLATE);
    CHTEMP(i,:)=getPositions(CHTEMP(i,:),PLATE);
    % якщо пластинки не розкладаються - відкидаємо хромосоми
    if (CHTEMP(i,1)==0) || (CHTEMP(i-1,1)==0)
        i=i-2;
        LOG=[LOG; [indexCH1 firstCH indexCH2 secondCH crossoverPoint newCH1 newCH2]];
%        disp('Not correct');
        COUNT_OF_FAILS=COUNT_OF_FAILS+1;
        if (COUNT_OF_FAILS>100)
            save 'LOGFILE.txt' LOG -ASCII;
            return;
        end
    end
end

CHTEMP=CHTEMP(1:m,:);

% розраховуємо фітнес нових хромосом
CHFTEMP=zeros(m,1);
for i=1:m
    CHFTEMP(i,1)=checkFitness(CHTEMP(i,:),PLATE);
end
% записуємо отримані значення замість старих
CH=CHTEMP;
CHF=CHFTEMP;