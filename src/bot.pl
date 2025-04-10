:- module(bot, []).
:- use_module(library(random)).
:- use_module("./stagesFunctions/functions1.pl").
:- use_module("./stagesFunctions/functions2.pl").

escolher_posicao_bot(Matriz, Player, X, Y) :-
    findall((PX, PY),
        (
            nth0(PX, Matriz, Linha),
            nth0(PY, Linha, (1, 0))
        ),
        PosicoesLivres),
    random_member((X, Y), PosicoesLivres).

remover_peca_bot(Matriz, Player, NovaMatriz) :-
    functions1:adversario(Player, Adversario),
    functions1:encontra_posicoes_removiveis(Matriz, Adversario, Removiveis),
    (
        Removiveis \= [] ->
            random_member((X, Y), Removiveis)
        ;
            functions1:encontra_todas_pecas(Matriz, Adversario, Todas),
            random_member((X, Y), Todas)
    ),
    functions1:substituir_elemento(Matriz, X, Y, (1, 0), NovaMatriz).

escolher_peca_para_mover(Matriz, Player, (X, Y)) :-
    findall((PX, PY),
        (
            functions1:elemento_matriz(Matriz, PX, PY, (1, Player)),
            functions2:adjacente((PX, PY), (AX, AY)),
            functions1:elemento_matriz(Matriz, AX, AY, (1, 0))
        ),
        Possiveis),
    random_member((X, Y), Possiveis).

escolher_destino_para_peca(Matriz, (OrigX, OrigY), (DestX, DestY)) :-
    findall((AX, AY),
        (
            functions2:adjacente((OrigX, OrigY), (AX, AY)),
            functions1:elemento_matriz(Matriz, AX, AY, (1, 0))
        ),
        Destinos),
    random_member((DestX, DestY), Destinos).

bot_jogando(1, false).
bot_jogando(2, true).