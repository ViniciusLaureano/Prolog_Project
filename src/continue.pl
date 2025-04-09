:- module(continue, []).
:- use_module(library(http/json)).
:- use_module("./src/stages.pl").

saveInterruptedGame(Matrix, TotRounds, (Player, P1, P2), Phase, Mill, IsBot) :-
  matrix_to_json(Matrix, JsonMatrix),
	buildState(JsonMatrix, TotRounds, (Player, P1, P2), Phase, Mill, IsBot, State),
	open("./src/json/saveGame.json", write, SaveGame),
	json_write_dict(SaveGame, State, [width(0)]),
	close(SaveGame).

continueGame() :- 
	exists_file("./src/json/saveGame.json"),
	open("./src/json/saveGame.json", read, SaveGame),
	json_read_dict(SaveGame, GameState, [tag(atom)]),
	close(SaveGame),
	matrix_from_json(GameState.gameBoard, RealMatrix),
	Players = GameState.players,
	Players = [Player, P1, P2],
	stageCalling(_{
		gameBoard: RealMatrix,
		rounds: GameState.rounds,
		players: [Player, P1, P2],
		phase: GameState.phase,
		mill: GameState.mill,
		bot: GameState.bot
	}, GameState.phase).

buildState(Matrix, TotRounds, (Player, P1, P2), Phase, Mill, IsBot, State) :-
	State = _{
		gameBoard: Matrix,
		rounds: TotRounds,
		players: [Player, P1, P2],
		phase: Phase,
		mill: Mill,
		bot: IsBot
	}.

stageCalling(State, "Phase1") :- 
    State.players = [Player, P1, P2],
    stages:stage1(State.gameBoard, State.rounds, (Player, P1, P2), State.mill, State.bot).
stageCalling(State, "Phase2") :- 
    State.players = [Player, P1, P2],
    stages:stage2(State.gameBoard, State.rounds, (Player, P1, P2), State.mill, State.bot).
stageCalling(State, "Phase3") :- 
    State.players = [Player, P1, P2],
    stages:stage3(State.gameBoard, State.rounds, (Player, P1, P2), State.mill, State.bot).

cell_to_json((X, Y), [X, Y]) :- !.
cell_to_json(Value, Value).

% Converte uma linha inteira da matriz
row_to_json(Row, JsonRow) :-
	maplist(cell_to_json, Row, JsonRow).

% Converte a matriz completa
matrix_to_json(Matrix, JsonMatrix) :-
	maplist(row_to_json, Matrix, JsonMatrix).

cell_from_json([X, Y], (X, Y)) :- !.
cell_from_json(Value, Value).

% Converte linha
row_from_json(Row, PrologRow) :-
	maplist(cell_from_json, Row, PrologRow).

% Converte matriz completa
matrix_from_json(JsonMatrix, PrologMatrix) :-
	maplist(row_from_json, JsonMatrix, PrologMatrix).