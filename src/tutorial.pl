:- module(tutorial, []).
:- use_module("./window.pl").
:- use_module("./board.pl").
:- use_module("./utils/matrizDefault.pl").
:- use_module("./stagesFunctions/functions1.pl").



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
            upMove((1,3), matrizDefault:matriz)
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
board:boardGenerate((X, Y), Matriz, 6),


get_single_char(Code),
    (Code == 27 ->
        get_single_char(_),  
        get_single_char(Direcao),
        (Direcao == 67 ->  
            window:limparTela,
            rightMove((0, 3), Matriz)
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
        upMove((0, 3), Matriz) 

    ;
        window:limparTela,
        upMove((X, Y), Matriz)
    ).


rightMove((X, Y), Matriz):- 
window:centralizarH("Aperte D para mover o cursor para a direita"), 
window:centralizarH("➡ para avançar "), 
window:centralizarH("⬅ para voltar "), 
window:centralizarH("Digite 'q' para sair do tutorial"), 
board:boardGenerate((X , Y), Matriz, 5),


get_single_char(Code),
    (Code == 27 ->
        get_single_char(_),  
        get_single_char(Direcao),
        (Direcao == 67 ->  
            window:limparTela,
            leftMove((0, 6), Matriz)
        ;
        Direcao == 68 ->
            window:limparTela,
            upMove((1, 3), Matriz)
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
        rightMove((0, 6), Matriz)
    ;
        window:limparTela,
        rightMove((X, Y), Matriz)
    ).


leftMove((X, Y), Matriz):-
window:centralizarH("Aperte A para mover o cursor para a esquerda"), 
window:centralizarH("➡ para avançar "), 
window:centralizarH("⬅ para voltar "), 
window:centralizarH("Digite 'q' para sair do tutorial"), 
board:boardGenerate((X, Y), Matriz, 5),


get_single_char(Code),
    (Code == 27 ->
        get_single_char(_),  
        get_single_char(Direcao),
        (Direcao == 67 ->  
            window:limparTela,
            downMove((0, 3), Matriz)
        ;
        Direcao == 68 ->
            window:limparTela,
            rightMove((0, 3), Matriz)
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
        leftMove((0, 3), Matriz)
    ;
        window:limparTela,
        leftMove((X, Y), Matriz)
    ).




downMove((X, Y), Matriz):-   
window:centralizarH("Aperte S para mover o cursor para baixo"), 
window:centralizarH("➡ para avançar "), 
window:centralizarH("⬅ para voltar "), 
window:centralizarH("Digite 'q' para sair do tutorial"), 
board:boardGenerate((X, Y), Matriz, 5),

get_single_char(Code),
    (Code == 27 ->
        get_single_char(_),  
        get_single_char(Direcao),
        (Direcao == 67 ->  
            window:limparTela,
            makeMove((1, 3), Matriz)
        ;
        Direcao == 68 -> 
            window:limparTela,
            leftMove((0, 6), Matriz)
        ;
            window:limparTela,
            downMove((X, Y), Matriz)
        )
        
    ;
    Code == 113 -> 
        window:limparTela,
        !
    ;
    Code == 115 ->
        window:limparTela,
        downMove((1, 3), Matriz)
    ;
        window:limparTela,
        downMove((X, Y), Matriz)
    ).



makeMove((X, Y), Matriz):-
window:centralizarH("Aperte 'C' para colocar uma peça na posição do cursor"), 
window:centralizarH("➡ para avançar "), 
window:centralizarH("⬅ para voltar "), 
window:centralizarH("Digite 'q' para sair do tutorial"), 
board:boardGenerate((X, Y), Matriz, 5),

get_single_char(Code),
    (Code == 27 ->
        get_single_char(_),  
        get_single_char(Direcao),
        (Direcao == 67 ->  
            window:limparTela,
            matrizDefault:matrizSecondStep(NovaMatriz),
            intermission((0, 0), NovaMatriz)
        ;
        Direcao == 68 ->
            window:limparTela,
            matrizDefault:matriz(MatrizAntiga),
            downMove((0, 3), MatrizAntiga)
        ;
            window:limparTela,
            makeMove((X, Y), Matriz)
        )
        
    ;
    Code == 113 -> 
        window:limparTela,
        !
    ;
    Code == 99 ->
        window:limparTela,
        matrizDefault:matrizWithAddition(MatrizAdicao),
        makeMove((0, 3), MatrizAdicao)
    ;
        window:limparTela,
        makeMove((X, Y), Matriz)
    ).



intermission((X, Y), Matriz):-
window:centralizarH("Nesse jogo, para sair do primeiro estágio é necessário que cada jogador coloque 9 peças no tabuleiro."), 
window:centralizarH("entrando no segundo estágio,as peças podem começar a se mover para casas adjacentes"), 
window:centralizarH("➡ para avançar "), 
window:centralizarH("⬅ para voltar "), 
window:centralizarH("Digite 'q' para sair do tutorial"), 
board:boardGenerate((X, Y), Matriz, 6),


get_single_char(Code),
    (Code == 27 ->
        get_single_char(_),  
        get_single_char(Direcao),
        (Direcao == 67 ->  
            window:limparTela,
            matrizDefault:matrizSecondStepWithRemotion(NovaMatriz),
            removePiece((X, Y), NovaMatriz)
        ;
        Direcao == 68 ->
            window:limparTela,
            matrizDefault:matriz(MatrizDefault),
            makeMove((1, 3), MatrizDefault)
        ;
            window:limparTela,
            intermission((X, Y), Matriz)
        )
        
    ;
    Code == 113 -> 
        window:limparTela,
        !
    ;
        window:limparTela,
        intermission((X, Y), Matriz)
    ).


removePiece((X, Y), Matriz):-
window:centralizarH("ao formar um moínho(3 peças alinhadas) o jogador pode"), 
window:centralizarH("selecionar uma peça que não faça parte de um moínho (a não ser que seja a ultima peça)"), 
window:centralizarH("do seu openente e remove-la, nesse caso o"), 
window:centralizarH("jogador 2 pode escolher e remover a peça do jogador 1, vamos remover a peça (2, 4)"), 
window:centralizarH("➡ para avançar "), 
window:centralizarH("⬅ para voltar "), 
window:centralizarH("Digite 'q' para sair do tutorial"), 
board:boardGenerate((X, Y), Matriz, 8),


get_single_char(Code),
    (Code == 27 ->
        get_single_char(_),  
        get_single_char(Direcao),
        (Direcao == 67 ->  
            window:limparTela,
            thirdStep((X, Y), Matriz)
        ;
        Direcao == 68 ->
            window:limparTela,
            matrizDefault:matrizSecondStep(MatrizAntiga),
            intermission((X, Y), MatrizAntiga)
        ;
            window:limparTela,
            removePiece((X, Y), Matriz)
        )
        
    ;
    Code == 113 -> 
        window:limparTela,
        !
    ;
        window:limparTela,
        removePiece((X,Y), Matriz)
    ).


thirdStep((X, Y), Matriz):-
window:centralizarH("O jogo seguirá com ambos os jogadores retirando peças do seu openente"), 
window:centralizarH("Quando algum jogador tiver com apenas 3 peças ele entrará no estágio 3"), 
window:centralizarH("➡ para avançar "), 
window:centralizarH("⬅ para voltar "), 
window:centralizarH("Digite 'q' para sair do tutorial"), 
board:boardGenerate((X, Y), Matriz, 6),

get_single_char(Code),
    (Code == 27 ->
        get_single_char(_),  
        get_single_char(Direcao),
        (Direcao == 67 ->  
            window:limparTela,
            matrizDefault:matrizThirdStep(NovaMatriz),
            freeMove((X,Y), NovaMatriz)
        ;
        Direcao == 68 ->
            window:limparTela,
            removePiece((X,Y),Matriz)
        ;
            window:limparTela,
            thirdStep((X,Y), Matriz)
        )
        
    ;
    Code == 113 -> 
        window:limparTela,
        !
    ;
        window:limparTela,
        thirdStep((X, Y), Matriz)
    ).


freeMove((X, Y), Matriz):-
window:centralizarH("Como o jogador 1 tem apenas 3 peças no tabuleiro, ele entra no terceiro estágio"), 
window:centralizarH("Sua movimentação agora não está mais limitada apenas às casas adjacentes"), 
window:centralizarH("➡ para avançar "), 
window:centralizarH("⬅ para voltar "), 
window:centralizarH("Digite 'q' para sair do tutorial"), 
board:boardGenerate((X, Y), Matriz, 6),

get_single_char(Code),
    (Code == 27 ->
        get_single_char(_),  
        get_single_char(Direcao),
        (Direcao == 67 ->  
            window:limparTela,
            matrizDefault:matrizPlayerTwoWins(NovaMatriz),
            playerTwoWins((X, Y), NovaMatriz)
        ;
        Direcao == 68 ->
            window:limparTela,
            matrizDefault:matrizSecondStepWithRemotion(MatrizAntiga),
            thirdStep((X, Y), MatrizAntiga)
        ;
            window:limparTela,
            freeMove((X, Y), Matriz)
        )
        
    ;
    Code == 113 -> 
        window:limparTela,
        !
    ;
        window:limparTela,
        freeMove((X, Y), Matriz)
    ).


playerTwoWins((X, Y), Matriz):-
window:centralizarH( "Mesmo no terceiro estágio o jogo continua, e quem ficar com 2 peças"), 
window:centralizarH( "restantes primeiro perde. Nesse caso o jogador 2 ganhou o jogo"), 
window:centralizarH("➡ para avançar "), 
window:centralizarH("⬅ para voltar "), 
window:centralizarH("Digite 'q' para sair do tutorial"), 
board:boardGenerate((X, Y), Matriz, 6),

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
            matrizDefault:matrizThirdStep(MatrizAntiga),
            freeMove((X, Y), MatrizAntiga)
        ;
            window:limparTela,
            playerTwoWins((X, Y), Matriz)
        )
        
    ;
    Code == 113 -> 
        window:limparTela,
        !
    ;
        window:limparTela,
        playerTwoWins((X, Y), Matriz)
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
