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

substituir_elemento(Matriz, X, Y, NovoElemento, NovaMatriz) :-
    nth0(X, Matriz, LinhaAntiga),
    substituir_em_lista(LinhaAntiga, Y, NovoElemento, NovaLinha),
    substituir_em_lista(Matriz, X, NovaLinha, NovaMatriz).

substituir_em_lista([_|T], 0, Elem, [Elem|T]).
substituir_em_lista([H|T], Index, Elem, [H|NovaT]) :-
    Index > 0,
    Index1 is Index - 1,
    substituir_em_lista(T, Index1, Elem, NovaT).

mover_ate_proximo(Matriz, X, Y, DX, DY, NX, NY) :-
    NX1 is X + DX,
    NY1 is Y + DY,
    elemento_matriz(Matriz, NX1, NY1, Elem),
    processa_elemento(Elem, Matriz, NX1, NY1, X, Y, DX, DY, NX, NY),
    !.

processa_elemento((-1, -1), _, _, _, X, Y, _, _, X, Y) :- !.
processa_elemento((1, _), _, NX1, NY1, _, _, _, _, NX1, NY1) :- !.
processa_elemento(_, Matriz, NX1, NY1, X, Y, DX, DY, NX, NY) :-
    mover_ate_proximo(Matriz, NX1, NY1, DX, DY, NX, NY).

% Processa tecla pressionada
processa_entrada(c, Matriz, X, Y, X, Y, NovaMatriz, Player, marcou) :-
    elemento_matriz(Matriz, X, Y, (1, 0)),
    substituir_elemento(Matriz, X, Y, (1, Player), NovaMatriz), !.

processa_entrada(Input, Matriz, X, Y, NX, NY, Matriz, _, continuar) :-
    movimento(Input, (DX, DY)),
    mover_ate_proximo(Matriz, X, Y, DX, DY, NX, NY),
    !.

processa_entrada(_, Matriz, X, Y, X, Y, Matriz, _, continuar).

processa_jogada(Matriz, X, Y, (TotRounds, StageNum, Player, P1, P2), NovaMatriz, Resultado, FX, FY) :-
    window:showGameData(TotRounds, StageNum, Player, P1, P2),
    board:boardGenerate((X, Y), Matriz),
    get_single_char(Input),
    char_code(Char, Input),
    processa_entrada(Char, Matriz, X, Y, NX, NY, Matriz1, Player, Resultado1),
    (
        Resultado1 = continuar ->
            processa_jogada(Matriz1, NX, NY, (TotRounds, StageNum, Player, P1, P2), NovaMatriz, Resultado, FX, FY)
        ;
        Resultado1 = marcou ->
            NovaMatriz = Matriz1,
            Resultado = marcou,
            FX = X,
            FY = Y
    ).

formou_moinho(Matriz, Player, X, Y) :-
    moinho(Moinhos),
    member(M, Moinhos),
    member((X,Y), M),
    forall(member((A,B), M), elemento_matriz(Matriz, A, B, (1, Player))).

remover_peca(Matriz, (TotRounds, StageNum, Player, P1, P2), NovaMatriz) :-
    adversario(Player, Adversario),
    encontra_posicoes_removiveis(Matriz, Adversario, PosicoesRemoviveis),
    (
        PosicoesRemoviveis = [] ->
            encontra_todas_pecas(Matriz, Adversario, Todas),
            [(X, Y) | _] = Todas  % Se todas forem de moinho, pega qualquer uma
        ;
            [(X, Y) | _] = PosicoesRemoviveis  % Começa na primeira removível
    ),
    processa_remocao(Matriz, X, Y, (TotRounds, StageNum, Player, P1, P2), NovaMatriz).

encontra_posicoes_removiveis(Matriz, Player, Posicoes) :-
    length(Matriz, Linhas),
    nth0(0, Matriz, PrimeiraLinha),
    length(PrimeiraLinha, Colunas),
    LimiteX is Linhas - 1,
    LimiteY is Colunas - 1,
    findall((X,Y),
        (
            between(0, LimiteX, X),
            between(0, LimiteY, Y),
            elemento_matriz(Matriz, X, Y, (1, Player)),
            \+ formou_moinho(Matriz, Player, X, Y)
        ),
        Posicoes).

encontra_todas_pecas(Matriz, Player, Posicoes) :-
    length(Matriz, Linhas),
    nth0(0, Matriz, PrimeiraLinha),
    length(PrimeiraLinha, Colunas),
    LimiteX is Linhas - 1,
    LimiteY is Colunas - 1,
    findall((X,Y),
        (
            between(0, LimiteX, X),
            between(0, LimiteY, Y),
            elemento_matriz(Matriz, X, Y, (1, Player))
        ),
        Posicoes).


escolher_posicao_para_remover([(X,Y)|_], X, Y).

adversario(1, 2).
adversario(2, 1).

processa_remocao(Matriz, X, Y, (TotRounds, StageNum, Player, P1, P2), NovaMatriz) :-
    adversario(Player, Adversario),
    window:showGameData(TotRounds, StageNum, Player, P1, P2),
    board:boardGenerate((X, Y), Matriz),
    get_single_char(Input),
    char_code(Char, Input),
    (
        movimento(Char, (DX, DY)) ->
            mover_ate_proximo(Matriz, X, Y, DX, DY, NX, NY),
            processa_remocao(Matriz, NX, NY, (TotRounds, StageNum, Player, P1, P2), NovaMatriz)
        ;
        Char = 'c' ->
            elemento_matriz(Matriz, X, Y, (1, Adversario)),
            (
                \+ formou_moinho(Matriz, Adversario, X, Y) ->
                    substituir_elemento(Matriz, X, Y, (1, 0), NovaMatriz)
                ;
                    encontra_posicoes_removiveis(Matriz, Adversario, Removiveis),
                    (
                        Removiveis = [] ->
                            substituir_elemento(Matriz, X, Y, (1, 0), NovaMatriz)
                        ;
                            processa_remocao(Matriz, X, Y, (TotRounds, StageNum, Player, P1, P2), NovaMatriz)
                    )
            )
        ;
            processa_remocao(Matriz, X, Y, (TotRounds, StageNum, Player, P1, P2), NovaMatriz)
    ).

moinho([
    [(0,0), (0,3), (0,6)],
    [(1,1), (1,3), (1,5)],
    [(2,2), (2,3), (2,4)],
    [(3,0), (3,1), (3,2)],
    [(3,4), (3,5), (3,6)],
    [(4,2), (4,3), (4,4)],
    [(5,1), (5,3), (5,5)],
    [(6,0), (6,3), (6,6)],
    [(0,0), (3,0), (6,0)],
    [(1,1), (3,1), (5,1)],
    [(2,2), (3,2), (4,2)],
    [(0,3), (1,3), (2,3)],
    [(4,3), (5,3), (6,3)],
    [(2,4), (3,4), (4,4)],
    [(1,5), (3,5), (5,5)],
    [(0,6), (3,6), (6,6)]
]).