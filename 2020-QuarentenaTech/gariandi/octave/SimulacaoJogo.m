function q = SimulacaoJogo(player_inicio,espera)
% player_inicio = 1  => usu�rio come�a
% player_inicio = 2  => computer come�a
  
  
  A1 = SorteiaMatrizInicial(player_inicio)
  pause(espera);
  A2 = A1;

  while length(A2)>1 && length(A1)>1
    A2 = ProximaJogadaV2(A1)
    pause(espera);
    A1 = SorteiaJogadaUsuario(A2)
    pause(espera);
  end
  
  q = A2;
  
endfunction
