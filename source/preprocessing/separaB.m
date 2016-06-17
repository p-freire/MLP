
%==========================================================================
% Algoritmo transforma bruises? em que:
% Entrada: Matriz[qtde_Instâncias,1] com valores "t", e "f"
%
% Retorno: Matriz[qtde_Instâncias,2] com valores 0's e 1's de modo que:
%     bruises(t)    =   [1 0]
%     no (f)        =   [0 1]
%
%==========================================================================

function classe = separaB(mushC)
  MC = zeros(8124,2);
  for i=1:8124
     if (strcmp(mushC(i,1),'t') == 1)
         MC(i,1) = 1;
     end
     if (strcmp(mushC(i,1),'f') == 1)
         MC(i,2) = 1;
     end
  end
  classe = MC;
end