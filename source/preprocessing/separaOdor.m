 
%==========================================================================
% Algoritmo transforma odor em que:
% Entrada: Matriz[qtde_Instâncias,1] com valores "a", "l", "c", "y", "f", "m", "n", "p" e "s"
%
% Retorno: Matriz[qtde_Instâncias,9] com valores 0's e 1's de modo que:
%     almond (a)    =   [1 0 0 0 0 0 0 0 0]
%     anise (l)     =   [0 1 0 0 0 0 0 0 0]
%     creosote (c)  =   [0 0 1 0 0 0 0 0 0]
%     fishy (y)     =   [0 0 0 1 0 0 0 0 0]
%     foul (f)      =   [0 0 0 0 1 0 0 0 0]
%     musty (m)     =   [0 0 0 0 0 1 0 0 0]
%     none (n)      =   [0 0 0 0 0 0 1 0 0]
%     pungent (p)   =   [0 0 0 0 0 0 0 1 0]
%     spicy (s)     =   [0 0 0 0 0 0 0 0 1]
%
%==========================================================================

function classe = separaOdor(mushC)
  MC = zeros(8124,9);
  for i=1:8124
     if (strcmp(mushC(i,1),'a') == 1)
         MC(i,1) = 1;
     end
     if (strcmp(mushC(i,1),'l') == 1)
         MC(i,2) = 1;
     end
     if (strcmp(mushC(i,1),'c') == 1)
         MC(i,3) = 1;
     end
     if (strcmp(mushC(i,1),'y') == 1)
         MC(i,4) = 1;
     end
     if (strcmp(mushC(i,1),'f') == 1)
         MC(i,5) = 1;
     end
     if (strcmp(mushC(i,1),'m') == 1)
         MC(i,6) = 1;
     end
     if (strcmp(mushC(i,1),'n') == 1)
         MC(i,7) = 1;
     end
     if (strcmp(mushC(i,1),'p') == 1)
         MC(i,8) = 1;
     end
     if (strcmp(mushC(i,1),'s') == 1)
         MC(i,9) = 1;
     end
  end
  classe = MC;
end