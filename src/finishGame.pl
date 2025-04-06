:- module(finishGame, []).

finishGame(Matrix, TotRounds, (Player, P1, P2), IsBot) :- 
    buildHistoryState(Matrix, TotRounds, (Player, P1, P2), IsBot, HistoryState),
    read_history("./json/saveHistory.json", CurrentHistory),
    append_history(HistoryState, CurrentHistory).

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

buildHistoryState(Matrix, TotRounds, (Player, P1, P2), IsBot, State) :-
    State = state{
        matrix: Matrix,
        totRounds: TotRounds,
        players: (Player, P1, P2),
        isBot: IsBot
    }.

