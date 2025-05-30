:- module(functions3, []).

:- use_module("./src/board.pl").
:- use_module("./src/window.pl").

bot_jogada_stage3(Matriz, _, _, Player, NovaMatriz, marcou, FX, FY, FormouMoinho) :-
    contar_pecas_jogador(Player, Matriz, Count),
    findall((X, Y),
        (
            between(0, 6, X),
            between(0, 6, Y),
            functions1:elemento_matriz(Matriz, X, Y, (1, Player))
        ),
        Pecas),

    once((
        random_permutation(Pecas, PecasEmbaralhadas),
        member((OrigX, OrigY), PecasEmbaralhadas),
        (
            Count =:= 3 ->
                findall((DX, DY),
                    (
                        between(0, 6, DX),
                        between(0, 6, DY),
                        functions1:elemento_matriz(Matriz, DX, DY, (1, 0))
                    ),
                    Destinos)
            ;
                findall((DX, DY),
                    (
                        functions2:adjacente((OrigX, OrigY), (DX, DY)),
                        functions1:elemento_matriz(Matriz, DX, DY, (1, 0))
                    ),
                    Destinos)
        ),
        random_permutation(Destinos, DestinosEmbaralhados),
        member((DestX, DestY), DestinosEmbaralhados),
        realizar_movimento(Matriz, OrigX, OrigY, DestX, DestY, Player, MatrizMovida),
        (functions1:formou_moinho(MatrizMovida, Player, DestX, DestY) -> FormouMoinho = true ; FormouMoinho = false),
        NovaMatriz = MatrizMovida,
        FX = DestX,
        FY = DestY
    )).


processa_jogada_stage3(Matriz, X, Y, (_, _, 2, _, _), _, NovaMatriz, Resultado, FX, FY, FormouMoinho, true) :-
    bot_jogada_stage3(Matriz, X, Y, 2, NovaMatriz, Resultado, FX, FY, FormouMoinho), !.

processa_jogada_stage3(Matriz, X, Y, (TotRounds, StageNum, Player, P1, P2), Estado, NovaMatriz, Resultado, FX, FY, FormouMoinho, false) :-
    window:showGameData(TotRounds, StageNum, Player, P1, P2),
    board:boardGenerate((X, Y), Matriz, 4),
    get_single_char(Input),
    char_code(Char, Input),
    (
        Char = 'q' ->
            NovaMatriz = Matriz,
            FX = X,
            FY = Y,
            Resultado = stop,
            FormouMoinho = false

        ; functions1:movimento(Char, (DX, DY)) ->
            ( functions1:mover_ate_proximo(Matriz, X, Y, DX, DY, NX, NY),
              (NX \= X ; NY \= Y) ->
                processa_jogada_stage3(Matriz, NX, NY, (TotRounds, StageNum, Player, P1, P2), Estado, NovaMatriz, Resultado, FX, FY, FormouMoinho, false)
            ;
                processa_jogada_stage3(Matriz, X, Y, (TotRounds, StageNum, Player, P1, P2), Estado, NovaMatriz, Resultado, FX, FY, FormouMoinho, false)
            )

        ; Char = 'c' ->
            ( functions1:elemento_matriz(Matriz, X, Y, (1, Player)) ->
                selecionar_destino_stage3(Matriz, X, Y, (TotRounds, StageNum, Player, P1, P2), Estado, MatrizMovida, ResultadoMov, MX, MY),
                ( ResultadoMov = marcou ->
                    (functions1:formou_moinho(MatrizMovida, Player, MX, MY) -> FormouMoinho = true ; FormouMoinho = false),
                    NovaMatriz = MatrizMovida,
                    FX = MX,
                    FY = MY,
                    Resultado = marcou
                ;
                    processa_jogada_stage3(Matriz, X, Y, (TotRounds, StageNum, Player, P1, P2), Estado, NovaMatriz, Resultado, FX, FY, FormouMoinho, false)
                )
            ;
            
                processa_jogada_stage3(Matriz, X, Y, (TotRounds, StageNum, Player, P1, P2), Estado, NovaMatriz, Resultado, FX, FY, FormouMoinho, false)
            )

        ;  
            processa_jogada_stage3(Matriz, X, Y, (TotRounds, StageNum, Player, P1, P2), Estado, NovaMatriz, Resultado, FX, FY, FormouMoinho, false)
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

realizar_movimento(Matriz, OX, OY, DX, DY, Player, NovaMatriz) :-
    functions1:substituir_elemento(Matriz, OX, OY, (1, 0), TempMatriz),
    functions1:substituir_elemento(TempMatriz, DX, DY, (1, Player), NovaMatriz).
