:- module(window, []).

limparTela :-
    write('\e[H\e[J').

terminalWidth(Width) :-
    setup_call_cleanup(
        open(pipe('tput cols'), read, Stream),
        read_line_to_codes(Stream, Codes),
        close(Stream)
    ),
    atom_codes(Atom, Codes),
    atom_number(Atom, Width).

terminalWidth(Width) :-
    Width is 80.

terminalHeight(Height) :-
    setup_call_cleanup(
        open(pipe('tput lines'), read, Stream),
        read_line_to_codes(Stream, Codes),
        close(Stream)
    ),
    atom_codes(Atom, Codes),
    atom_number(Atom, Height).

terminalHeight(Height) :-
    Height is 24.

centralizarH(Texto) :-
    terminalWidth(Width),
    string_length(Texto, Len),
    Spaces is max(0, (Width - Len) // 2),
    tab(Spaces), write(Texto), nl.


centralizarV(Linhas) :-
    terminalHeight(Height),
    EmptyLines is max(0, (Height - Linhas) // 2),
    forall(between(1, EmptyLines, _), nl).

centralizarInput(Prompt, Input) :-
    terminalWidth(Width),
    string_length(Prompt, Len),
    Spaces is max(0, (Width - Len) // 2),
    nl, tab(Spaces), write(Prompt), flush_output,
    read_line_to_string(user_input, Input).


showGameData(TotRound, StageNum, Player, Player1, Player2) :-
    format(atom(Stage), 'Fase ~w', [StageNum]),
    format(atom(Rounds), 'Rodada: ~w', [TotRound]),

    (Player =:= 1 -> CurrentPlayer = Player1 ; CurrentPlayer = Player2),

    limparTela,

    centralizarH(Rounds),
    centralizarH(Stage),
    centralizarH(CurrentPlayer).

drawPiece(Y, X, Str) :-
    terminalHeight(Height),
    terminalWidth(Width),
    PosX is ((Width - 36) // 2) + (X * 6),
    PosY is 4 + ((Height - 20) // 2) + (Y * 3),
    moveCursor(PosY, PosX),
    write(Str),
    moveCursorEnd.

moveCursor(Row, Col) :-
    format('\e[~d;~dH', [Row, Col]).

moveCursorEnd :-
    terminalHeight(Height),
    moveCursor(Height, 1).