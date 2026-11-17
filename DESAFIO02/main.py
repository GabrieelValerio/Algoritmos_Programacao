conf = bool(True)

while conf == True:
    print('''BiblioPy
          
        1 - Cadastrar livro
        2 - Cadastrar usuário
        3 - Listar livros
        4 - Listar usuários
        5 - Realizar empréstimo
        6 - Realizar devolução
        7 - Consultar situação de um livro
        8 - Consultar resumo da biblioteca
        0 - Encerrar aplicação
        Informe a opção desejada:''')
    x = int(input())
    match x:
        case 0:
            break
        case _:
            print('Opção inválida, tente novamente!')