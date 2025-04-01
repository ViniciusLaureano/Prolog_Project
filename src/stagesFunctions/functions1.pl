:- module(functions1, []).

movimento(w, (-1, 0)). % Para cima
movimento(s, (1, 0)).  % Para baixo
movimento(a, (0, -1)). % Para a esquerda
movimento(d, (0, 1)).  % Para a direita

elemento_matriz(Matriz, X, Y, Elemento) :-
    length(Matriz, Linhas),
    nth0(0, Matriz, PrimeiraLinha),
    length(PrimeiraLinha, Colunas),
    X >= 0, X < Linhas,
    Y >= 0, Y < Colunas,
    nth0(X, Matriz, Linha),
    nth0(Y, Linha, Elemento).

mover_ate_proximo(Matriz, X, Y, DX, DY, NX, NY) :-
    NX1 is X + DX,
    NY1 is Y + DY,
    (   
        elemento_matriz(Matriz, NX1, NY1, Elem) ->  
        (   
            Elem = (-1, -1) -> NX = X, NY = Y  % Bateu em (-1,-1), não se move
        ;   
            Elem = (1, 0) -> NX = NX1, NY = NY1  % Achou (1,0), para aqui
        ;   
            mover_ate_proximo(Matriz, NX1, NY1, DX, DY, NX, NY)  % Continua se movendo
        )
    ;   NX = X, NY = Y  % Saiu dos limites, não se move
    ).

move_cursor(Matriz, X, Y) :-
    format("Cursor na posição (~w, ~w). Use W, A, S, D para mover:\n", [X, Y]),
    get_single_char(Input),
    char_code(Char, Input),
    (   movimento(Char, (DX, DY)) -> 
        mover_ate_proximo(Matriz, X, Y, DX, DY, NX, NY),
        (X = NX, Y = NY -> write("Movimento inválido!\n"), move_cursor(Matriz, X, Y)  
        ;   move_cursor(Matriz, NX, NY))
    ;   write("Tecla inválida!\n"), move_cursor(Matriz, X, Y)
    ).