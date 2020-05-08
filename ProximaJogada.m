function q = ProximaJogada(A0)
  % A0 � uma matriz 3x3 com zeros, uns e fra��es (0.4) 
  % As jogadas do usu�rio est�o representadas pelos uns
  % As jogadas do computador est�o representadas pelos 0.4
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


   A = A0; %inicializa��o matriz de sa�da  
  
  %I) somas  
  diag1 = trace(A0);
  diag2 = trace(flip(A0));
  lins = sum(A0');
  cols = sum(A0);
  
  somas = [ diag1 diag2 lins cols ];

  %II) testando possibilidades para somas  
  if find(somas==3*0.4)
    disp('Voc� perdeu');
    A = 1;
  else
   if find(somas==3) 
      disp('Voc� venceu');
      A = 0;
   else 
     if ~find(A0==0)
        disp('Deu velha!');
        A = -1;
     else   
      
      if find(somas==2) %caso usu�rio marque duas casas na mesma linha, coluna ou diagonal
         k = find(somas==2);  %averiguando aonde defender (coluna, linha ou diagonal)
         A = Defendeu(A0,k);  % defesa!      
      else  
        %k = find(somas==min(somas)); % vendo aonde tem mais espa�o para atacar
        A = AtacouV3(A0); %,k);  % ataque!   
     
      endif
      
     endif  
   endif
  endif

 
q = A;  
  
endfunction


%%%%%%%%%%%%%%%%%%%%%%%%%
function q = eh_inteiro_(vetor)
 n = length(vetor);
 
 saida = zeros(1,n);
 
 for i=1:n
 
    if eh_inteiro(vetor(i))
      saida(1,i) = 1 ;
    else
       saida(1,i) = 0;
     endif

 end

 q=saida;
endfunction


%%%%%%%%%%%%%%%%%%%

function q = eh_inteiro(n)
  
  saida = 0;
  
  if (abs(mod(n,1))==0)
    saida = 1;
  endif
  
  q = saida;
  
endfunction

%%%%%%%%%%%%%%%%%%%%%%%%

function q = Defendeu(A0,k)
  
  A = A0;
  
  diag1 = trace(A0);
  diag2 = trace(flip(A0));
  lins = sum(A0');
  cols = sum(A0);
  
  somas = [ diag1 diag2 lins cols ];
  
        if k==1
          diagA0 = diag(A0); %vetor com a diagonal principal, de cima para baixo
          i = find(diagA0==0) %acha espa�o vazio nessa diagonal
          A(i,i) = 0.4; %defende esse espa�o!
        else
          if k==2
             diagA0 = diag(flip(A0)); %vetor com a diagonal secund�ria, de cima para baixo
             i = find(diagA0==0) %acha espa�o vazio nessa diagonal    
             A(3-i+1,i) = 0.4 ; %defende esse espa�o!
           else
              if k==3
                i = find(lins==2); %acha linha onde est� atacando
                j = find(A0(i,:)==0); %acha coluna vazia nessa linha
                A(i,j) = 0.4; %defende a linha!
              else     
                 if k==4
                    j = find(cols==2); %acha coluna onde est� atacando
                    i = find(A0(:,j)==0); %acha linha vazia nessa coluna
                   A(i,j) = 0.4; %defende a coluna!
                 end
              end
           end
        end

   q = A;
  
endfunction
