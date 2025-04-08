:- module(tutorial, []).
:- use_module("./window.pl").
:- use_module("./board.pl").
:- use_module("./utils/matrizDefault.pl").



startTutorial :-
    window:limparTela,
    start.

start :-
    window:centralizarH("O Nine Men's Morris (também conhecido como 'Moinho' ou 'Jogo do Moinho') é um jogo de"), 
    window:centralizarH("estratégia antigo e clássico para dois jogadores. O objetivo do jogo é formar 'moinhos'"), 
    window:centralizarH("(linhas de três peças) para capturar as peças do oponente. O jogo é dividido em três"), 
    window:centralizarH("fases: colocação de peças, movimentação de peças e fase final (quando um jogador tem"), 
    window:centralizarH("apenas três peças)."),  
    window:centralizarH("➡ para avançar "), 
    window:centralizarH("Digite 'q' para sair do tutorial"),
    get_single_char(Code),
    (Code == 27 ->
        get_single_char(_),  
        get_single_char(Direcao),
        (Direcao == 67 ->  
            window:limparTela,
            firstStep
        ;
            window:limparTela,
            start
        )
    ;
    Code == 113 -> 
        window:limparTela,
        !
    ;
        window:limparTela,
        start
    ).


firstStep :-
    window:centralizarH("Fase 1: Colocação de Peças"), 
    window:centralizarH("-------------------------"), 
    window:centralizarH("Nesta fase inicial, os jogadores alternam colocando suas peças"), 
    window:centralizarH("nos pontos vazios do tabuleiro."),  
    window:centralizarH("➡ para avançar "), 
    window:centralizarH("⬅ para voltar "), 
    window:centralizarH("Digite 'q' para sair do tutorial"),

    get_single_char(Code),
    (Code == 27 ->
        get_single_char(_),  
        get_single_char(Direcao),
        (Direcao == 67 ->  
            window:limparTela,
            upMove((2,4), matrizDefault:matriz)
        ;
        Direcao == 68 ->
            window:limparTela,
            start
        ;
            window:limparTela,
            firstStep
        )
        
    ;
    Code == 113 -> 
        window:limparTela,
        !
    ;
        window:limparTela,
        firstStep
    ).



upMove((X, Y), Matriz):-
window:centralizarH("W A S D será a sua movimentação durante o jogo"), 
window:centralizarH("Teste apertando W pra mover o cursor para cima"), 
window:centralizarH("➡ para avançar "), 
window:centralizarH("⬅ para voltar "), 
window:centralizarH("Digite 'q' para sair do tutorial"),
board:boardGenerate((X, Y), Matriz),


get_single_char(Code),
    (Code == 27 ->
        get_single_char(_),  
        get_single_char(Direcao),
        (Direcao == 67 ->  
            window:limparTela,
            rightMove((1, Y), Matriz)
        ;
        Direcao == 68 ->
            window:limparTela,
            firstStep
        ;
            window:limparTela,
            upMove((X, Y), Matriz)
        )
        
    ;
    Code == 113 -> 
        window:limparTela,
        !
    ;
    Code == 119 ->
        window:limparTela,
        upMove((1, Y), Matriz) 

    ;
        window:limparTela,
        upMove((X, Y), Matriz)
    ).


rightMove((X, Y), Matriz):- 
window:centralizarH("Aperte D para mover o cursor para a direita"), 
window:centralizarH("➡ para avançar "), 
window:centralizarH("⬅ para voltar "), 
window:centralizarH("Digite 'q' para sair do tutorial"), 
board:boardGenerate((X , Y), Matriz),


get_single_char(Code),
    (Code == 27 ->
        get_single_char(_),  
        get_single_char(Direcao),
        (Direcao == 67 ->  
            window:limparTela,
            leftMove((X, 5), Matriz)
        ;
        Direcao == 68 ->
            window:limparTela,
            upMove((2, 4), Matriz)
        ;
            window:limparTela,
            rightMove((X, Y), Matriz)
        )
        
    ;
    Code == 113 -> 
        window:limparTela,
        !
    ;
    Code == 100 ->
        window:limparTela,
        rightMove((X, 5), Matriz)
    ;
        window:limparTela,
        rightMove((X, Y), Matriz)
    ).


leftMove((X, Y), Matriz):-
window:centralizarH("Aperte A para mover o cursor para a esquerda"), 
window:centralizarH("➡ para avançar "), 
window:centralizarH("⬅ para voltar "), 
window:centralizarH("Digite 'q' para sair do tutorial"), 
board:boardGenerate((X, Y), Matriz),


get_single_char(Code),
    (Code == 27 ->
        get_single_char(_),  
        get_single_char(Direcao),
        (Direcao == 67 ->  
            window:limparTela,
            downMove((X, 4), Matriz)
        ;
        Direcao == 68 ->
            window:limparTela,
            rightMove((1, 4), Matriz)
        ;
            window:limparTela,
            leftMove((X, Y), Matriz)
        )
        
    ;
    Code == 113 -> 
        window:limparTela,
        !
    ;
    Code == 97 ->
        window:limparTela,
        leftMove((X, 4), Matriz)
    ;
        window:limparTela,
        leftMove((X, Y), Matriz)
    ).




downMove((X, Y), Matriz):-   
window:centralizarH("Aperte S para mover o cursor para baixo"), 
window:centralizarH("➡ para avançar "), 
window:centralizarH("⬅ para voltar "), 
window:centralizarH("Digite 'q' para sair do tutorial"), 
board:boardGenerate((X, Y), Matriz),

get_single_char(Code),
    (Code == 27 ->
        get_single_char(_),  
        get_single_char(Direcao),
        (Direcao == 67 ->  
            window:limparTela
        ;
        Direcao == 68 -> 
            window:limparTela,
            leftMove((1, 5), Matriz)
        ;
            window:limparTela,
            downMove(2, Y)
        )
        
    ;
    Code == 113 -> 
        window:limparTela,
        !
    ;
    Code == 115 ->
        window:limparTela,
        downMove((2, Y), Matriz)
    ;
        window:limparTela,
        downMove((X, Y), Matriz)
    ).



makeMove:-
window:centralizarH("Aperte ENTER para colocar uma peça na posição do cursor"), 
window:centralizarH("➡ para avançar "), 
window:centralizarH("⬅ para voltar "), 
window:centralizarH("Digite 'q' para sair do tutorial"), 

get_single_char(Code),
    (Code == 27 ->
        get_single_char(_),  
        get_single_char(Direcao),
        (Direcao == 67 ->  
            window:limparTela,
            intermission
        ;
        Direcao == 68 ->
            window:limparTela,
            downMove
        ;
            window:limparTela,
            makeMove
        )
        
    ;
    Code == 113 -> 
        window:limparTela,
        !
    ;
        window:limparTela,
        makeMove
    ).



intermission:-
window:centralizarH("Nesse jogo, para sair do primeiro estágio é necessário que cada jogador coloque 9 peças no tabuleiro."), 
window:centralizarH("entrando no segundo estágio,as peças podem começar a se mover para casas adjacentes"), 
window:centralizarH("➡ para avançar "), 
window:centralizarH("⬅ para voltar "), 
window:centralizarH("Digite 'q' para sair do tutorial"), 

get_single_char(Code),
    (Code == 27 ->
        get_single_char(_),  
        get_single_char(Direcao),
        (Direcao == 67 ->  
            window:limparTela,
            removePiece
        ;
        Direcao == 68 ->
            window:limparTela,
            makeMove
        ;
            window:limparTela,
            intermission
        )
        
    ;
    Code == 113 -> 
        window:limparTela,
        !
    ;
        window:limparTela,
        intermission
    ).


removePiece:-
window:centralizarH("ao formar um moínho(3 peças alinhadas) o jogador pode"), 
window:centralizarH("selecionar uma peça que não faça parte de um moínho (a não ser que seja a ultima peça)"), 
window:centralizarH("do seu openente e remove-la, nesse caso o"), 
window:centralizarH("jogador 2 pode escolher e remover a peça do jogador 1, vamos remover a peça (2, 4)"), 
window:centralizarH("➡ para avançar "), 
window:centralizarH("⬅ para voltar "), 
window:centralizarH("Digite 'q' para sair do tutorial"), 

get_single_char(Code),
    (Code == 27 ->
        get_single_char(_),  
        get_single_char(Direcao),
        (Direcao == 67 ->  
            window:limparTela,
            thirdStep
        ;
        Direcao == 68 ->
            window:limparTela,
            intermission
        ;
            window:limparTela,
            removePiece
        )
        
    ;
    Code == 113 -> 
        window:limparTela,
        !
    ;
        window:limparTela,
        upMove
    ).


thirdStep:-
window:centralizarH("O jogo seguirá com ambos os jogadores retirando peças do seu openente"), 
window:centralizarH("Quando algum jogador tiver com apenas 3 peças ele entrará no estágio 3"), 
window:centralizarH("➡ para avançar "), 
window:centralizarH("⬅ para voltar "), 
window:centralizarH("Digite 'q' para sair do tutorial"), 

get_single_char(Code),
    (Code == 27 ->
        get_single_char(_),  
        get_single_char(Direcao),
        (Direcao == 67 ->  
            window:limparTela,
            freeMove
        ;
        Direcao == 68 ->
            window:limparTela,
            removePiece
        ;
            window:limparTela,
            thirdStep
        )
        
    ;
    Code == 113 -> 
        window:limparTela,
        !
    ;
        window:limparTela,
        thirdStep
    ).


freeMove:-
window:centralizarH("Como o jogador 1 tem apenas 3 peças no tabuleiro, ele entra no terceiro estágio"), 
window:centralizarH("Sua movimentação agora não está mais limitada apenas às casas adjacentes"), 
window:centralizarH("➡ para avançar "), 
window:centralizarH("⬅ para voltar "), 
window:centralizarH("Digite 'q' para sair do tutorial"), 

get_single_char(Code),
    (Code == 27 ->
        get_single_char(_),  
        get_single_char(Direcao),
        (Direcao == 67 ->  
            window:limparTela,
            playerTwoWins
        ;
        Direcao == 68 ->
            window:limparTela,
            thirdStep
        ;
            window:limparTela,
            freeMove
        )
        
    ;
    Code == 113 -> 
        window:limparTela,
        !
    ;
        window:limparTela,
        freeMove
    ).


playerTwoWins:-
window:centralizarH( "Mesmo no terceiro estágio o jogo continua, e quem ficar com 2 peças"), 
window:centralizarH( "restantes primeiro perde. Nesse caso o jogador 2 ganhou o jogo"), 
window:centralizarH("➡ para avançar "), 
window:centralizarH("⬅ para voltar "), 
window:centralizarH("Digite 'q' para sair do tutorial"), 

get_single_char(Code),
    (Code == 27 ->
        get_single_char(_),  
        get_single_char(Direcao),
        (Direcao == 67 ->  
            window:limparTela,
            lastStep
        ;
        Direcao == 68 ->
            window:limparTela,
            freeMove
        ;
            window:limparTela,
            playerTwoWins
        )
        
    ;
    Code == 113 -> 
        window:limparTela,
        !
    ;
        window:limparTela,
        playerTwoWins
    ).



lastStep:-
window:centralizarH("Agora que você conhece as regras e estratégias básicas, é hora de jogar! Divirta-se com o Nine Men's Morris"), 
window:centralizarH("um jogo que combina estratégia, planejamento e antecipação."), 
window:centralizarH("⬅ para voltar "), 
window:centralizarH("Digite 'q' para sair do tutorial"), 

get_single_char(Code),
    (Code == 27 ->
        get_single_char(_),  
        get_single_char(Direcao),
        (Direcao == 68 ->
            window:limparTela,
            playerTwoWins
        ;
            window:limparTela,
            lastStep
        )
        
    ;
    Code == 113 -> 
        window:limparTela,
        !
    ;
        window:limparTela,
        lastStep
    ).
