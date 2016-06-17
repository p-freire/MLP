
%==========================================================================
% Algoritmo transforma gill-attachment em que:
% Entrada: Matriz[qtde_Instâncias,1] com valores "a", "d", "f" e "n"
%
% Retorno: Matriz[qtde_Instâncias,4] com valores 0's e 1's de modo que:
%     attached (a)      =   [1 0 0 0]
%     descending (d)    =   [0 1 0 0]
%     free (f)          =   [0 0 1 0]
%     notched (n)       =   [0 0 0 1]
%
%==========================================================================

function classe = separaGillA(mushC)
  MC = zeros(8124,4);
  for i=1:8124
     if (strcmp(mushC(i,1),'a') == 1)
         MC(i,1) = 1;
     end
     if (strcmp(mushC(i,1),'d') == 1)
         MC(i,2) = 1;
     end
     if (strcmp(mushC(i,1),'f') == 1)
         MC(i,3) = 1;
     end
     if (strcmp(mushC(i,1),'n') == 1)
         MC(i,4) = 1;
     end
  end
  classe = MC;
end