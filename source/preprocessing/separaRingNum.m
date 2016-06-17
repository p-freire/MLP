%==========================================================================
% Algoritmo transforma ring-number em que:
% Entrada: Matriz[qtde_Instâncias,1] com valores "n", "o" e "t"
%
% Retorno: Matriz[qtde_Instâncias,3] com valores 0's e 1's de modo que:
%     none (n)  =   [1 0 0]
%     one (o)   =   [0 1 0]
%     two (t)   =   [0 1 0]
%
%==========================================================================

function classe = separaRingNum(mushC)
  MC = zeros(8124,3);
  for i=1:8124
     if (strcmp(mushC(i,1),'n') == 1)
         MC(i,1) = 1;
     end
     if (strcmp(mushC(i,1),'o') == 1)
         MC(i,2) = 1;
     end
     if (strcmp(mushC(i,1),'t') == 1)
         MC(i,3) = 1;
     end
  end
  classe = MC;
end