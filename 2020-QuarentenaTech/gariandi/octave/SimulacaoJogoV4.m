function q = SimulacaoJogoV4(player_inicio,espera,dificuldade)

%% V4: usando leitura de csv vindo de ProximaJogada_full(dificuldade)  
  
%% V3: salva matrizes num array 3D
  
%% V2: usa ProximaJogadaV3
%% para monitorar qual parte do algoritmo � usada
%% salvando vari�vel cod .
%% cod de um d�gito => Fim de jogo
%% 2 d�gitos come�ando com um =>  Defesa
%% 4 digitos come�ando com dois ou 3 => Ataque
  
% player_inicio = 1  => usu�rio come�a
% player_inicio = 2  => computer come�a
  
  cods = [];
  
  A1 = SorteiaMatrizInicial(player_inicio)
  csvwrite('Tabuleiro.csv',A1);
  Saida = A1;
  pause(espera);
  A2 = A1;

  while length(A2)>1 && length(A1)>1
    Saida = cat(3,Saida,A1,A2);
    ProximaJogadaVfinal(dificuldade);
    A2 = csvread('Tabuleiro.csv');
    load cod;
    cod
    cods = horzcat(cods,cod);
    pause(espera);
    A1 = SorteiaJogadaUsuario(A2)
    Tabuleiro = A1;
    csvwrite('Tabuleiro.csv',Tabuleiro);
    pause(espera);
  end
  
  Saida(:,:,1) = []; Saida(:,:,2) = [];
  
  save cods;
  
  q = Saida;
  
endfunction
