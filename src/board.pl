:- module(board, []).
:- use_module("./src/window.pl").

boardGenerate((X, Y), Matriz) :-
    boardBody,
    findPieces(Matriz, 1, 1),
    drawPointer(X, Y).

findPieces([], _, _).
findPieces([H|T], I, J).

drawPointer(X, Y).

boardBody() :-
    window:centralizarV(20),
    window:centralizarH(" *━━━━━━━━━━━━━━━━━*━━━━━━━━━━━━━━━━━*"),
    window:centralizarH(" ┃                 ┃                 ┃"),
    window:centralizarH(" ┃                 ┃                 ┃"),
    window:centralizarH(" ┃     *━━━━━━━━━━━*━━━━━━━━━━━*     ┃"),
    window:centralizarH(" ┃     ┃           ┃           ┃     ┃"),
    window:centralizarH(" ┃     ┃           ┃           ┃     ┃"),
    window:centralizarH(" ┃     ┃     *━━━━━*━━━━━*     ┃     ┃"),
    window:centralizarH(" ┃     ┃     ┃           ┃     ┃     ┃"),
    window:centralizarH(" ┃     ┃     ┃           ┃     ┃     ┃"),
    window:centralizarH(" *━━━━━*━━━━━*           *━━━━━*━━━━━*"),
    window:centralizarH(" ┃     ┃     ┃           ┃     ┃     ┃"),
    window:centralizarH(" ┃     ┃     ┃           ┃     ┃     ┃"),
    window:centralizarH(" ┃     ┃     *━━━━━*━━━━━*     ┃     ┃"),
    window:centralizarH(" ┃     ┃           ┃           ┃     ┃"),
    window:centralizarH(" ┃     ┃           ┃           ┃     ┃"),
    window:centralizarH(" ┃     *━━━━━━━━━━━*━━━━━━━━━━━*     ┃"),
    window:centralizarH(" ┃                 ┃                 ┃"),
    window:centralizarH(" ┃                 ┃                 ┃"),
    window:centralizarH(" *━━━━━━━━━━━━━━━━━*━━━━━━━━━━━━━━━━━*").