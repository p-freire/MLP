%==========================================================================
% Algoritmo transforma population em que:
% Entrada: Matriz[qtde_Instâncias,1] com valores "a", "c", "n", "s", "v" e "y"
%
% Retorno: Matriz[qtde_Instâncias,6] com valores 0's e 1's de modo que:
%     abundant (a)     =   [1 0 0 0 0 0]
%     clustered (c)    =   [0 1 0 0 0 0]
%     numerous (n)     =   [0 0 1 0 0 0]
%     scattered (s)    =   [0 0 0 1 0 0]
%     several (v)      =   [0 0 0 0 1 0]
%     solitary (y)     =   [0 0 0 0 0 1]
%
%==========================================================================

function classe = separaPopulation(mushC)
  MC = zeros(8124,6);
  for i=1:8124
     if (strcmp(mushC(i,1),'a') == 1)
         MC(i,1) = 1;
     end
     if (strcmp(mushC(i,1),'c') == 1)
         MC(i,2) = 1;
     end
     if (strcmp(mushC(i,1),'n') == 1)
         MC(i,3) = 1;
     end
     if (strcmp(mushC(i,1),'s') == 1)
         MC(i,4) = 1;
     end
     if (strcmp(mushC(i,1),'v') == 1)
         MC(i,5) = 1;
     end
     if (strcmp(mushC(i,1),'y') == 1)
         MC(i,6) = 1;
     end
  end
  classe = MC;
end