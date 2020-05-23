function q = ProximaJogadaV3(A0);
%% V3: monitora q parte do algoritmo � usada salvando vari�vel cod .
%% cod de um d�gito => Fim de jogo
%% 2 d�gitos come�ando com um =>  Defesa
%% 4 digitos come�ando com dois => Ataque

  % A0 � uma matriz 3x3 com zeros, uns e fra��es (0.3) 
  % As jogadas do usu�rio est�o representadas pelos uns
  % As jogadas do computador est�o representadas pelos 0.3
  % Os zeros s�o espa�os vazios
  
  %Vamos usar um algoritmo com os seguintes passos:
  
  %I) obter as somas da matriz em todos os sentidos
  %II) testar se as somas s�o inteiros na seguinte ordem: diagonais, linhas e colunas.
  %III) testar se somas s�o >= do que 2, 
        % se n�o localizar aonde e defender elemento correspondente
       % caso for <2 , testar se � menor do que 1.5
        
        %prioridades de ataque: (1) elemento central ( [i,j] = [2,2] )
        %                       (2) cantos  ( [i,j] = [1,1] , [1,3] , [3,1] , [3,3] )
        %                       (3) bordas da cruz central ( [i,j] =  [1,2] , [2,1] , [2,3] , [3,2]

   cod = 0;

   A = A0; %inicializa��o matriz de sa�da  
  
  %I) somas  
  diag1 = trace(A0);
  diag2 = trace(flip(A0));
  lins = sum(A0');
  cols = sum(A0);
  
  somas = [ diag1 diag2 lins cols ];

  %II) testando possibilidades para somas  
  k = find(somas==3*0.3); compu_vence = ~isempty(k);
  if compu_vence
    disp('Voc� perdeu');
    A = 1; cod = 1; save cod;
  else
   k = find(somas==3); user_vence = ~isempty(k); 
   if user_vence 
      disp('Voc� venceu');
      A = 0; cod = 0; save cod;
   else 
     k = find(A0==0); tem_zeros = ~isempty(k);
     if ~tem_zeros
        disp('Deu velha!');
        A = -1; cod = -1; save cod;
     else
      k = find(somas==2);  %averiguando aonde defender (coluna, linha ou diagonal)  
      tem_brecha = ~isempty(k);
      if tem_brecha %caso usu�rio ataque (marque duas casas vizinhas com possibilidade de uma terceira)
         A = DefendeuV3(A0,k);  % defesa!      
      else  
        %k = find(somas==min(somas)); % vendo aonde tem mais espa�o para atacar
        %A = AtacouV3(A0,k);  % ataque!
         A = AtacouV4(A0);   
      endif
      
     endif  
   endif
  endif

 
q = A;  
  
endfunction
