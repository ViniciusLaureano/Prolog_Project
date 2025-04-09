:- module(functions3, []).

:- use_module("./src/board.pl").
:- use_module("./src/window.pl").

processa_jogada_stage3(Matriz, X, Y, (TotRounds, StageNum, Player, P1, P2), Estado, NovaMatriz, marcou, FX, FY, FormouMoinho) :-
    window:showGameData(TotRounds, StageNum, Player, P1, P2),
    board:boardGenerate((X, Y), Matriz, 4),
    get_single_char(Input),
    char_code(Char, Input),
    (
        functions1:movimento(Char, (DX, DY)) ->
            functions1:mover_ate_proximo(Matriz, X, Y, DX, DY, NX, NY),
            processa_jogada_stage3(Matriz, NX, NY, (TotRounds, StageNum, Player, P1, P2), Estado, NovaMatriz, marcou, FX, FY, FormouMoinho)
        ;
        Char = 'c' ->
            functions1:elemento_matriz(Matriz, X, Y, (1, Player)),
            selecionar_destino_stage3(Matriz, X, Y, (TotRounds, StageNum, Player, P1, P2), Estado, MatrizMovida, ResultadoMov, MX, MY),
            (
                ResultadoMov = marcou ->
                    (functions1:formou_moinho(MatrizMovida, Player, MX, MY) -> FormouMoinho = true ; FormouMoinho = false),
                    NovaMatriz = MatrizMovida,
                    FX = MX,
                    FY = MY
                ;
                    processa_jogada_stage3(Matriz, X, Y, (TotRounds, StageNum, Player, P1, P2), Estado, NovaMatriz, marcou, FX, FY, FormouMoinho)
            )
        ;
            processa_jogada_stage3(Matriz, X, Y, (TotRounds, StageNum, Player, P1, P2), Estado, NovaMatriz, marcou, FX, FY, FormouMoinho)
    ).

selecionar_destino_stage3(Matriz, OrigX, OrigY, (TotRounds, StageNum, Player, P1, P2), Estado, NovaMatriz, Resultado, FX, FY) :-
    window:showGameData(TotRounds, StageNum, Player, P1, P2),
    board:boardGenerate((OrigX, OrigY), Matriz, 4),
    contar_pecas_jogador(Player, Matriz, Count),
    (
        Count =:= 3 ->
            findall((X, Y),
                (
                    between(0, 6, X),
                    between(0, 6, Y),
                    functions1:elemento_matriz(Matriz, X, Y, (1, 0))
                ),
            Possiveis)
        ;
            findall((AX, AY),
                (
                    functions2:adjacente((OrigX, OrigY), (AX, AY)),
                    functions1:elemento_matriz(Matriz, AX, AY, (1, 0))
                ),
                Possiveis)
    ),
    Possiveis \= [],
    functions2:loop_destino(Matriz, OrigX, OrigY, (TotRounds, StageNum, Player, P1, P2), Possiveis, 0, Estado, NovaMatriz, Resultado, FX, FY).

contar_pecas_jogador(Player, Matriz, Count) :-
    flatten(Matriz, Flattened),
    include(==( (1, Player) ), Flattened, P),
    length(P, Count).