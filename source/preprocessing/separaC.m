%==========================================================================
% Algoritmo transforma classe
%     edible (e) = 1
%     poisonous (p) = 0
%
% Entrada: Matriz[qtde_Instâncias,1] com valore "e" e "p"
% Retorno: Matriz[qtde_Instâncias,1] com valores 0's e 1's. 
%==========================================================================
function classe = separaC(mushC)
  for i=1:8124
     if (strcmp(mushC(i,1),'p') == 1)
         MC(i,1) = 0;
     else
         MC(i,1) = 1;
     end    
  end
  classe = MC;
end

