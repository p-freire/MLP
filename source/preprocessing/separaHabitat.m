%==========================================================================
% Algoritmo transforma habitat em que:
% Entrada: Matriz[qtde_Instâncias,1] com valores "g", "l", "m", "p", "u", "w" e "d"
%
% Retorno: Matriz[qtde_Instâncias,7] com valores 0's e 1's de modo que:
%     grasses (g)   =   [1 0 0 0 0 0 0]
%     leaves (l)    =   [0 1 0 0 0 0 0]
%     meadows (m)   =   [0 0 1 0 0 0 0]
%     paths (p)     =   [0 0 0 1 0 0 0]
%     urban (u)     =   [0 0 0 0 1 0 0]
%     waste (w)     =   [0 0 0 0 0 1 0]
%     woods (d)     =   [0 0 0 0 0 0 1]
%
%==========================================================================

function classe = separaHabitat(mushC)
  MC = zeros(8124,7);
  for i=1:8124
     if (strcmp(mushC(i,1),'g') == 1)
         MC(i,1) = 1;
     end
     if (strcmp(mushC(i,1),'l') == 1)
         MC(i,2) = 1;
     end
     if (strcmp(mushC(i,1),'m') == 1)
         MC(i,3) = 1;
     end
     if (strcmp(mushC(i,1),'p') == 1)
         MC(i,4) = 1;
     end
     if (strcmp(mushC(i,1),'u') == 1)
         MC(i,5) = 1;
     end
     if (strcmp(mushC(i,1),'w') == 1)
         MC(i,6) = 1;
     end
     if (strcmp(mushC(i,1),'d') == 1)
         MC(i,7) = 1;
     end
  end
  classe = MC;
end