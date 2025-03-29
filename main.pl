:- encoding(utf8).
:- use_module("./src/board.pl").

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

menuInterativo(Opcao) :-
    limparTela,
    centralizarV(10),
    display_menu(Opcao),
    get_single_char(Char),
    processarNavegacao(Char, Opcao).

display_menu(Opcao) :-
    centralizarH('========================'),
    centralizarH('   Nine Men\'s Morris   '),
    centralizarH('========================'),
    displayOpcao(1, Opcao, 'Novo Jogo'),
    displayOpcao(2, Opcao, 'Continue'),
    displayOpcao(3, Opcao, 'Histórico'),
    displayOpcao(4, Opcao, 'Tutorial'),
    displayOpcao(5, Opcao, 'Sair'),
    centralizarH('========================'),
    centralizarH('Use W para cima, S para baixo, Enter para selecionar.').

% Destaca a opção selecionada
displayOpcao(Num, Num, Texto) :-
    atomic_list_concat(['> ', Texto, ' <'], TextoFormatado),
    centralizarH(TextoFormatado).
displayOpcao(_, _, Texto) :-
    centralizarH(Texto).

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

% Processa a escolha do usuário
processarOpcao(1) :- centralizarH('Iniciando novo jogo...'), nl, board:imprimeTabuleiro('l'), menuInterativo(1).
processarOpcao(2) :- centralizarH('Carregando jogo salvo...'), nl, menuInterativo(1).
processarOpcao(3) :- centralizarH('Exibindo histórico...'), nl, menuInterativo(1).
processarOpcao(4) :- centralizarH('Mostrando tutorial...'), nl, menuInterativo(1).
processarOpcao(5) :- centralizarH('Saindo...'), halt.

% Regra de partida
main :-
    menuInterativo(1).
