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