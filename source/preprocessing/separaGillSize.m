%==========================================================================
% Algoritmo transforma gill-size em que:
% Entrada: Matriz[qtde_Instâncias,1] com valores "b" e "n"
%
% Retorno: Matriz[qtde_Instâncias,2] com valores 0's e 1's de modo que:
%     broad (b)     =   [1 0]
%     narrow (n)    =   [0 1]
%
%==========================================================================

function classe = separaGillSize(mushC)
  MC = zeros(8124,2);
  for i=1:8124
     if (strcmp(mushC(i,1),'b') == 1)
         MC(i,1) = 1;
     end
     if (strcmp(mushC(i,1),'n') == 1)
         MC(i,2) = 1;
     end
  end
  classe = MC;
end