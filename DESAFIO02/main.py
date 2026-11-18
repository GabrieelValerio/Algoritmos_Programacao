conf = True

livros = []
usuarios = []

livro = {
    "codigo": 0,
    "titulo": "",
    "autor": "",
    "categoria": "",
    "quantidade": 0
}

usuario = {
    "codigo": 0,
    "nome": "",
    "tipo": "",
    "vinculo": ""
}

def cadastrar_livro():
    livro["codigo"] = int(input("Informe o código do livro: "))
    livro["titulo"] = input("Informe o título do livro: ")
    livro["autor"] = input("Informe o autor do livro: ")
    livro["categoria"] = input("Informe a categoria do livro: ")
    livro["quantidade"] = int(input("Informe a quantidade de exemplares: "))
    livros.append(livro.copy())

def cadastrar_usuario():
    usuario["codigo"] = int(input("Informe o código do usuário: "))
    usuario["nome"] = input("Informe o nome do usuário: ")
    usuario["tipo"] = input("Informe o tipo do usuário (aluno, professor, etc.): ")
    usuario["vinculo"] = input("Informe o vínculo do usuário (curso, departamento, etc.): ")
    usuarios.append(usuario.copy())

while conf:
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
    try:
        x = int(input())
        match x:
            case 0:
                print("Encerrando aplicação...")
                conf = False
            case 1:
                cadastrar_livro()
            case 2:
                cadastrar_usuario()
            case 3:
                print("Listar livros selecionado.")
                # Adicione aqui a lógica para listar livros
            case 4:
                print("Listar usuários selecionado.")
                # Adicione aqui a lógica para listar usuários
            case 5:
                print("Realizar empréstimo selecionado.")
                # Adicione aqui a lógica para realizar empréstimo
            case 6:
                print("Realizar devolução selecionado.")
                # Adicione aqui a lógica para realizar devolução
            case 7:
                print("Consultar situação de um livro selecionado.")
                # Adicione aqui a lógica para consultar situação de um livro
            case 8:
                print("Consultar resumo da biblioteca selecionado.")
                # Adicione aqui a lógica para consultar resumo da biblioteca
            case _:
                print("Opção inválida, tente novamente!")
    except ValueError:
        print("Entrada inválida! Por favor, insira um número.")