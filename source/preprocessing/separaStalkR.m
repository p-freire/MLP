%==========================================================================
% Algoritmo transforma stalk-root em que:
% Entrada: Matriz[qtde_Instâncias,1] com valores "b", "c", "u", "e", "z" e
%          "r", além disso as instâncias podem ter dados perdidos 
%          representados pelo ponto de interrogação "?"
%
% Retorno: Matriz[qtde_Instâncias,6] com valores 0's e 1's de modo que:
%     bulbous (b)       =   [1 0 0 0 0 0]
%     club (c)          =   [0 1 0 0 0 0]
%     cup (u)           =   [0 0 1 0 0 0]
%     equal (e)         =   [0 0 0 1 0 0]
%     rhizomorphs (z)   =   [0 0 0 0 1 0]
%     rooted (r)        =   [0 0 0 0 0 1]
%
%==========================================================================

function [classeM,classeMo, perdidos] = separaStalkR(mushC)
  % Gera matrizes zeradas
  MC = zeros(8124,6);
  MCo = zeros(8124,6);
  Moda = zeros(1,6);
  Media = zeros(1,6);
  
  for i=1:8124
     if (strcmp(mushC(i,1),'b') == 1)
         MC(i,1) = 1;
         MCo(i,1) = 1;
     end
     if (strcmp(mushC(i,1),'c') == 1)
         MC(i,2) = 1;
         MCo(i,2) = 1;
     end
     if (strcmp(mushC(i,1),'u') == 1)
         MC(i,3) = 1;
         MCo(i,3) = 1;
     end
     if (strcmp(mushC(i,1),'e') == 1)
         MC(i,4) = 1;
         MCo(i,4) = 1;
     end
     if (strcmp(mushC(i,1),'z') == 1)
         MC(i,5) = 1;
         MCo(i,5) = 1;
     end
     if (strcmp(mushC(i,1),'r') == 1)
         MC(i,6) = 1;
         MCo(i,6) = 1;
     end
  end
  
  % Verifica a característica que mais apareceu e calcula a média, guarda
  % os valores em um vetor
  Moda = sum(MC,1);
  Media = sum(MC,1)/8124;
  [M, Ind] = max(Moda);
  [M, In] = max(Media);
  j = 1;
  % Substitui os dados faltantes pela característica que mais apareceu e
  % pela característica que obteve a maior média
  for i=1:8124
     if (strcmp(mushC(i,1),'?') == 1)
         MC(i,In) = 1;
         MCo(i,Ind) = 1;
         qtde_perdidos(j) = i; % guarda a linha em que a inst�ncia com dado faltante est�
         j = j + 1;
     end
  end
  classeM = MC;
  classeMo = MCo;
  perdidos = qtde_perdidos;
end