:- encoding(utf8).
:- use_module("./board.pl").

% Limpa o terminal
limpar_tela :-
    write('\e[H\e[J').

% Obtém a largura do terminal dinamicamente (Unix-based systems)
terminal_width(Width) :-
    setup_call_cleanup(
        open(pipe('tput cols'), read, Stream),  % Usa o comando 'tput' para obter o número de colunas
        read_line_to_codes(Stream, Codes),     % Lê a saída do comando
        close(Stream)
    ),
    atom_codes(Atom, Codes),
    atom_number(Atom, Width).

% Caso o comando tput não funcione, usa uma largura padrão
terminal_width(Width) :-
    Width is 80.  % Fallback caso a detecção falhe

% Centraliza um texto
centralizar(Texto) :-
    terminal_width(Width),
    string_length(Texto, Len),
    Spaces is max(0, (Width - Len) // 2),   % Calcula a quantidade de espaços para centralizar
    tab(Spaces), write(Texto), nl.

% Exibe o menu interativo e permite navegação
menu_interativo(Opcao) :-
    limpar_tela,
    nl, nl,
    display_menu(Opcao),
    get_single_char(Char),
    processar_navegacao(Char, Opcao).

% Exibe o menu com a opção atual destacada
display_menu(Opcao) :-
    centralizar('========================'),
    centralizar('   Nine Men\'s Morris   '),
    centralizar('========================'),
    display_opcao(1, Opcao, 'Novo Jogo'),
    display_opcao(2, Opcao, 'Continue'),
    display_opcao(3, Opcao, 'Histórico'),
    display_opcao(4, Opcao, 'Tutorial'),
    display_opcao(5, Opcao, 'Sair'),
    centralizar('========================'),
    centralizar('Use W para cima, S para baixo, Enter para selecionar.').

% Destaca a opção selecionada
display_opcao(Num, Num, Texto) :-
    atomic_list_concat(['> ', Texto, ' <'], TextoFormatado),
    centralizar(TextoFormatado).
display_opcao(_, _, Texto) :-
    centralizar(Texto).

% Processa entrada do usuário
processar_navegacao(119, Opcao) :- % tecla 'w'
    NovoOpcao is max(1, Opcao - 1),
    menu_interativo(NovoOpcao).
processar_navegacao(115, Opcao) :- % tecla 's'
    NovoOpcao is min(5, Opcao + 1),
    menu_interativo(NovoOpcao).
processar_navegacao(13, Opcao) :- % tecla Enter
    processar_opcao(Opcao).
processar_navegacao(_, Opcao) :-
    menu_interativo(Opcao).

% Processa a escolha do usuário
processar_opcao(1) :- centralizar('Iniciando novo jogo...'), nl, board:imprimeTabuleiro('l').
processar_opcao(2) :- centralizar('Carregando jogo salvo...'), nl.
processar_opcao(3) :- centralizar('Exibindo histórico...'), nl.
processar_opcao(4) :- centralizar('Mostrando tutorial...'), nl.
processar_opcao(5) :- centralizar('Saindo...'), nl.

% Regra de partida
main :-
    menu_interativo(1),
    board:show_board().
