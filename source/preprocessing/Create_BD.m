
%==========================================================================
% Algoritmo separa cada característica das instâncias e converte os valores
% categóricos para numéricos
%(https://www.quora.com/How-can-I-convert-a-nominal-value-to-a-numeric-value)

% Informações dos atributos
% classes: edible=e, poisonous=p
% 1. cap-shape: bell=b,conical=c,convex=x,flat=f, knobbed=k,sunken=s 
% 2. cap-surface: fibrous=f,grooves=g,scaly=y,smooth=s
% 3. cap-color: brown=n,buff=b,cinnamon=c,gray=g,green=r, pink=p,purple=u,red=e,white=w,yellow=y 
% 4. bruises?: bruises=t,no=f 
% 5. odor: almond=a,anise=l,creosote=c,fishy=y,foul=f, musty=m,none=n,pungent=p,spicy=s 
% 6. gill-attachment: attached=a,descending=d,free=f,notched=n 
% 7. gill-spacing: close=c,crowded=w,distant=d 
% 8. gill-size: broad=b,narrow=n 
% 9. gill-color: black=k,brown=n,buff=b,chocolate=h,gray=g, green=r,orange=o,pink=p,purple=u,red=e, white=w,yellow=y 
% 10. stalk-shape: enlarging=e,tapering=t 
% 11. stalk-root: bulbous=b,club=c,cup=u,equal=e, rhizomorphs=z,rooted=r,missing=? 
% 12. stalk-surface-above-ring: fibrous=f,scaly=y,silky=k,smooth=s 
% 13. stalk-surface-below-ring: fibrous=f,scaly=y,silky=k,smooth=s 
% 14. stalk-color-above-ring: brown=n,buff=b,cinnamon=c,gray=g,orange=o, pink=p,red=e,white=w,yellow=y 
% 15. stalk-color-below-ring: brown=n,buff=b,cinnamon=c,gray=g,orange=o, pink=p,red=e,white=w,yellow=y 
% 16. veil-type: partial=p,universal=u 
% 17. veil-color: brown=n,orange=o,white=w,yellow=y 
% 18. ring-number: none=n,one=o,two=t 
% 19. ring-type: cobwebby=c,evanescent=e,flaring=f,large=l, none=n,pendant=p,sheathing=s,zone=z 
% 20. spore-print-color: black=k,brown=n,buff=b,chocolate=h,green=r, orange=o,purple=u,white=w,yellow=y 
% 21. population: abundant=a,clustered=c,numerous=n, scattered=s,several=v,solitary=y 
% 22. habitat: grasses=g,leaves=l,meadows=m,paths=p, urban=u,waste=w,woods=d
%==========================================================================

clear
clc
close all

% Abre os arquivos com os dados das imagens
mushroom = 'mushroom.xlsx';
[N,LinesFile] = xlsread(mushroom);

Class = separaC(LinesFile(1:end,1));
Car1 = separaCapS(LinesFile(1:end,2));                          % Característica cap-shape
Car2 = separaCapSU(LinesFile(1:end,3));                         % Característica cap-surface
Car3 = separaCapCo(LinesFile(1:end,4));                         % Característica cap-color
Car4 = separaB(LinesFile(1:end,5));                             % Característica bruises
Car5 = separaOdor(LinesFile(1:end,6));                          % Característica odor
Car6 = separaGillA(LinesFile(1:end,7));                         % Característica gill-attachment
Car7 = separaGillS(LinesFile(1:end,8));                         % Característica gill-spacing
Car8 = separaGillSize(LinesFile(1:end,9));                      % Característica gill-size
Car9 = separaGillCo(LinesFile(1:end,10));                       % Característica gill-color
Car10 = separaStalkS(LinesFile(1:end,11));                      % Característica stalk-shape
[Car11,Car111,faltantes] = separaStalkR(LinesFile(1:end,12));   % Característica stalk-root, em que Car11 = Media e Car111 = Moda
Car12 = separaStalkSAR(LinesFile(1:end,13));                    % Característica stalk-surface-above-ring 
Car13 = separaStalkSBR(LinesFile(1:end,14));                    % Característica stalk-surface-below-ring
Car14 = separaStalkCAR(LinesFile(1:end,15));                    % Característica stalk-color-above-ring
Car15 = separaStalkCBR(LinesFile(1:end,16));                    % Característica stalk-color-below-ring
Car16 = separaVeilTp(LinesFile(1:end,17));                      % Característica veil-type
Car17 = separaVeilCor(LinesFile(1:end,18));                     % Característica veil-colo
Car18 = separaRingNum(LinesFile(1:end,19));                     % Característica ring-number
Car19 = separaRingTP(LinesFile(1:end,20));                      % Característica ring-type
Car20 = separaSporePCor(LinesFile(1:end,21));                   % Característica spore-print-color
Car21 = separaPopulation(LinesFile(1:end,22));                  % Característica population
Car22 = separaHabitat(LinesFile(1:end,23));                     % Característica habitat

%Gera e grava a base de dados com as caracteristicas ja convertidas
%MediaB = [Car1 Car2 Car3 Car4 Car5 Car6 Car7 Car8 Car9 Car10 Car11 Car12 Car13 Car14 Car15 Car16 Car17 Car18 Car19 Car20 Car21 Car22 Class];
Moda = [Car1 Car2 Car3 Car4 Car5 Car6 Car7 Car8 Car9 Car10 Car111 Car12 Car13 Car14 Car15 Car16 Car17 Car18 Car19 Car20 Car21 Car22 Class];
Media = mean(Moda);
Desvio = std(Moda);

%Normalização dos dados
for i=1:125
    %Caso desvio padrão da característica seja zero, força a ser 1
    if (Desvio(i) == 0)
        Desvio(i) = 1;
    end
    Moda(:,i) = (Moda(:,i)-Media(i)) / Desvio(i);
end

% Gera vetor com a posição aleatória das instâncias 
len = size(Moda,1);
perma = randperm(len);
tam = floor(len/10); % Defini a quantidade das instâncias para teste, no caso 10% da base

%Gera arquivos para validação-cruzada (10-fold)
for g=1:10
    % Gera vetor logico para selecionar as instâncias de teste e treino
    iniC = ((g * tam) - tam) + 1;
    fimC = g * tam;
    
    %Defini conjunto de treino
    IndT = ones(len,1);
    IndT(iniC:fimC) = 0;
    IndT = logical(IndT);

    % Separa o conjunto em treino e teste
    Moda_teste = Moda(perma(iniC:fimC),:);
    Moda_treino = Moda(perma(IndT),:);

    dlmwrite(sprintf('mushroom_teste_moda_%i.txt',g), Moda_teste, ' ')
    dlmwrite(sprintf('mushroom_treino_moda_%i.txt',g), Moda_treino, ' ')
end
