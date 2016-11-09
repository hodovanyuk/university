function doMutation(PERC)
% Побудова нової популяції з використанням мутації
% Мутація здійснюється випадковим вибором та обміном двох генів
% Кількість мутацій - PERC відсотків із кількості хромосом (0<PERC<1)
% Аргументи: матриця хромосом CH (глобальна змінна)
%            PERC - відсоток кількості мутацій від кількості хромосом
% Результат: змінені матриці хромосом та фітнесу хромосом

global CH;
global CHF;

% визначаємо кількість хромосом
[m,n]=size(CH);
% визначаємо кількість мутацій
nMutations=floor(m*PERC);
% створюємо тимчасові змінні, куди копіюємо хромосоми та значення функції фітнесу
CHt=CH;
CHFt=CHF;
% виконуємо мутації
for i=1:nMutations
    % вибираємо випадковим чином хромосому
    nCH=floor(rand(1)*m)+1;
    if (nCH>m) nCH=m; end
    % вибираємо дві позиції, що треба поміняти
    firstPos=floor(rand(1)*n)+1;
    if (firstPos>n) firstPos=n; end
    secondPos=floor(rand(1)*n)+1;
    if (secondPos>n) secondPos=n; end
    % міняємо міста у вибраній хромосомі, що знаходяться у вибраних позиціях
    TEMP=CH(nCH,firstPos);
    CH(nCH,firstPos)=CH(nCH,secondPos);
    CH(nCH,secondPos)=TEMP;
    % розраховуємо значення фітнесу нової хромосоми
    CHF(nCH,1)=checkFitness(CH(nCH,:));
end
    