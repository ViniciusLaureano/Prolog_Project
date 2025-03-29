:- use_module("./board.pl").

startTutorial :-
    limpar_tela,
    exibir_introducao,
    aguardar_input.

exibir_introducao :-
    write("O Nine Men's Morris (também conhecido como 'Moinho' ou 'Jogo do Moinho') é um jogo de"), nl,
    write("estratégia antigo e clássico para dois jogadores. O objetivo do jogo é formar 'moinhos'"), nl,
    write("(linhas de três peças) para capturar as peças do oponente. O jogo é dividido em três"), nl,
    write("fases: colocação de peças, movimentação de peças e fase final (quando um jogador tem"), nl,
    write("apenas três peças)."), nl, nl,
    write("Pressione a seta → para continuar ou 'q' para sair"), nl.

aguardar_input :-
    get_single_char(Code),
    (Code == 27 ->  % Tecla ESC (início da sequência de setas)
        get_single_char(_),  % Lê o '['
        get_single_char(Direcao),
        (Direcao == 67 ->  % 'C' = Seta direita
            limpar_tela,
            write("Você pressionou a seta para direita! Vamos continuar..."), nl,
            proxima_tela
        ;
            aguardar_input
        )
    ;
    Code == 113 ->  % 'q' = Sair
        limpar_tela,
        write("Saindo do tutorial..."), nl,
        halt
    ;
        aguardar_input
    ).

proxima_tela :-
    write("Fase 1: Colocação de Peças"), nl,
    write("-------------------------"), nl,
    write("Nesta fase inicial, os jogadores alternam colocando suas peças"), nl,
    write("nos pontos vazios do tabuleiro."), nl, nl,
    write("Pressione → para continuar ou 'q' para sair"), nl,
    aguardar_input.

limpar_tela :- format('\e[H\e[2J').

% Para iniciar o tutorial:
main :-
    startTutorial.