:- module(board, []).
:- use_module("./src/window.pl").

imprimeTabuleiro((X, Y), Matriz) :-
        window:centralizarV(18),
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