:- module(finishGame, []).
:- use_module("./src/history.pl").

saveGameToHistory(Matrix, TotRounds, (Player, P1, P2), IsBot) :- 
    history:saveFinalGame(Matrix, TotRounds, Player, (P1, P2), IsBot).


