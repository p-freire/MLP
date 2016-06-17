%==========================================================================
% Algoritmo transforma ring-type em que:
% Entrada: Matriz[qtde_Instâncias,1] com valores "c", "e", "f", "l", "n", "p", "s" e "z"
%
% Retorno: Matriz[qtde_Instâncias,8] com valores 0's e 1's de modo que:
%     cobwebby (c)  =   [1 0 0 0 0 0 0 0]
%     evanescent(e) =   [0 1 0 0 0 0 0 0]
%     flaring (f)   =   [0 0 1 0 0 0 0 0]
%     large (l)     =   [0 0 0 1 0 0 0 0]
%     none (n)      =   [0 0 0 0 1 0 0 0]
%     pendant (p)   =   [0 0 0 0 0 1 0 0]
%     sheathing (s) =   [0 0 0 0 0 0 1 0]
%     zone (z)      =   [0 0 0 0 0 0 0 1]
%
%==========================================================================

function classe = separaRingTP(mushC)
  MC = zeros(8124,8);
  for i=1:8124
     if (strcmp(mushC(i,1),'c') == 1)
         MC(i,1) = 1;
     end
     if (strcmp(mushC(i,1),'e') == 1)
         MC(i,2) = 1;
     end
     if (strcmp(mushC(i,1),'f') == 1)
         MC(i,3) = 1;
     end
     if (strcmp(mushC(i,1),'l') == 1)
         MC(i,4) = 1;
     end
     if (strcmp(mushC(i,1),'n') == 1)
         MC(i,5) = 1;
     end
     if (strcmp(mushC(i,1),'p') == 1)
         MC(i,6) = 1;
     end
     if (strcmp(mushC(i,1),'s') == 1)
         MC(i,7) = 1;
     end
     if (strcmp(mushC(i,1),'z') == 1)
         MC(i,8) = 1;
     end
  end
  classe = MC;
end