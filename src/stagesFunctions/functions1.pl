:- module(functions1, []).

:- use_module("./src/board.pl").
:- use_module("./src/window.pl").

movimento(w, (-1, 0)). % Para cima
movimento(s, (1, 0)).  % Para baixo
movimento(a, (0, -1)). % Para a esquerda
movimento(d, (0, 1)).  % Para a direita

elemento_matriz(Matriz, X, Y, Elemento) :-
    length(Matriz, Linhas),
    nth0(0, Matriz, PrimeiraLinha),
    length(PrimeiraLinha, Colunas),
    X >= 0, X < Linhas,
    Y >= 0, Y < Colunas,
    nth0(X, Matriz, Linha),
    nth0(Y, Linha, Elemento).


mover_ate_proximo(Matriz, X, Y, DX, DY, NX, NY) :-
    NX1 is X + DX,
    NY1 is Y + DY,
    elemento_matriz(Matriz, NX1, NY1, Elem),
    processa_elemento(Elem, Matriz, NX1, NY1, X, Y, DX, DY, NX, NY),
    !.

processa_elemento((-1, -1), _, _, _, X, Y, _, _, X, Y) :- !.

processa_elemento((1, _), _, NX1, NY1, _, _, _, _, NX1, NY1) :- !.

processa_elemento(_, Matriz, NX1, NY1, X, Y, DX, DY, NX, NY) :- mover_ate_proximo(Matriz, NX1, NY1, DX, DY, NX, NY).


move_cursor(Matriz, X, Y, (TotRounds, StageNum, Player, P1, P2)) :-
    get_single_char(Input),
    char_code(Char, Input),
    processa_entrada(Char, Matriz, X, Y, NX, NY),
    processa_jogada(Matriz, NX, NY, (TotRounds, StageNum, Player, P1, P2)).

processa_entrada(Input, Matriz, X, Y, NX, NY) :-
    movimento(Input, (DX, DY)),
    mover_ate_proximo(Matriz, X, Y, DX, DY, NX, NY),
    !.

processa_entrada(_, _, X, Y, X, Y).

processa_jogada(Matriz, X, Y, (TotRounds, StageNum, Player, P1, P2)) :-
    window:showGameData(TotRounds, StageNum, Player, P1, P2),
    board:boardGenerate((X, Y), Matriz),
    move_cursor(Matriz, X, Y, (TotRounds, StageNum, Player, P1, P2)).