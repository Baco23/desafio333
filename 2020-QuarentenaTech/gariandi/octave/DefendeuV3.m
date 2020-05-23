function q = DefendeuV3(A0,k)
%% V3: monitora q parte do algoritmo � usada salvando vari�vel cod .
%% cod de um d�gito => Fim de jogo
%% 2 d�gitos come�ando com um =>  Defesa
%% 4 digitos come�ando com dois => Ataque

  cod = 0;
  
  A = A0;

  lins = sum(A0');
  cols = sum(A0);
  
%  somas = [ diag1 diag2 lins cols ];
  
%  Somas = MontaMatrizSoma(A0);

%  k = find(somas==2);

  if length(k)>1
    n = nro_natural_aleatorio(length(k));
    k = k(n);
  end
  
 %   if ~isempty(k)

        if k==1
          diagA0 = diag(A0); %vetor com a diagonal principal, de cima para baixo
          i = find(diagA0==0); %acha espa�o vazio nessa diagonal
          A(i,i) = 0.3; %defende esse espa�o!
          cod = 11; save cod;
        else
          if k==2
             diagA0 = diag(flip(A0)); %vetor com a diagonal secund�ria, de cima para baixo
             i = find(diagA0==0); %acha espa�o vazio nessa diagonal    
             A(3-i+1,i) = 0.3 ; %defende esse espa�o!
             cod = 12; save cod;
           else
              if k>=3 && k<=5
                i = find(lins==2); %acha linha onde est� atacando
                j = find(A0(i,:)==0); %acha coluna vazia nessa linha
                A(i,j) = 0.3; %defende a linha!
                cod = 13;
                save cod;
              else     
                 if k>=6 && k<=8
                    j = find(cols==2); %acha coluna onde est� atacando
                    i = find(A0(:,j)==0); %acha linha vazia nessa coluna
                   A(i,j) = 0.3; %defende a coluna!
                   cod = 14; save cod;
                 end
              end
           end
        end
%     end

   q = A;
  
endfunction
