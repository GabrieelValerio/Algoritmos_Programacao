Algoritmo "semnome"
// Disciplina  : Algoritmo e Lógica de Programação
// Professor   : André Olímpio 
// Descrição   : Aqui você descreve o que o programa faz! (função)
// Autor(a)    : Nome do(a) aluno(a)
// Data atual  : 15/09/2026
Var
ordem: vetor[1..10] de inteiro
i, x: inteiro


Inicio
i <- 0
repita 1
       i <- i + 1
       escreval("Digite um número:")
       leia(x)
       ordem[i] <- x
até i=10

// Aqui o programa começa a mostrar os números na ordem inversa.
i <- 11
x <- 0
repita 1
       x <- x + 1
       i <- i - 1
       escreval(ordem[i])
até x=10
       

Fimalgoritmo
