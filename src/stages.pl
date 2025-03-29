:- module(stages, []).

:- use_module("./src/validations.pl").
:- use_module("./src/finishGame.pl").
:- use_module("./src/window.pl").
:- use_module("./src/board.pl").

stage1(Matriz, TotRounds, (Player, P1, P2), Mill, IsBot) :-
    validations:validateStage1(TotRounds),
    stage2(Matriz, TotRounds, (Player, P1, P2), Mill, IsBot), !.


stage2(Matriz, TotRounds, (Player, P1, P2), Mill, IsBot) :-
    validations:validateStage2(Matriz, Player),
    stage3(Matriz, TotRounds, (Player, P1, P2), Mill, IsBot), !.


stage3(Matriz, TotRounds, (Player, P1, P2), Mill, IsBot) :-
    validations:validateStage3(Matriz),
    finishGame:finishGame(Matriz, TotRounds, (Player, P1, P2), IsBot), !.




stage1(Matriz, TotRounds, (Player, P1, P2), Mill, IsBot) :-
    window:showGameData(TotRounds, 1, Player, P1, P2),
    board:boardGenerate((1, 1), Matriz),
    get_single_char(Input).


stage2(Matriz, TotRounds, (Player, P1, P2), Mill, IsBot) :-
    window:showGameData(TotRounds, 2, Player, P1, P2),
    board:boardGenerate((1, 1), Matriz),
    get_single_char(Input).


stage3(Matriz, TotRounds, (Player, P1, P2), Mill, IsBot) :-
    window:showGameData(TotRounds, 3, Player, P1, P2),
    board:boardGenerate((1, 1), Matriz),
    get_single_char(Input).
