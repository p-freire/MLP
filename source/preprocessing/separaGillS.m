
%==========================================================================
% Algoritmo transforma gill-spacing em que:
% Entrada: Matriz[qtde_Instâncias,1] com valores "c", "w" e "d"
%
% Retorno: Matriz[qtde_Instâncias,3] com valores 0's e 1's de modo que:
%     close (c)     =   [1 0 0]
%     crowded (w)   =   [0 1 0]
%     distant (d)   =   [0 0 1]
%
%==========================================================================

function classe = separaGillS(mushC)
  MC = zeros(8124,3);
  for i=1:8124
     if (strcmp(mushC(i,1),'c') == 1)
         MC(i,1) = 1;
     end
     if (strcmp(mushC(i,1),'w') == 1)
         MC(i,2) = 1;
     end
     if (strcmp(mushC(i,1),'d') == 1)
         MC(i,3) = 1;
     end
  end
  classe = MC;
end