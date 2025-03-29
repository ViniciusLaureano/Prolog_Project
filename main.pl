:- encoding(utf8).
:- use_module("./src/board.pl").
:- use_module("./src/window.pl").

menuInterativo(Opcao) :-
    window:limparTela,
    window:centralizarV(10),
    display_menu(Opcao),
    get_single_char(Char),
    processarNavegacao(Char, Opcao).

display_menu(Opcao) :-
    window:centralizarH('========================'),
    window:centralizarH('   Nine Men\'s Morris   '),
    window:centralizarH('========================'),
    displayOpcao(1, Opcao, 'Novo Jogo'),
    displayOpcao(2, Opcao, 'Continue'),
    displayOpcao(3, Opcao, 'Histórico'),
    displayOpcao(4, Opcao, 'Tutorial'),
    displayOpcao(5, Opcao, 'Sair'),
    window:centralizarH('========================'),
    window:centralizarH('Use W para cima, S para baixo, Enter para selecionar.').

% Destaca a opção selecionada
displayOpcao(Num, Num, Texto) :-
    atomic_list_concat(['> ', Texto, ' <'], TextoFormatado),
    window:centralizarH(TextoFormatado).
displayOpcao(_, _, Texto) :-
    window:centralizarH(Texto).

% Processa entrada do usuário
processarNavegacao(119, Opcao) :- % tecla 'w'
    NovoOpcao is max(1, Opcao - 1),
    menuInterativo(NovoOpcao).
processarNavegacao(115, Opcao) :- % tecla 's'
    NovoOpcao is min(5, Opcao + 1),
    menuInterativo(NovoOpcao).
processarNavegacao(13, Opcao) :- % tecla Enter
    processarOpcao(Opcao).
processarNavegacao(_, Opcao) :-
    menuInterativo(Opcao).


processarOpcao(1) :- window:centralizarH('Iniciando novo jogo...'), nl, board:imprimeTabuleiro('l'), menuInterativo(1).
processarOpcao(2) :- window:centralizarH('Carregando jogo salvo...'), nl, menuInterativo(1).
processarOpcao(3) :- window:centralizarH('Exibindo histórico...'), nl, menuInterativo(1).
processarOpcao(4) :- window:centralizarH('Mostrando tutorial...'), nl, menuInterativo(1).
processarOpcao(5) :- window:centralizarH('Saindo...'), halt.


main :-
    menuInterativo(1).
