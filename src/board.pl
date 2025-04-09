:- module(board, []).
:- use_module("./src/window.pl").

boardGenerate((X, Y), Matriz, ExtraLines) :-
    boardBody,
    findPieces(Matriz),
    drawPointer(X, Y, ExtraLines).

findPieces(Matriz) :-
    findCellsWithValue(Matriz, 1, Result1),
    findCellsWithValue(Matriz, 2, Result2),
    iterateDrawPiece(Result1, 1),
    iterateDrawPiece(Result2, 2).
    
iterateDrawPiece([], _).
iterateDrawPiece([(X, Y)|T], Player) :-
    window:drawPiece(X, Y, Player, 4),
    iterateDrawPiece(T, Player).


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