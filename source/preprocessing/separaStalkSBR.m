
%==========================================================================
% Algoritmo transforma stalk-surface-below-ring em que:
% Entrada: Matriz[qtde_Instâncias,1] com valores "f", "y", "k" e "s"
%
% Retorno: Matriz[qtde_Instâncias,4] com valores 0's e 1's de modo que:
%     fibrous(f)    =   [1 0 0 0]
%     scaly (y)     =   [0 1 0 0]
%     silky (k)     =   [0 0 1 0]
%     smooth (s)    =   [0 0 0 1]
%
%==========================================================================

function classe = separaStalkSBR(mushC)
  MC = zeros(8124,4);
  for i=1:8124
     if (strcmp(mushC(i,1),'f') == 1)
         MC(i,1) = 1;
     end
     if (strcmp(mushC(i,1),'y') == 1)
         MC(i,2) = 1;
     end
     if (strcmp(mushC(i,1),'k') == 1)
         MC(i,3) = 1;
     end
     if (strcmp(mushC(i,1),'s') == 1)
         MC(i,4) = 1;
     end
  end
  classe = MC;
end