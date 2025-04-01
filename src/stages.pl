:- module(stages, []).

:- use_module("./src/validations.pl").
:- use_module("./src/finishGame.pl").
:- use_module("./src/window.pl").
:- use_module("./src/board.pl").
:- use_module("./stagesFunctions/functions1.pl").

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
    %window:showGameData(TotRounds, 2, Player, P1, P2),
    %board:boardGenerate((1, 1), Matriz),
    %get_single_char(Input),
    functions1:move_cursor(Matriz, 0, 0),
    NewTotRounds is TotRounds + 1,
    (Player = 1 -> NovoPlayer is 2; NovoPlayer is 1),
    stage1(Matriz, NewTotRounds, (NovoPlayer, P1, P2), Mill, IsBot).



stage2(Matriz, TotRounds, (Player, P1, P2), Mill, IsBot) :-
    window:showGameData(TotRounds, 2, Player, P1, P2),
    board:boardGenerate((1, 1), Matriz),
    get_single_char(Input).


stage3(Matriz, TotRounds, (Player, P1, P2), Mill, IsBot) :-
    window:showGameData(TotRounds, 3, Player, P1, P2),
    board:boardGenerate((1, 1), Matriz),
    get_single_char(Input).
