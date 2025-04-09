:- module(history, []).
:- use_module(library(http/json)).
:- use_module("./src/continue.pl").


read_history(File, []) :- exists_file(File), !.
read_history(File, History) :-
    exists_file(File),
    open(File, read, Stream),
    json_read_dict(Stream, History),
    close(Stream), !.

append_history(NewState, File) :-
    read_history(File, History),
    append(History, [NewState], UpdatedHistory),
    open(File, write, Stream),
    json_write_dict(Stream, UpdatedHistory, [width(0)]),
    close(Stream).

saveFinalGame(Matrix, TotRounds, Winner, (P1, P2), IsBot) :-
    continue:matrix_to_json(Matrix, FormatedMatrix),
    buildFinalState(FormatedMatrix, TotRounds, Winner, (P1, P2), IsBot, State),
    append_history(State, "./src/json/saveHistory.json").

buildFinalState(Matrix, TotRounds, Winner, (P1, P2), IsBot, State) :-
    State = _{
        matrix: Matrix,
        totRounds: TotRounds,
        winner: Winner,
        players: [P1, P2],
        isBot: IsBot
    }.

