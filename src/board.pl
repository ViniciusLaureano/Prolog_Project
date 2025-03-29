:- module(board, []).

imprimeTabuleiro((X, Y), Matriz) :-
        write(" *━━━━━━━━━━━━━━━━━*━━━━━━━━━━━━━━━━━*"), nl,
        write(" ┃                 ┃                 ┃"), nl,
        write(" ┃                 ┃                 ┃"), nl,
        write(" ┃     *━━━━━━━━━━━*━━━━━━━━━━━*     ┃"), nl, 
        write(" ┃     ┃           ┃           ┃     ┃"), nl,
        write(" ┃     ┃           ┃           ┃     ┃"), nl,
        write(" ┃     ┃     *━━━━━*━━━━━*     ┃     ┃"), nl,
        write(" ┃     ┃     ┃           ┃     ┃     ┃"), nl,
        write(" ┃     ┃     ┃           ┃     ┃     ┃"), nl,
        write(" *━━━━━*━━━━━*           *━━━━━*━━━━━*"), nl,
        write(" ┃     ┃     ┃           ┃     ┃     ┃"), nl,
        write(" ┃     ┃     ┃           ┃     ┃     ┃"), nl,
        write(" ┃     ┃     *━━━━━*━━━━━*     ┃     ┃"), nl,
        write(" ┃     ┃           ┃           ┃     ┃"), nl,
        write(" ┃     ┃           ┃           ┃     ┃"), nl,
        write(" ┃     *━━━━━━━━━━━*━━━━━━━━━━━*     ┃"), nl,
        write(" ┃                 ┃                 ┃"), nl,
        write(" ┃                 ┃                 ┃"), nl,
        write(" *━━━━━━━━━━━━━━━━━*━━━━━━━━━━━━━━━━━*"), nl,
    ).