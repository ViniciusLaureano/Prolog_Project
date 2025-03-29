:- module(validations, []).

validateStage1(TotRounds) :- TotRounds >= 19.

validateStage2(Matriz, Player) :- 
    playerPieces(Matriz, Player, TotPieces),
    TotPieces =< 3.

validateStage3(Matriz) :- 
    playerPieces(Matriz, 1, TotPieces),
    TotPieces =:= 2.

validateStage3(Matriz) :- 
    playerPieces(Matriz, 2, TotPieces),
    TotPieces =:= 2.

playerPieces(Matriz, Player, TotPieces) :-
    findall((1, Player), (member(Linha, Matriz), member((1, Player), Linha)), Pecas),
    length(Pecas, TotPieces).