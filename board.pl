:- module(board, []).

imprimeTabuleiro(Input) :-
    (Input == 'q' -> 
        write('\e[H\e[J'),
        write('Saindo do programa...'),
        halt
    ;
        write('\e[H\e[J'),
        % Desenho do tabuleiro
        write(" *━━━━━━━━━━━━━━━━━*━━━━━━━━━━━━━━━━━*"), nl,
        write(" ┃                 ┃                 ┃"), nl,
        write(" ┃                 ┃                 ┃"), nl,
        write(" ┃     *━━━━━━━━━━━*━━━━━━━━━━━*     ┃"), nl, 
        write(" ┃     ┃           ┃           ┃     ┃"), nl,
        write(" ┃     ┃           ┃           ┃     ┃"), nl,
        write(" ┃     ┃     *━━━━━*━━━━━*     ┃     ┃"), nl,
        write(" ┃     ┃     ┃           ┃     ┃     ┃"), nl,
        write(" ┃     ┃     ┃           ┃     ┃     ┃"), nl,
        write(" *━━━━━*━━━━━*           *━━━━━*━━━━━*"), nl,
        write(" ┃     ┃     ┃           ┃     ┃     ┃"), nl,
        write(" ┃     ┃     ┃           ┃     ┃     ┃"), nl,
        write(" ┃     ┃     *━━━━━*━━━━━*     ┃     ┃"), nl,
        write(" ┃     ┃           ┃           ┃     ┃"), nl,
        write(" ┃     ┃           ┃           ┃     ┃"), nl,
        write(" ┃     *━━━━━━━━━━━*━━━━━━━━━━━*     ┃"), nl,
        write(" ┃                 ┃                 ┃"), nl,
        write(" ┃                 ┃                 ┃"), nl,
        write(" *━━━━━━━━━━━━━━━━━*━━━━━━━━━━━━━━━━━*"), nl,
        nl,
        write('Pressione "q" para sair ou qualquer tecla para continuar...'), nl,
        get_single_char(Char),  % Lê um único caractere
        atom_char(C, Char),     % Converte para átomo
        imprimeTabuleiro(C)     % Chama recursivamente com o novo input
    ).