%==========================================================================
% Algoritmo transforma cap-shape em que:
% Entrada: Matriz[qtde_Instâncias,1] com valores "b", "c", "x", "f", "k" e "s"
%
% Retorno: Matriz[qtde_Instâncias,6] com valores 0's e 1's de modo que:
%     bell (b)      =   [1 0 0 0 0 0]
%     conical (c)   =   [0 1 0 0 0 0]
%     convex (x)    =   [0 0 1 0 0 0]
%     flat (f)      =   [0 0 0 1 0 0]
%     knobbed (k)   =   [0 0 0 0 1 0]
%     sunken (s)    =   [0 0 0 0 0 1]
%
%==========================================================================

function classe = separaCapS(mushC)
  MC = zeros(8124,6);
  for i=1:8124
     if (strcmp(mushC(i,1),'b') == 1)
         MC(i,1) = 1;
     end
     if (strcmp(mushC(i,1),'c') == 1)
         MC(i,2) = 1;
     end
     if (strcmp(mushC(i,1),'x') == 1)
         MC(i,3) = 1;
     end
     if (strcmp(mushC(i,1),'f') == 1)
         MC(i,4) = 1;
     end
     if (strcmp(mushC(i,1),'k') == 1)
         MC(i,5) = 1;
     end
     if (strcmp(mushC(i,1),'s') == 1)
         MC(i,6) = 1;
     end
  end
  classe = MC;
end