:- module(stages, []).

:- use_module("./src/board.pl").
:- use_module("./src/window.pl").
:- use_module("./src/history.pl").
:- use_module("./src/validations.pl").
:- use_module("./stagesFunctions/functions1.pl").
:- use_module("./stagesFunctions/functions2.pl").
:- use_module("./stagesFunctions/functions3.pl").

stage1(Matriz, TotRounds, (Player, P1, P2), Mill, IsBot) :-
    validations:validateStage1(TotRounds),
    stage2(Matriz, TotRounds, (Player, P1, P2), Mill, IsBot), !.


stage2(Matriz, TotRounds, (Player, P1, P2), Mill, IsBot) :-
    validations:validateStage2(Matriz, Player),
    stage3(Matriz, TotRounds, (Player, P1, P2), Mill, IsBot), !.


stage3(Matriz, TotRounds, (Player, P1, P2), Mill, IsBot) :-
    validations:validateStage3(Matriz, Winner),
    history:saveFinalGame(Matriz, TotRounds, Winner, (P1, P2), IsBot), !.



stage1(Matriz, TotRounds, (Player, P1, P2), Mill, IsBot) :-
	functions1:processa_jogada(Matriz, 0, 0, (TotRounds, 1, Player, P1, P2), NovaMatriz, Resultado, X, Y, IsBot),
	(Resultado = stop ->
		continue:saveInterruptedGame(Matriz, TotRounds, (Player, P1, P2), "Phase1", Mill, IsBot),
		!
	;
		(
			% Casos com IsBot = true
			( IsBot = true, Resultado = marcou, Player = 2, functions1:formou_moinho(NovaMatriz, Player, X, Y) ->
				functions1:remover_peca(NovaMatriz, (TotRounds, 1, Player, P1, P2), FinalMatriz, true)
			;
			( IsBot = true, Resultado = marcou, Player = 1, functions1:formou_moinho(NovaMatriz, Player, X, Y) ->
				functions1:remover_peca(NovaMatriz, (TotRounds, 1, Player, P1, P2), FinalMatriz, false)
			;
			% Casos com IsBot = false
			( IsBot = false, Resultado = marcou, Player = 2, functions1:formou_moinho(NovaMatriz, Player, X, Y) ->
				functions1:remover_peca(NovaMatriz, (TotRounds, 1, Player, P1, P2), FinalMatriz, false)
			;
			( IsBot = false, Resultado = marcou, Player = 1, functions1:formou_moinho(NovaMatriz, Player, X, Y) ->
				functions1:remover_peca(NovaMatriz, (TotRounds, 1, Player, P1, P2), FinalMatriz, false)
			;
				FinalMatriz = NovaMatriz
			))))
		),
		NewTotRounds is TotRounds + 1,
		(Player = 1 -> NovoPlayer is 2 ; NovoPlayer is 1),
		stage1(FinalMatriz, NewTotRounds, (NovoPlayer, P1, P2), Mill, IsBot)
	).

stage2(Matriz, TotRounds, (Player, P1, P2), Mill, IsBot) :-
    functions2:processa_jogada_stage2(Matriz, 0, 0, (TotRounds, 2, Player, P1, P2), Estado, NovaMatriz, Resultado, X, Y, FormouMoinho, IsBot),
   	(
        		(
			% Casos com IsBot = true
			( IsBot = true, Resultado = marcou, Player = 2, functions1:formou_moinho(NovaMatriz, Player, X, Y) ->
				functions1:remover_peca(NovaMatriz, (TotRounds, 1, Player, P1, P2), FinalMatriz, true)
			;
			( IsBot = true, Resultado = marcou, Player = 1, functions1:formou_moinho(NovaMatriz, Player, X, Y) ->
				functions1:remover_peca(NovaMatriz, (TotRounds, 1, Player, P1, P2), FinalMatriz, false)
			;
			% Casos com IsBot = false
			( IsBot = false, Resultado = marcou, Player = 2, functions1:formou_moinho(NovaMatriz, Player, X, Y) ->
				functions1:remover_peca(NovaMatriz, (TotRounds, 1, Player, P1, P2), FinalMatriz, false)
			;
			( IsBot = false, Resultado = marcou, Player = 1, functions1:formou_moinho(NovaMatriz, Player, X, Y) ->
				functions1:remover_peca(NovaMatriz, (TotRounds, 1, Player, P1, P2), FinalMatriz, false)
			;
				FinalMatriz = NovaMatriz
			))))
		),
		NewTotRounds is TotRounds + 1,
		(Player = 1 -> NovoPlayer is 2 ; NovoPlayer is 1),
		stage2(FinalMatriz, NewTotRounds, (NovoPlayer, P1, P2), Mill, IsBot)
	).


stage3(Matriz, TotRounds, (Player, P1, P2), Mill, IsBot) :-
    functions3:processa_jogada_stage3(Matriz, 0, 0, (TotRounds, 3, Player, P1, P2), Estado, NovaMatriz, Resultado, X, Y, FormouMoinho, IsBot),
    (
        (
			% Casos com IsBot = true
			( IsBot = true, Resultado = marcou, Player = 2, functions1:formou_moinho(NovaMatriz, Player, X, Y) ->
				functions1:remover_peca(NovaMatriz, (TotRounds, 1, Player, P1, P2), FinalMatriz, true)
			;
			( IsBot = true, Resultado = marcou, Player = 1, functions1:formou_moinho(NovaMatriz, Player, X, Y) ->
				functions1:remover_peca(NovaMatriz, (TotRounds, 1, Player, P1, P2), FinalMatriz, false)
			;
			% Casos com IsBot = false
			( IsBot = false, Resultado = marcou, Player = 2, functions1:formou_moinho(NovaMatriz, Player, X, Y) ->
				functions1:remover_peca(NovaMatriz, (TotRounds, 1, Player, P1, P2), FinalMatriz, false)
			;
			( IsBot = false, Resultado = marcou, Player = 1, functions1:formou_moinho(NovaMatriz, Player, X, Y) ->
				functions1:remover_peca(NovaMatriz, (TotRounds, 1, Player, P1, P2), FinalMatriz, false)
			;
				FinalMatriz = NovaMatriz
			))))
		),
		NewTotRounds is TotRounds + 1,
		(Player = 1 -> NovoPlayer is 2 ; NovoPlayer is 1),
		stage3(FinalMatriz, NewTotRounds, (NovoPlayer, P1, P2), Mill, IsBot)
	).

