%==========================================================================
% Algoritmo transforma veil-color em que:
% Entrada: Matriz[qtde_Instâncias,1] com valores "n", "o", "w" e "y"
%
% Retorno: Matriz[qtde_Instâncias,4] com valores 0's e 1's de modo que:
%     brown (n)    =   [1 0 0 0]
%     orange(o)    =   [0 1 0 0]
%     white (w)    =   [0 0 1 0]
%     yellow (y)   =   [0 0 0 1]
%
%==========================================================================

function classe = separaVeilCor(mushC)
  MC = zeros(8124,4);
  for i=1:8124
     if (strcmp(mushC(i,1),'n') == 1)
         MC(i,1) = 1;
     end
     if (strcmp(mushC(i,1),'o') == 1)
         MC(i,2) = 1;
     end
     if (strcmp(mushC(i,1),'w') == 1)
         MC(i,3) = 1;
     end
     if (strcmp(mushC(i,1),'y') == 1)
         MC(i,4) = 1;
     end
  end
  classe = MC;
end