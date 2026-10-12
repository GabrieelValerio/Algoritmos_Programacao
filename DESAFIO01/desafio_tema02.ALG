Algoritmo "MedControl"
//
//
//
//
// Disciplina  : Algoritmo e Lógica de Programação
// Professor   : André Olímpio
// Descrição   : MedControl Saúde Integrada
// Autor(a)    : Nome do(a) aluno(a)
// Data atual  : 15/09/2026

// Constante com o limite de pacientes do vetor
Const
   max_pacientes = 30

// Registro que agrupa todos os dados de um paciente
Tipo
   estrutura_paciente = registro
   codigo: inteiro
   nome: caractere
   idade: inteiro
   sexo: caractere
   prioridade: inteiro
   pressao_arterial_sistolica: real
   pressao_arterial_diastolica: real
   temperatura: real
   status: inteiro
   fimregistro
Var
// Seção de Declarações das variáveis

// Vetor de registros: guarda todos os pacientes cadastrados
paciente: vetor[1..max_pacientes] de estrutura_paciente
// Matriz de estatísticas: linha = prioridade (1 a 4)
// coluna 1 = cadastrados, 2 = aguardando, 3 = atendidos
matriz_stats: vetor[1..4, 1..3] de inteiro
// Auxiliar para trocar dois pacientes de lugar na ordenação
aux: estrutura_paciente
temp, diastolica, sistolica: real
// max_pessoas = quantidade de pacientes cadastrados até agora
input, max_pessoas, i, j, cod, cod_estr, waiting, idade, prio, cont, novo_codigo: inteiro
genero: caractere
sistema, codigo_existe: logico

// Busca um paciente pelo código e retorna a posição dele no vetor
// Retorna 0 quando não encontra
Funcao localizar_paciente(codigo_busca: inteiro): inteiro
Var
   pos: inteiro
   achou: logico
Inicio
   pos <- 1
   achou <- falso
   // Percorre o vetor até achar o código ou acabar os cadastrados
   enquanto (pos <= max_pessoas) e (nao achou) faca
      se paciente[pos].codigo = codigo_busca entao
         achou <- verdadeiro
      senao
         pos <- pos + 1
      fimse
   fimenquanto
   se achou entao
      retorne pos
   senao
      retorne 0      // 0 = não encontrado
   fimse
Fimfuncao

// Cadastro (1) ================================================================

Procedimento cadastro
inicio
         limpatela
         //Confere se o limite de pessoas foi atingido ou não
         se max_pessoas = max_pacientes entao
            escreval("Limite atingido!")
            leia(waiting)
         senao
            //Registro pessoas, já somando +1 no limite

            // waiting = 1 mantém o laço de validação rodando
            waiting <- 1
            escreval("REGISTRO PACIENTE")
            escreva("Código: ")
            leia(novo_codigo)

            codigo_existe <- verdadeiro
            // Comparador de códigos, sem duplicação!
            // Repete até o código digitado não existir em nenhum paciente
            enquanto codigo_existe faca
            i <- 0
               codigo_existe <- falso
               // Estrutura vai pegar o código novo e comparar com os
               // valores armazenados!
               para i de 1 ate max_pessoas faca
                  se paciente[i].codigo = novo_codigo entao
                     codigo_existe <- verdadeiro
                  fimse
               fimpara

               se codigo_existe entao
                  escreva("CÓDIGO JÁ CADASTRADO! DIGITE NOVAMENTE: ")
                  leia(novo_codigo)
                  fimse
            fimenquanto
            // Vai somar + 1 ao registro inteiro!
            // (a próxima posição livre do vetor é max_pessoas + 1)
            paciente[max_pessoas+1].codigo <- novo_codigo

            escreva("Nome: ")
            leia(paciente[max_pessoas+1].nome)

            // Idade: só sai do laço quando estiver entre 0 e 130
            enquanto waiting = 1 faca
                        escreva("Idade: ")
                        leia(idade)
                           se (idade < 0) ou (idade > 130) entao
                              escreval("Idade Inválida")
                           senao
                                paciente[max_pessoas+1].idade <- idade
                                waiting <- 2
                           fimse
            fimenquanto

            // Gênero: aceita só M ou F (Maiusc deixa tudo em maiúsculo)
            waiting <- 1
            enquanto waiting = 1 faca
               escreva("Genero (M/F): ")
               leia(genero)
               genero <- Maiusc(genero)
               se (genero = "M") ou (genero = "F") entao
                  paciente[max_pessoas+1].sexo <- genero
                  waiting <- 2
               senao
                  escreval("Genero Inválido! Digite M ou F.")
               fimse
            fimenquanto

            // Prioridade: 1 (Emergência) a 4 (Pouco urgente)
            waiting <- 1
            enquanto waiting = 1 faca
                        escreva("Prioridade: ")
                        leia(prio)
                           se (prio < 1) ou (prio > 4) entao
                              escreval("Prioridade Inválida")
                           senao
                                paciente[max_pessoas+1].prioridade <- prio
                                waiting <- 2
                           fimse
            fimenquanto

            // Pressão sistólica
            waiting <- 1
            enquanto waiting = 1 faca
                     escreva("Pressão Arterial Sistólica: ")
                     leia(sistolica)
                     se (sistolica < 10) entao
                        escreval("Valor Inválido! (Maior que 10!)")
                     senao
                          paciente[max_pessoas+1].pressao_arterial_sistolica <- sistolica
                          waiting <- 2
                     fimse
            fimenquanto

            // Pressão diastólica (menor que a sistólica)
            waiting <- 1
            enquanto waiting = 1 faca
                     escreva("Pressão Arterial Diastólica: ")
                     leia(diastolica)
                     se (diastolica < 5) ou (diastolica >= sistolica) entao
                        escreval("Valor Inválido! (Maior que 5 e menor que a sistólica)")
                     senao
                          paciente[max_pessoas+1].pressao_arterial_diastolica <- diastolica
                          waiting <- 2
                     fimse
            fimenquanto

            // Temperatura
            waiting <- 1
            enquanto waiting = 1 faca
                     escreva("Temperatura: ")
                     leia(temp)
                      se (temp < 0) entao
                         escreval("Valor Inválido! (Maior que 0)")
                      senao
                           paciente[max_pessoas+1].temperatura <- temp
                           waiting <- 2
                      fimse
            fimenquanto
            // Todo paciente novo começa como aguardando (status 0)
            paciente[max_pessoas+1].status <- 0
            // Agora sim conta o novo paciente
            max_pessoas <- max_pessoas + 1
         fimse
fimprocedimento

// Listar (2) ==================================================================

// Mostra nome, prioridade e status de todos os cadastrados
Procedimento listar
inicio
         limpatela
         i <- 0
         enquanto (i < max_pessoas) faca
                  i <- i + 1
                  escreval("Nome:", paciente[i].nome)
                  // Traduz o número da prioridade para texto
                  se paciente[i].prioridade = 1 entao
                     escreval("Prioridade: Emergencia")
                  fimse
                  se paciente[i].prioridade = 2 entao
                     escreval("Prioridade: Muito Urgente")
                  fimse
                  se paciente[i].prioridade = 3 entao
                     escreval("Prioridade: Urgente")
                  fimse
                  se paciente[i].prioridade = 4 entao
                     escreval("Prioridade: Pouco Urgente")
                  fimse

                  // Status: 0 = aguardando, 1 = atendido
                  se paciente[i].status = 0 entao
                     escreval("Status: Aguardando")
                  fimse
                  se paciente[i].status = 1 entao
                     escreval("Status: Atendido")
                  fimse
                  escreval("[-------------------------------]")
         fimenquanto
fimprocedimento

// Consulta (3) ================================================================

// Pede um código e mostra todos os dados do paciente
Procedimento consulta
inicio
         limpatela
         escreval("Digite o código do paciente:")
         leia(cod)
         i <- 0
         // cont conta quantas posições já foram verificadas
         cont <- 0
         enquanto (i < max_pessoas) faca
                  i <- i + 1
                  cod_estr <- paciente[i].codigo
                  cont <- cont + 1
                  se cod = cod_estr entao
                     limpatela
                     escreval("Código Informado:", cod)
                     escreval("[-------------------------------]")
                     escreval("Nome:", paciente[i].nome)
                     escreval("Idade:", paciente[i].idade," Anos")
                     escreval("Sexo:", paciente[i].sexo)
                     se paciente[i].prioridade = 1 entao
                        escreval("Prioridade: Emergencia")
                     fimse
                     se paciente[i].prioridade = 2 entao
                        escreval("Prioridade: Muito Urgente")
                     fimse
                     se paciente[i].prioridade = 3 entao
                        escreval("Prioridade: Urgente")
                     fimse
                     se paciente[i].prioridade = 4 entao
                        escreval("Prioridade: Pouco Urgente")
                     fimse
                     escreval("Pressao Arterial Sistólica:", paciente[i].pressao_arterial_sistolica)
                     escreval("Pressão Arterial Diastólica:", paciente[i].pressao_arterial_diastolica)
                     escreval("Temperatura:", paciente[i].temperatura)
                     se paciente[i].status = 0 entao
                        escreval("Status: Aguardando")
                     fimse
                     se paciente[i].status = 1 entao
                        escreval("Status: Atendido")
                     fimse
                  senao
                       // Se chegou na última posição sem achar, o código não existe
                       se cont = max_pessoas entao
                          limpatela
                          escreval("Erro: Código Inválido/Inexistente")
                       fimse
                  fimse
         fimenquanto
fimprocedimento

// Fila de atendimento! (4)=====================================================

// Bubble sort pra organizar a fila!
// Critérios: menor número de prioridade primeiro, depois maior idade
// Empatou nos dois? Mantém a ordem de cadastro (só troca quando precisa)
procedimento fila_atendimento
Inicio
limpatela
i <- 0
j <- 0
escreval("==== FILA DE ATENDIMENTO ====")
// Laço de fora: repete as passadas de comparação
para i de 1 ate max_pessoas faca
     // Laço de dentro: compara cada paciente com o vizinho da frente
     para j de 1 ate max_pessoas - 1 faca
          se (paciente[j].prioridade > paciente[j+1].prioridade) ou (paciente[j].prioridade = paciente[j+1].prioridade) e (paciente[j].idade < paciente[j+1].idade)então
             // Troca os dois pacientes de lugar usando o aux
             aux <- paciente[j]
             paciente[j] <-  paciente[j+1]
             paciente[j+1] <- aux
          fimse
     fimpara
fimpara
// Depois de ordenado, mostra só quem ainda não foi atendido
para i de 1 ate max_pessoas faca
     se paciente[i].status <> 1 entao
        escreval("Nome:", paciente[i].nome)
        escreval("Idade:", paciente[i].idade," anos")
        se paciente[i].prioridade = 1 entao
           escreval("Prioridade: Emergencia")
        fimse
        se paciente[i].prioridade = 2 entao
           escreval("Prioridade: Muito Urgente")
        fimse
        se paciente[i].prioridade = 3 entao
           escreval("Prioridade: Urgente")
        fimse
        se paciente[i].prioridade = 4 entao
           escreval("Prioridade: Pouco Urgente")
        fimse
        escreval("[-------------------------------]")
     fimse
fimpara
fimprocedimento

// Pacientes atendidos (6) =====================================================

// Mostra só os pacientes com status 1 (atendido)
Procedimento pacientes_atendidos
inicio
         limpatela
         i <- 0
         enquanto (i < max_pessoas) faca
                  i <- i + 1
                  se paciente[i].status = 1 entao
                     escreval("Nome:", paciente[i].nome)
                     se paciente[i].prioridade = 1 entao
                        escreval("Prioridade: Emergencia")
                     fimse
                     se paciente[i].prioridade = 2 entao
                        escreval("Prioridade: Muito Urgente")
                     fimse
                     se paciente[i].prioridade = 3 entao
                        escreval("Prioridade: Urgente")
                     fimse
                     se paciente[i].prioridade = 4 entao
                        escreval("Prioridade: Pouco Urgente")
                     fimse

                     se paciente[i].status = 0 entao
                        escreval("Status: Aguardando")
                     fimse
                     se paciente[i].status = 1 entao
                        escreval("Status: Atendido")
                     fimse
                     escreval("[-------------------------------]")
                  fimse
         fimenquanto
fimprocedimento

// Atendimento (5) =============================================================

// Atende o próximo paciente da fila (o primeiro com status 0 depois de ordenar)
Procedimento atendimento
Var
   resp: caractere
   i: inteiro
   atendido: logico
Inicio
   limpatela
   escreval("==== REALIZAÇÃO DE ATENDIMENTO ====")
   se max_pessoas = 0 entao
      escreval("Nenhum paciente cadastrado!")
   senao
      escreva("Deseja atender o próximo paciente? (S/N): ")
      leia(resp)
      resp <- Maiusc(resp)
      se resp = "S" entao
         fila_atendimento
         limpatela        // deixa o vetor na ordem de atendimento
         i <- 1
         atendido <- falso
         // Anda pelo vetor ordenado até achar o primeiro que está aguardando
         enquanto (i <= max_pessoas) e (nao atendido) faca
            se paciente[i].status = 0 entao
               // Muda de aguardando (0) para atendido (1)
               paciente[i].status <- 1
               atendido <- verdadeiro
               escreval("Paciente atendido: ", paciente[i].nome)
            senao
               i <- i + 1
            fimse
         fimenquanto
         // Se percorreu tudo e ninguém estava aguardando
         se nao atendido entao
            escreval("Não há pacientes aguardando atendimento.")
         fimse
      senao
         se resp <> "N" entao
            escreval("Resposta Inválida")
         fimse
      fimse
   fimse
   leia(waiting)
fimprocedimento

// Matriz de estatísticas ======================================================

// Recalcula a matriz do zero a cada chamada, então ela fica sempre atualizada
Procedimento atualizar_matriz
Var
   k, linha, coluna: inteiro
Inicio
   // zera a matriz antes de contar
   // (laços aninhados: linha por linha, coluna por coluna)
   para linha de 1 ate 4 faca
        para coluna de 1 ate 3 faca
             matriz_stats[linha, coluna] <- 0
        fimpara
   fimpara

   // conta cada paciente na linha da sua prioridade
   para k de 1 ate max_pessoas faca
        linha <- paciente[k].prioridade
        // coluna 1: cadastrados (todo paciente entra aqui)
        matriz_stats[linha, 1] <- matriz_stats[linha, 1] + 1
        // coluna 2: aguardando / coluna 3: atendidos
        se paciente[k].status = 0 entao
           matriz_stats[linha, 2] <- matriz_stats[linha, 2] + 1
        senao
           matriz_stats[linha, 3] <- matriz_stats[linha, 3] + 1
        fimse
   fimpara
fimprocedimento

// Funções das estatísticas (7) ================================================

// Conta quantos pacientes têm status 0 (aguardando)
Funcao contar_aguardando: inteiro
Var
   k, cont: inteiro
Inicio
   k <- 0
   cont <- 0
   enquanto (k < max_pessoas) faca
            k <- k + 1
            se paciente[k].status = 0 entao
               cont <- cont + 1
            fimse
   fimenquanto
   retorne cont
Fimfuncao

// Conta quantos pacientes têm status 1 (atendido)
Funcao contar_atendidos: inteiro
Var
   k, cont: inteiro
Inicio
   k <- 0
   cont <- 0
   enquanto (k < max_pessoas) faca
            k <- k + 1
            se paciente[k].status = 1 entao
               cont <- cont + 1
            fimse
   fimenquanto
   retorne cont
Fimfuncao

// Média = soma das idades / quantidade de pacientes
Funcao calcular_media_idade: real
Var
   k: inteiro
   media: real
Inicio
   k <- 0
   media <- 0
   // Evita divisão por zero quando não há pacientes
   se max_pessoas = 0 entao
      retorne 0
   fimse
   enquanto (k < max_pessoas) faca
            k <- k + 1
            media <- media + paciente[k].idade
   fimenquanto
   media <- media / max_pessoas
   retorne media
Fimfuncao

// Média = soma das temperaturas / quantidade de pacientes
Funcao calcular_media_temperatura: real
Var
   k: inteiro
   media: real
Inicio
   k <- 0
   media <- 0
   se max_pessoas = 0 entao
      retorne 0
   fimse
   enquanto (k < max_pessoas) faca
            k <- k + 1
            media <- media + paciente[k].temperatura
   fimenquanto
   media <- media / max_pessoas
   retorne media
Fimfuncao

// Começa com -1 (menor que qualquer idade) e guarda sempre a maior encontrada
Funcao calcular_maior_idade: inteiro
Var
   k, maior: inteiro
Inicio
   k <- 0
   maior <- -1
   se max_pessoas = 0 entao
      retorne 0
   fimse
   enquanto (k < max_pessoas) faca
            k <- k + 1
            se paciente[k].idade > maior entao
               maior <- paciente[k].idade
            fimse
   fimenquanto
   retorne maior
Fimfuncao

// Começa com 150 (maior que qualquer idade) e guarda sempre a menor encontrada
Funcao calcular_menor_idade: inteiro
Var
   k, menor: inteiro
Inicio
   k <- 0
   menor <- 150
   se max_pessoas = 0 entao
      retorne 0
   fimse
   enquanto (k < max_pessoas) faca
            k <- k + 1
            se paciente[k].idade < menor entao
               menor <- paciente[k].idade
            fimse
   fimenquanto
   retorne menor
Fimfuncao

// Lê uma célula da matriz (linha = prioridade, coluna = 1 cadastrados, 2 aguardando, 3 atendidos)
Funcao ler_matriz(linha, coluna: inteiro): inteiro
Inicio
   retorne matriz_stats[linha, coluna]
Fimfuncao



// Atualiza a matriz e mostra pacientes e atendimentos por prioridade
Procedimento exibir_por_prioridade
Var
   k: inteiro
Inicio
   // Primeiro atualiza a matriz, depois só lê os valores dela
   atualizar_matriz
   escreval("[-------------------------------]")
   escreval("Quantidade de Pacientes por Prioridade:")
   k <- 0
   enquanto (k < 4) faca
            k <- k + 1
            // coluna 1 = cadastrados daquela prioridade
            escolha k
               caso 1
                  escreval("Emergencia:", ler_matriz(k, 1))
               caso 2
                  escreval("Muito Urgente:", ler_matriz(k, 1))
               caso 3
                  escreval("Urgente:", ler_matriz(k, 1))
               caso 4
                  escreval("Pouco Urgente:", ler_matriz(k, 1))
            fimescolha
   fimenquanto
   escreval("[-------------------------------]")
   escreval("Quantidade de Atendimentos por Prioridade:")
   k <- 0
   enquanto (k < 4) faca
            k <- k + 1
            // coluna 3 = atendidos daquela prioridade
            escolha k
               caso 1
                  escreval("Emergencia:", ler_matriz(k, 3))
               caso 2
                  escreval("Muito Urgente:", ler_matriz(k, 3))
               caso 3
                  escreval("Urgente:", ler_matriz(k, 3))
               caso 4
                  escreval("Pouco Urgente:", ler_matriz(k, 3))
            fimescolha
   fimenquanto
   escreval("[-------------------------------]")
fimprocedimento

// Percentual = (parte / total) * 100
Funcao calcular_percentual_atendidos: real
Inicio
   se max_pessoas = 0 entao
      retorne 0
   fimse
   retorne (contar_atendidos / max_pessoas) * 100
Fimfuncao

Funcao calcular_percentual_aguardando: real
Inicio
   se max_pessoas = 0 entao
      retorne 0
   fimse
   retorne (contar_aguardando / max_pessoas) * 100
Fimfuncao

// Conta pacientes com prioridade 1 OU 2 (ou, porque o paciente só tem uma prioridade)
Funcao contar_prioridade: inteiro
Var
   k, cont: inteiro
Inicio
   k <- 0
   cont <- 0
   enquanto (k < max_pessoas) faca
            k <- k + 1
            se (paciente[k].prioridade = 1) ou (paciente[k].prioridade = 2) entao
               cont <- cont + 1
            fimse
   fimenquanto
   retorne cont
Fimfuncao

// Só exibe: cada cálculo fica nas funções acima
Procedimento estatistica
Inicio
   limpatela
   se max_pessoas = 0 entao
      escreval("Nenhum paciente cadastrado!")
   senao
      escreval("Quantidade de Cadastros:", max_pessoas)
      escreval("Quantidade de Pacientes Aguardando:", contar_aguardando)
      escreval("Quantidade de Pacientes Atendido:", contar_atendidos)
      escreval("Média de Idade:", calcular_media_idade)
      escreval("Média de Temperatura:", calcular_media_temperatura)
      escreval("Maior Idade:", calcular_maior_idade)
      escreval("Menor Idade:", calcular_menor_idade)
      escreval("Percentual de Atendidos:", calcular_percentual_atendidos)
      escreval("Percentual de Aguardando:", calcular_percentual_aguardando)
      escreval("Quantidade de Pacientes com Prioridade 1 ou 2:", contar_prioridade)
      exibir_por_prioridade
   fimse
fimprocedimento

// Recursividade (8) ===========================================================

// Busca recursiva: retorna a posição do paciente ou 0 se não encontrar
Funcao busca_recursiva(codigo_busca, posicao_atual, quantidade: inteiro): inteiro
Var
   resultado: inteiro
Inicio
   // Caso-base 1: passou de todas as posições válidas, não encontrou
   se posicao_atual > quantidade entao
      resultado <- 0
   senao
      // Caso-base 2: encontrou o paciente nesta posição
      se paciente[posicao_atual].codigo = codigo_busca entao
         resultado <- posicao_atual
      senao
         // Passo recursivo: chama a si mesma na próxima posição
         resultado <- busca_recursiva(codigo_busca, posicao_atual + 1, quantidade)
      fimse
   fimse
   retorne resultado
Fimfuncao

// Conta recursivamente quantos pacientes ainda aguardam atendimento
Funcao aguardando_recursivo(posicao_atual, quantidade: inteiro): inteiro
Var
   resultado: inteiro
Inicio
   // Caso-base: não há mais posições para verificar
   se posicao_atual > quantidade entao
      resultado <- 0
   senao
      // Passo recursivo: posição atual + próximas posições
      // (vale 1 se a posição atual aguarda, senão vale 0)
      se paciente[posicao_atual].status = 0 entao
         resultado <- 1 + aguardando_recursivo(posicao_atual + 1, quantidade)
      senao
         resultado <- aguardando_recursivo(posicao_atual + 1, quantidade)
      fimse
   fimse
   retorne resultado
Fimfuncao

// Opção 8 do menu
// Pede o código, usa a busca recursiva e mostra quantos aguardam a partir dali
Procedimento consulta_recursiva
Var
   codigo_procurado, posicao: inteiro
Inicio
   limpatela
   escreval("==== CONSULTA RECURSIVA ====")
   se max_pessoas = 0 entao
      escreval("Nenhum paciente cadastrado!")
   senao
      escreva("Digite o código do paciente: ")
      leia(codigo_procurado)
      // Começa a busca na posição 1 e vai até o último cadastrado
      posicao <- busca_recursiva(codigo_procurado, 1, max_pessoas)
      se posicao = 0 entao
         escreval("Erro: Código Inválido/Inexistente")
      senao
         escreval("Paciente encontrado na posição:", posicao)
         escreval("Nome:", paciente[posicao].nome)
         escreval("Idade:", paciente[posicao].idade, " Anos")
         se paciente[posicao].status = 0 entao
            escreval("Status: Aguardando")
         senao
            escreval("Status: Atendido")
         fimse
      fimse
      escreval("[-------------------------------]")
      escreval("Pacientes aguardando (recursivo):", aguardando_recursivo(posicao, max_pessoas))
   fimse
fimprocedimento



// Programa principal ==========================================================

Inicio

input <- 1

// Menu continua aparecendo até a opção 9 ligar o "sistema"
enquanto nao sistema faça
   limpatela
   // Confere se os valores do input estão dentro dos valores permitidos
   se (input > 9) ou (input < 1) entao
      escreval("*Valor Inválido*")
      escreval("")
   fimse
   escreval("MEDCONTROL – GERENCIAMENTO DE ATENDIMENTOS")
   escreval("1. Cadastrar paciente")
   escreval("2. Listar pacientes")
   escreval("3. Consultar paciente")
   escreval("4. Exibir fila de atendimento")
   escreval("5. Realizar atendimento")
   escreval("6. Exibir pacientes atendidos")
   escreval("7. Exibir estatísticas")
   escreval("8. Executar consulta recursiva")
   escreval("9. Encerrar sistema")
   leia(input)
   // Cada opção chama o procedimento correspondente
   se input = 1 entao
      cadastro
   fimse
   se input = 2 entao
      listar
      leia(waiting)
   fimse
   se input = 3 entao
      consulta
      leia(waiting)
   fimse
   se input = 4 entao
      fila_atendimento
      leia(waiting)
   fimse
   se input = 5 entao
      atendimento
   fimse
   se input = 6 entao
      pacientes_atendidos
      leia(waiting)
   fimse
   se input = 7 entao
      estatistica
      leia(waiting)
   fimse
   se input = 8 entao
      consulta_recursiva
      leia(waiting)
   fimse
   // Opção 9: encerra o laço do menu
   se input = 9 entao
      sistema <- verdadeiro
   fimse
fimenquanto

Fimalgoritmo
