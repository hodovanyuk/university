function doCrossover
% Побудова нової популяції з використанням кросоверу MOX
% Аргументи: матриця хромосом CH (глобальна змінна)
%            матриця значень фітнесу хромосом CHF (глобальна змінна)
% Результат: змінені матриці хромосом та фітнесу хромосом

global CH;
global CHF;

% визначаємо кількість хромосом
[m,n]=size(CH);

i=0;                                    % кількість хромосом на даний момент
while (i<m)
    % вибираємо дві хромосоми методом револьверного барабана
    minF=min(CHF);
    tempCHF=CHF-minF+floor(minF*0.05);
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
    % записуємо частину першої хромосоми
    i=i+1;
    newCH1=firstCH(1,1:crossoverPoint);
    % перевпорядковуємо другу частину хромосоми
    for index=1:n
        if ~isempty(find(firstCH(1,crossoverPoint+1:n)==secondCH(1,index)))
            newCH1=[newCH1 secondCH(1,index)];
        end
    end
    if i==1
        CHTEMP=newCH1;
    else
        CHTEMP=[CHTEMP; newCH1];
    end
    % записуємо частину другої хромосоми
    i=i+1;
    newCH2=secondCH(1,1:crossoverPoint);
    % перевпорядковуємо другу частину хромосоми
    for index=1:n
        if ~isempty(find(secondCH(1,crossoverPoint+1:n)==firstCH(1,index)))
            newCH2=[newCH2 firstCH(1,index)];
        end
    end
    if i<=m
        CHTEMP=[CHTEMP; newCH2];
    end
end
% розраховуємо фітнес нових хромосом
CHFTEMP=zeros(m,1);
for i=1:m
    CHFTEMP(i,1)=checkFitness(CHTEMP(i,:));
end
% записуємо отримані значення замість старих
CH=CHTEMP;
CHF=CHFTEMP;