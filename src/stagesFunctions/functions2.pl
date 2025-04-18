:- module(functions2, []).

:- use_module("./src/board.pl").
:- use_module("./src/window.pl").

adjacente((0,3), (0,0)).
adjacente((0,3), (0,6)).
adjacente((0,3), (1,3)).

adjacente((0,0), (0,3)).
adjacente((0,0), (3,0)).

adjacente((0,6), (0,3)).
adjacente((0,6), (3,6)).

adjacente((1,1), (1,3)).
adjacente((1,1), (3,1)).

adjacente((1,5), (1,3)).
adjacente((1,5), (3,5)).

adjacente((2,2), (2,3)).
adjacente((2,2), (3,2)).

adjacente((2,4), (2,3)).
adjacente((2,4), (3,4)).

adjacente((1,3), (0,3)).
adjacente((1,3), (1,1)).
adjacente((1,3), (1,5)).
adjacente((1,3), (2,3)).

adjacente((2,3), (2,2)).
adjacente((2,3), (2,4)).
adjacente((2,3), (1,3)).

adjacente((3,0), (0,0)).
adjacente((3,0), (3,1)).
adjacente((3,0), (6,0)).

adjacente((3,1), (1,1)).
adjacente((3,1), (3,0)).
adjacente((3,1), (5,1)).
adjacente((3,1), (3,2)).

adjacente((3,2), (2,2)).
adjacente((3,2), (3,1)).
adjacente((3,2), (4,2)).

adjacente((3,4), (2,4)).
adjacente((3,4), (4,4)).
adjacente((3,4), (3,5)).

adjacente((3,5), (1,5)).
adjacente((3,5), (3,4)).
adjacente((3,5), (5,5)).
adjacente((3,5), (3,6)).

adjacente((3,6), (0,6)).
adjacente((3,6), (3,5)).
adjacente((3,6), (6,6)).

adjacente((4,2), (3,2)).
adjacente((4,2), (4,3)).

adjacente((4,4), (3,4)).
adjacente((4,4), (4,3)).

adjacente((4,3), (4,2)).
adjacente((4,3), (5,3)).
adjacente((4,3), (4,4)).

adjacente((5,1), (3,1)).
adjacente((5,1), (5,3)).

adjacente((5,5), (3,5)).
adjacente((5,5), (5,3)).

adjacente((5,3), (4,3)).
adjacente((5,3), (5,1)).
adjacente((5,3), (5,5)).
adjacente((5,3), (6,3)).

adjacente((6,0), (3,0)).
adjacente((6,0), (6,3)).

adjacente((6,3), (6,0)).
adjacente((6,3), (6,6)).
adjacente((6,3), (5,3)).

adjacente((6,6), (3,6)).
adjacente((6,6), (6,3)).

bot_jogada_stage2(Matriz, Player, NovaMatriz, Resultado, FX, FY, FormouMoinho) :-
    encontra_pecas(Matriz, Player, Pecas),
    include(possui_movimento(Matriz), Pecas, Moviveis),
    random_member((OrigX, OrigY), Moviveis),
    findall((AX, AY),
        (
            adjacente((OrigX, OrigY), (AX, AY)),
            functions1:elemento_matriz(Matriz, AX, AY, (1, 0))
        ),
        Possiveis),

    random_member((DestX, DestY), Possiveis),
    functions1:substituir_elemento(Matriz, OrigX, OrigY, (1, 0), Temp),
    functions1:substituir_elemento(Temp, DestX, DestY, (1, Player), NovaMatriz),
    Resultado = marcou,
    FX = DestX,
    FY = DestY,
    (functions1:formou_moinho(NovaMatriz, Player, FX, FY) -> FormouMoinho = true ; FormouMoinho = false).

possui_movimento(Matriz, (X, Y)) :-
    adjacente((X, Y), (AX, AY)),
    functions1:elemento_matriz(Matriz, AX, AY, (1, 0)).

processa_jogada_stage2(Matriz, _, _, (_, _, 2, _, _), _, NovaMatriz, Resultado, FX, FY, FormouMoinho, true) :-
    bot_jogada_stage2(Matriz, 2, NovaMatriz, Resultado, FX, FY, FormouMoinho), !.

processa_jogada_stage2(Matriz, X, Y, (TotRounds, StageNum, Player, P1, P2), Estado, NovaMatriz, Resultado, FX, FY, FormouMoinho, IsBot) :-
    window:showGameData(TotRounds, StageNum, Player, P1, P2),
    board:boardGenerate((X, Y), Matriz, 4),
    get_single_char(Input),
    char_code(Char, Input),
    (
        Char = 'q' ->
            Resultado = stop,
            NovaMatriz = Matriz,
            FX = X,
            FY = Y,
            FormouMoinho = false
    ;
        functions1:movimento(Char, (DX, DY)) ->
            ( functions1:mover_ate_proximo(Matriz, X, Y, DX, DY, NX, NY),
               (NX \= X ; NY \= Y) ->
                processa_jogada_stage2(Matriz, NX, NY, (TotRounds, StageNum, Player, P1, P2), Estado, NovaMatriz, Resultado, FX, FY, FormouMoinho, IsBot)
            ;
                processa_jogada_stage2(Matriz, X, Y, (TotRounds, StageNum, Player, P1, P2), Estado, NovaMatriz, Resultado, FX, FY, FormouMoinho, IsBot)
            )
    ;
        Char = 'c' ->
            ( functions1:elemento_matriz(Matriz, X, Y, (1, Player)) ->
                selecionar_destino(Matriz, X, Y, (TotRounds, StageNum, Player, P1, P2), Estado, MatrizMovida, ResultadoMov, MX, MY),
                (
                    ResultadoMov = marcou ->
                        ( functions1:formou_moinho(MatrizMovida, Player, MX, MY) -> FormouMoinho = true ; FormouMoinho = false ),
                        NovaMatriz = MatrizMovida,
                        Resultado = marcou,
                        FX = MX,
                        FY = MY
                    ;
                        processa_jogada_stage2(Matriz, X, Y, (TotRounds, StageNum, Player, P1, P2), Estado, NovaMatriz, Resultado, FX, FY, FormouMoinho, IsBot)
                )
            ;
                processa_jogada_stage2(Matriz, X, Y, (TotRounds, StageNum, Player, P1, P2), Estado, NovaMatriz, Resultado, FX, FY, FormouMoinho, IsBot)
            )
    ;
        processa_jogada_stage2(Matriz, X, Y, (TotRounds, StageNum, Player, P1, P2), Estado, NovaMatriz, Resultado, FX, FY, FormouMoinho, IsBot)
    ).


selecionar_destino(Matriz, OrigX, OrigY, (TotRounds, StageNum, Player, P1, P2), Estado, NovaMatriz, Resultado, FX, FY) :-
    findall((AX, AY),
        (
            adjacente((OrigX, OrigY), (AX, AY)),
            functions1:elemento_matriz(Matriz, AX, AY, (1, 0))
        ),
        Possiveis),
    Possiveis \= [],
    loop_destino(Matriz, OrigX, OrigY, (TotRounds, StageNum, Player, P1, P2), Possiveis, 0, Estado, NovaMatriz, Resultado, FX, FY).



loop_destino(Matriz, OrigX, OrigY, (TotRounds, StageNum, Player, P1, P2), Possiveis, I, Estado, NovaMatriz, Resultado, FX, FY) :-
    nth0(I, Possiveis, (X, Y)),
    window:showGameData(TotRounds, StageNum, Player, P1, P2),
    board:boardGenerate((X, Y), Matriz, 4),
    get_single_char(Input),
    char_code(Char, Input),
    length(Possiveis, Len),
    (
        Char = 'c' ->
            Estado = (_, _, Player, _, _),
            functions1:substituir_elemento(Matriz, OrigX, OrigY, (1, 0), Temp),
            functions1:substituir_elemento(Temp, X, Y, (1, Player), NovaMatriz),
            Resultado = marcou,
            FX = X,
            FY = Y
        ;
        Char = 'a' -> 
            I1 is (I - 1 + Len) mod Len,
            loop_destino(Matriz, OrigX, OrigY, (TotRounds, StageNum, Player, P1, P2), Possiveis, I1, Estado, NovaMatriz, Resultado, FX, FY)
        ;
        Char = 'd' -> 
            I1 is (I + 1) mod Len,
            loop_destino(Matriz, OrigX, OrigY, (TotRounds, StageNum, Player, P1, P2), Possiveis, I1, Estado, NovaMatriz, Resultado, FX, FY)
        ;
            loop_destino(Matriz, OrigX, OrigY, (TotRounds, StageNum, Player, P1, P2), Possiveis, I, Estado, NovaMatriz, Resultado, FX, FY)
    ).

encontra_pecas(Matriz, Player, Pecas) :-
    length(Matriz, NumLinhas),
    nth0(0, Matriz, PrimeiraLinha),
    length(PrimeiraLinha, NumColunas),
    LimLin is NumLinhas - 1,
    LimCol is NumColunas - 1,
    findall((X, Y),
        (
            between(0, LimLin, X),
            between(0, LimCol, Y),
            functions1:elemento_matriz(Matriz, X, Y, (1, Player))
        ),
        Pecas).