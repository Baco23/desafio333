%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%% Desafio 333 - Quarentena Tech - Maio 2020 %%%%%%%%%
%%%%%%%%%%%%%%%%%%%% Jogo da Velha %%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%% Wolverines %%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%% Gabriel, Vin�cius, Wesley %%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%% programa principal %%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function q = ProximaJogada_full(dificuldade)
%% dificuldade: n�mero de 0 a 1

a = rand(); %nro aleatorio de 0 a 1

Tabuleiro = csvread('Tabuleiro.csv');

if a < dificuldade
  %dessa nao ganhar�s!
  Tabuleiro = NaoGanharas(Tabuleiro);   % IA - ganha em 90% dos casos, empata em 8%, s� deixa user vencer 2%

else

  Tabuleiro = SorteiaJogadaCompu(Tabuleiro);  % computador faz jogada aleat�ria
 
end

cswwrite('Tabuleiro.csv',Tabuleiro); %Tabuleiro vai ser 3x3 durante o jogo e 1x1 no final

q = 1;

end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%% fim do programa principal %%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function q = SorteiaJogadaCompu(A)
  
  i = find(A==0);
  N = length(i); 
  N = nro_natural_aleatorio(N);
  
  if ~isempty(i)
    A(i(N)) = 0.3;
  end
  
  q = A;
  
endfunction

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function q = NaoGanharas(A0)
  
%% Antiga fun��o ProximaJogadaV3: monitora q parte do algoritmo � usada salvando vari�vel cod .
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

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function q = DefendeuV3(A0,k)
  
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function q = nro_natural_aleatorio(N)
  
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function q = AtacouV4(A0)
  
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% V4: monitora q parte do algoritmo � usada salvando vari�vel cod .
%% cod de um d�gito => Fim de jogo
%% 2 d�gitos come�ando com um =>  Defesa
%% 4 digitos come�ando com dois ou tr�s => Ataque
  
  cod = 2;
  
  A = A0;
  
  diag1 = trace(A0);
  diag2 = trace(flip(A0));
  lins = sum(A0');
  cols = sum(A0);
  
  soma = [diag1 diag2 lins cols];
  Soma = MontaMatrizSoma(A0);
  %mods = [ mod(diag1,0.3) mod(diag2,0.3) mod(lins(1),0.3) mod(lins(2),0.3) mod(lins(3),0.3) mod(cols(1),0.3) mod(cols(2),0.3) mod(cols(3),0.3) ]
  
  mods = mod(soma,0.3); 
   
   i = find(mods==0);  tem_brecha = ~isempty(i);

if tem_brecha %checar se pode completar aonde atacou antes
   
   if length(i)>1
    i = find(soma==min(soma(i(:))));
   end
  
   if i==1 %mod(diag1,0.3)==0
    range = [1 5 9];
   else
     if i==2 %mod(diag2,0.3)==0
       range = [7 5 3];
     else      
       if i==3 %mod(lins(1),0.3)==0 
         range = [1 4 7];
       else
         if i==4 %mod(lins(2),0.3)==0
           range = [2 5 8];
          else
          if i==5 %mod(lins(3),0.3)==0
            range = [3 6 9];
          else
            if i==6 %mod(cols(1),0.3)==0
              range = [1 2 3];
            else
              if i==7 %mod(cols(2),0.3)==0
                range = [4 5 6];
              else
                if i==8 %mod(cols(3),0.3)==0
                  range = [7 8 9];
                else
                  range = find(Soma==min(min(Soma)));
                end
              end
            end
          end
        end
      end
    end
  end            
    
    cod = 10*cod + i ;  

    i = find(A0(range)==0);
    if length(i)>1
 %     i_ = find(Soma(i(:))==min(min(Soma))
      if Soma(i(1))<Soma(i(2))
        i = i(1);   
      else
        i = i(2);
      end
      cod = 28 + i;  %% cods 29 ou 30
    else
      cod = 20;  %% cod 20
    end
  
    A(range(i)) = 0.3;
    cod = 100*cod; 
    save cod;
else
  cod = 200; save cod;
  A = AtacouV1_2(A);

end  
    
  q = A;
  
endfunction

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  %sorteia um numero aleat�rio n�o nulo at� o valor N
  
   q = round((N-1)*rand()) + 1 ;
  
endfunction


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


function q = MontaMatrizSoma(A0)
  
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function q = AtacouV1_2(A0)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%  

function q = espacoMaisDistante(A,i,j)
  
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function q = AtaquePuntualV2(A0,k)
  
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%  FIM  %%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% V2: monitora q parte do algoritmo � usada salvando vari�vel cod .
%% cod de um d�gito => Fim de jogo
%% 2 d�gitos come�ando com um =>  Defesa
%% 4 digitos come�ando com dois ou 3 => Ataque
  
  A = A0;
  load cod;
          if k==1
            diagA0 = diag(A0); %vetor com a diagonal principal, de cima para baixo
            i = find(diagA0==0) %acha espa�o vazio nessa diagonal
            A(i,i) = 0.3; %ataca esse espa�o!
            cod = 10*cod + 1;
          else
            if k==2
             diagA0 = diag(flip(A0)); %vetor com a diagonal secund�ria, de cima para baixo
             i = find(diagA0==0) %acha espa�o vazio nessa diagonal    
             A(3-i+1,i) = 0.3 ; %ataca esse espa�o!
             cod = 10*cod + 2;
            else
              if k>=3 && k<=5
                lins = sum(A0');
                i = find(lins==2); %acha linha onde est� atacando
                j = find(A0(i,:)==0); %acha coluna vazia nessa linha
                A(i,j) = 0.3; %ataca a linha!
                cod = 10*cod + 3;
              else     
                 if k>=6 && k<=8
                    cols = sum(A0);
                    j = find(cols==2); %acha coluna onde est� atacando
                    i = find(A0(:,j)==0); %acha linha vazia nessa coluna
                    A(i,j) = 0.3; %ataca a coluna!
                    cod = 10*cod + 4;
                 end
              end
           end
        end
  q = A;
  
  save cod;
  
endfunction

  
   %acha elemento mais distante de tudo que usu�rio preencheu no tabuleiro
   Distancia = zeros(1,length(i));
       for p=1:length(i)
          [i_uns,j_uns] = find(A==1);
           for q=1:length(i_uns)
                Distancia(p) = Distancia(p) + sqrt( (i(p)-i_uns(q))^2 + (j(p)-j_uns(q))^2 );
           end
       end
   i_Dmax = find(Distancia==max(Distancia));
   i = i(i_Dmax); j = j(i_Dmax);

   q = [i' j'];
   
endfunction

  
%% V1_2: monitora q parte do algoritmo � usada salvando vari�vel cod .
%% cod de um d�gito => Fim de jogo
%% 2 d�gitos come�ando com um =>  Defesa
%% 4 digitos come�ando com dois => Ataque

  load cod;
  
  A = A0;
  
  diag1 = trace(A0);
  diag2 = trace(flip(A0));
  lins = sum(A0');
  cols = sum(A0);
  
  somas = [ diag1 diag2 lins cols ];    
  
        k = find(somas==min(somas)); % vendo aonde tem mais espa�o para atacar
        tem_dois_espacos = length(k)>1;
        if tem_dois_espacos
          Somas = MontaMatrizSoma(A0); cod = cod +1 ;
     %     Somas = A0 + Somas;          
          [i,j]= find(Somas==min(min(Somas))) ; % && ~eh_inteiro_(Somas));
          tem_dois_minimos = length(i)>1
          if tem_dois_minimos || A(i,j)~=0
            cod = cod + 1;
            [_i,_j] = find(A(i(:),j(:))==0);
            i = i(_i);
            j = j(_j);
          end
          tem_dois_minimos = length(i)>1 ; % de novo
          if tem_dois_minimos || A(i,j)~=0
            cod = cod + 1;
            %acha elemento mais distante de tudo que usu�rio preencheu no tabuleiro
            elemento = espacoMaisDistante(A,i,j);
            i = elemento(:,1); j = elemento(:,2);
             
           end
           tem_dois_maximos = length(i)>1 ;
           if tem_dois_maximos || A(i,j)~=0
             cod = cod + 1;
             N = length(i);
             escolhido = nro_natural_aleatorio(N);
             i = i(escolhido); j = j(escolhido);
           end
           if A(i,j)==0 %|| A(i,j)~=0
             cod = cod + 1;
             A(i,j) = 0.3;  %ataca!
           else
             cod = cod + 1 ;
             while A(i,j)~=0
               Somas(i,j) = max(max(Somas));
               [i,j]= find(Somas==min(min(Somas)));
             end
             A(i,j) = 0.3; 
            end 
            Somas(i,j) = max(max(Somas(i,j)));
            cod = cod*10; save cod;            
        else                                      
           A = AtaquePuntualV2(A0,k) ;
        end      
        
q = A; 

endfunction
  
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%




