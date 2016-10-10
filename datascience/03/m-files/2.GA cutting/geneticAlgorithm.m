function [GAResult,GABestResult]=geneticAlgorithm(ITERATIONS,CHROMOSOMES,PERCMUTATIONS,PLATES,PLATE)
% Реалізація генетичного алгортиму
% Передається кількість ітерацій
% По виконанні операцій кросоверу та мутації вибирається найкращий фітнес і
% зберігається у окремій змінній (історія функцій фітнесу) разом із
% хромосомою, що дала найкращий фітнес; якщо таких хромосом кілька -
% вибирається перша із них
% Аргументи: ITERATIONS    - кількість ітерацій ГА
%            CHROMOSOMES   - кількість хромосом
%            PERCMUTATIONS - відсоток мутацій із кількості хромосом
%            PLATES        - матриця пластинок у вигляді рядків пар (довжина;ширина)
%            PLATE         - розміри великої пластини
% Проміжні результати зберігаються у змінних CH та CHF
% Результат: GAResult      - значення фітнесів та хромосом з найкращим
%                            фітнесом для кожної ітерації
%            GABestResult  - значення найкращого фітнесу і хромосоми, що його дала

% створюємо потрібну кількість хромосом
[CH,CHF]=getChromosomes(PLATE,PLATES,CHROMOSOMES,0);
% визначаємо кількість та довжину хромосом
[n,m]=size(PLATES);
m=CHROMOSOMES;

% створюємо змінну для зберігання результату
GAResult=zeros(ITERATIONS,n*5+1);
% визначаємо найркащий фітнес
I=find(CHF==min(CHF));
% зберігаємо значення фітнесу та відповідної хромосоми у GAResult
GAResult(1,:)=[CHF(I(1,1),1) CH(I(1,1),:)];
GABestResult=GAResult(1,:);
% виконуємо ITERATIONS-1 ітерацій ГА
for i=2:ITERATIONS
    % виконуємо кросовер
    [CH,CHF]=doCrossover(CH,CHF,PLATE);
    % виконуємо мутацію
    [CH,CHF]=doMutation(CH,CHF,PLATE,0,PERCMUTATIONS);
    % вибираємо хромосому з найкращим фітнесом та зберігаємо у масиві результату
    I=find(CHF==min(CHF));
    GAResult(i,:)=[CHF(I(1,1),1) CH(I(1,1),:)];
    % якщо отримано краще значення фітнесу - зберігаємо його
    if GAResult(i,1)<GABestResult(1,1)
        GABestResult=GAResult(i,:);
    end
end
    