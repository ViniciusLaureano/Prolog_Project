:- module(board, []).
:- use_module("./src/window.pl").

boardGenerate((X, Y), Matriz, ExtraLines) :-
    boardBody,
    findPieces(Matriz, ExtraLines),
    drawPointer(X, Y, ExtraLines).

findPieces(Matriz, ExtraLines) :-
    findCellsWithValue(Matriz, 1, Result1),
    findCellsWithValue(Matriz, 2, Result2),
    iterateDrawPiece(Result1, 1, ExtraLines),
    iterateDrawPiece(Result2, 2, ExtraLines).
    
iterateDrawPiece([], _, _).
iterateDrawPiece([(X, Y)|T], Player, ExtraLines) :-
    window:drawPiece(X, Y, Player, ExtraLines),
    iterateDrawPiece(T, Player, ExtraLines).

drawPointer(-9999, -9999, _) :- !.

drawPointer(X, Y, ExtraLines) :-
    window:drawPiece(X, Y, 'X', ExtraLines).

findCellsWithValue(Matriz, X, Result) :-
    findall((RowAjust, ColAjust), (nth1(Row, Matriz, Linha), nth1(Col, Linha, (1, X)), RowAjust is Row - 1, ColAjust is Col - 1), Result).

boardBody() :-
    window:centralizarV(20),
    window:centralizarH("*━━━━━━━━━━━━━━━━━*━━━━━━━━━━━━━━━━━*"),
    window:centralizarH("┃                 ┃                 ┃"),
    window:centralizarH("┃                 ┃                 ┃"),
    window:centralizarH("┃     *━━━━━━━━━━━*━━━━━━━━━━━*     ┃"),
    window:centralizarH("┃     ┃           ┃           ┃     ┃"),
    window:centralizarH("┃     ┃           ┃           ┃     ┃"),
    window:centralizarH("┃     ┃     *━━━━━*━━━━━*     ┃     ┃"),
    window:centralizarH("┃     ┃     ┃           ┃     ┃     ┃"),
    window:centralizarH("┃     ┃     ┃           ┃     ┃     ┃"),
    window:centralizarH("*━━━━━*━━━━━*           *━━━━━*━━━━━*"),
    window:centralizarH("┃     ┃     ┃           ┃     ┃     ┃"),
    window:centralizarH("┃     ┃     ┃           ┃     ┃     ┃"),
    window:centralizarH("┃     ┃     *━━━━━*━━━━━*     ┃     ┃"),
    window:centralizarH("┃     ┃           ┃           ┃     ┃"),
    window:centralizarH("┃     ┃           ┃           ┃     ┃"),
    window:centralizarH("┃     *━━━━━━━━━━━*━━━━━━━━━━━*     ┃"),
    window:centralizarH("┃                 ┃                 ┃"),
    window:centralizarH("┃                 ┃                 ┃"),
    window:centralizarH("*━━━━━━━━━━━━━━━━━*━━━━━━━━━━━━━━━━━*").