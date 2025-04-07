:- module(history, []).

read_history(File, History) :-
    exists_file(File),
    open(File, read, Stream),
    json_read_dict(Stream, History),
    close(Stream), !.

read_history(_, []).

append_history(NewState, File) :-
    read_history(File, History),
    append(History, [NewState], UpdatedHistory),
    open(File, write, Stream),
    json_write_dict(Stream, UpdatedHistory, [width(0)]),
    close(Stream).

saveFinalGame(Matrix, TotRounds, Winner, (P1, P2), IsBot) :-
    buildState(Matrix, TotRounds, Winner, (P1, P2), Stage, Mill, IsBot, State),
    append_history(State, "./src/json/saveHistory.json").

buildFinalState(Matrix, TotRounds, Winner, (P1, P2), IsBot, State) :-
    State = state{
        matrix: Matrix,
        totRounds: TotRounds,
        winner: Winner
        players: (P1, P2),
        isBot: IsBot
    }.

