:- module(history, []).
:- use_module(library(http/json)).
:- use_module("./src/continue.pl").
:- use_module("./src/window.pl").
:- use_module("./src/board.pl").


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
    continue:matrix_to_json(Matrix, FormatedMatrix),
    window:limparTela,
    window:centralizarV(2),
    ( Winner = 1 -> Vencedor = P1 ; Vencedor = P2 ),
    format(atom(Mensagem), 'Parabéns ~w por vencer!!!', [Vencedor]),
    window:centralizarH(Mensagem),
    window:centralizarH('Aperte qualquer tecla para continuar...'),
    get_single_char(_),
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


tela_historico :-
	File = "./src/json/saveHistory.json",
	mostrar_historico(File).

mostrar_historico(File) :-
	read_history(File, History),
	mostrar_jogos(History, 1).

mostrar_jogos([], _).
mostrar_jogos([Jogo | Resto], Index) :-
  window:limparTela,
	Jogo.players = [P1, P2],
	TotRounds = Jogo.totRounds,
  Matrix = Jogo.matrix,
  continue:matrix_from_json(Matrix, FormatedMatrix),
  ( Winner = 1 -> Vencedor = P1 ; Vencedor = P2 ),
	format(atom(Mensagem1), "Game #~d", [Index]),
	format(atom(Mensagem2), "Players: ~w vs ~w", [P1, P2]),
	format(atom(Mensagem3), "Winner: ~w", [Vencedor]),
	format(atom(Mensagem4), "Total de Rodadas: ~d", [TotRounds]),
  window:centralizarH(Mensagem1),
  window:centralizarH(Mensagem2),
  window:centralizarH(Mensagem3),
  window:centralizarH(Mensagem4),
  board:boardGenerate((-9999, -9999), FormatedMatrix, 5),
  window:centralizarH(''),
  window:centralizarH('Aperte qualquer tecla para continuar...'),
  get_single_char(_),
	NextIndex is Index + 1,
	mostrar_jogos(Resto, NextIndex).