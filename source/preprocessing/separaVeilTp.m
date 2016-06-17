%==========================================================================
% Algoritmo transforma veil-type em que:
% Entrada: Matriz[qtde_Instâncias,1] com valores "p" e "u"
%
% Retorno: Matriz[qtde_Instâncias,2] com valores 0's e 1's de modo que:
%     partial (p)     =   [1 0]
%     universal(u)    =   [0 1]
%
%==========================================================================

function classe = separaVeilTp(mushC)
  MC = zeros(8124,2);
  for i=1:8124
     if (strcmp(mushC(i,1),'p') == 1)
         MC(i,1) = 1;
     end
     if (strcmp(mushC(i,1),'u') == 1)
         MC(i,2) = 1;
     end
  end
  classe = MC;
end