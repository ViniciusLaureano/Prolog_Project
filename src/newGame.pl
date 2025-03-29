:- module(newGame, []).

:- use_module("./src/window.pl").
:- use_module("./src/stages.pl").
:- use_module("./src/utils/matrizDefault.pl").

startNewGame :-
    isBot(R),
    window:limparTela,
    window:centralizarV(4),
    window:centralizarInput('Digite o nome do Jogador 1: ', P1),
    askNames(P2, R),
    matrizDefault:matriz(Matriz),
    stages:stage1(Matriz, 1, (1, P1, P2), false, R).
    

isBot(R) :-
    window:limparTela,
    window:centralizarV(2),
    window:centralizarH('Digite 1 para o modo PvP ou 2 para o PvE'),
    get_single_char(Char),
    processChoice(Char, R).


processChoice(49, false).
processChoice(50, true).
processChoice(_, R) :- 
    window:limparTela,
    window:centralizarV(2),
    window:centralizarH('Opção inválida! Pressione 1 ou 2.'),
    sleep(2),
    isBot(R).


askNames(P2, false) :- window:centralizarInput('Digite o nome do Jogador 2: ', P2).

askNames(P2, true) :- window:centralizarInput('Digite o nome do Bot: ', P2).