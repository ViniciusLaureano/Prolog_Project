:- module(continue, []).
:- use_module(library(http/json)).
:- use_module("./src/stages.pl").

saveInterruptedGame(Matrix, TotRounds, (Player, P1, P2), Stage, Mill, IsBot) :-
    buildState(Matrix, TotRounds, (Player, P1, P2), Stage, Mill, IsBot, State),
    open("./src/json/saveGame.json", write, SaveGame),
    json_write_dict(SaveGame, State, [width(0)]),
    close(SaveGame).

continueGame() :- 
    exists_file("./src/json/saveGame.json"),
    open("./src/json/saveGame.json", read, SaveGame),
    json_read_dict(SaveGame, GameState),
    close(SaveGame),

    get_dict(stage, GameState, Stage),
    StoppedStage = Stage.stage,
    stageCalling(Stage, StoppedStage).

buildState(Matrix, TotRounds, (Player, P1, P2), Stage, Mill, IsBot, State) :-
    State = _{
        matrix: Matrix,
        totRounds: TotRounds,
        players: [Player, P1, P2],
        stage: Stage,
        mill: Mill,
        isBot: IsBot
    }.

stageCalling(Stage, stage1) :- stage1(Stage.matrix, Stage.totRounds, Stage.players, Stage.mill, Stage.isBot).
stageCalling(Stage, stage2) :- stage2(Stage.matrix, Stage.totRounds, Stage.players, Stage.mill, Stage.isBot).
stageCalling(Stage, stage3) :- stage3(Stage.matrix, Stage.totRounds, Stage.players, Stage.mill, Stage.isBot).
