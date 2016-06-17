%==========================================================================
% Algoritmo transforma gill-color em que:
% Entrada: Matriz[qtde_Instâncias,1] com valores "k", "n", "b", "h", "g", "r", "o", "p", "u", "e", "w" e "y"
%
% Retorno: Matriz[qtde_Instâncias,12] com valores 0's e 1's de modo que:
%     black (k)     =   [1 0 0 0 0 0 0 0 0 0 0 0]
%     brown (n)     =   [0 1 0 0 0 0 0 0 0 0 0 0]
%     buff (b)      =   [0 0 1 0 0 0 0 0 0 0 0 0]
%     chocolate (h) =   [0 0 0 1 0 0 0 0 0 0 0 0]
%     gray (g)      =   [0 0 0 0 1 0 0 0 0 0 0 0]
%     green (r)     =   [0 0 0 0 0 1 0 0 0 0 0 0]
%     orange (o)    =   [0 0 0 0 0 0 1 0 0 0 0 0]
%     pink (p)      =   [0 0 0 0 0 0 0 1 0 0 0 0]
%     purple (u)    =   [0 0 0 0 0 0 0 0 1 0 0 0]
%     red (e)       =   [0 0 0 0 0 0 0 0 0 1 0 0]
%     white (w)     =   [0 0 0 0 0 0 0 0 0 0 1 0]
%     yellow (y)    =   [0 0 0 0 0 0 0 0 0 0 0 1]
%
%==========================================================================
% 9. : ,,,,,,,,,,
function classe = separaGillCo(mushC)
  MC = zeros(8124,12);
  for i=1:8124
     if (strcmp(mushC(i,1),'k') == 1)
         MC(i,1) = 1;
     end
     if (strcmp(mushC(i,1),'n') == 1)
         MC(i,2) = 1;
     end
     if (strcmp(mushC(i,1),'b') == 1)
         MC(i,3) = 1;
     end
     if (strcmp(mushC(i,1),'h') == 1)
         MC(i,4) = 1;
     end
     if (strcmp(mushC(i,1),'g') == 1)
         MC(i,5) = 1;
     end
     if (strcmp(mushC(i,1),'r') == 1)
         MC(i,6) = 1;
     end
     if (strcmp(mushC(i,1),'o') == 1)
         MC(i,7) = 1;
     end
     if (strcmp(mushC(i,1),'p') == 1)
         MC(i,8) = 1;
     end
     if (strcmp(mushC(i,1),'u') == 1)
         MC(i,9) = 1;
     end
     if (strcmp(mushC(i,1),'e') == 1)
         MC(i,10) = 1;
     end
     if (strcmp(mushC(i,1),'w') == 1)
         MC(i,11) = 1;
     end
     if (strcmp(mushC(i,1),'y') == 1)
         MC(i,12) = 1;
     end
  end
  classe = MC;
end