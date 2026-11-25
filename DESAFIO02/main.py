import os    
conf = True

livros = []
usuarios = []

categorias = (
    "Romance",
    "Ficção",
    "Fantasia",
    "Suspense",
    "Terror",
    "Biografia",
    "Acadêmico",
    "História"
)

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

def limpar_tela():
    os.system('cls' if os.name == 'nt' else 'clear')

def cadastrar_livro():
    limpar_tela()

    novo_livro = {
        "codigo": 0,
        "titulo": "",
        "autor": "",
        "categoria": "",
        "quantidade": 0,
        "quantidade_disponivel": 0
    }

    while True:
        codigo = int(input("Informe o código do livro: "))

        codigo_existe = False

        for livro in livros:
            if livro["codigo"] == codigo:
                codigo_existe = True
                break

        if codigo_existe:
            print("ERRO: Código já cadastrado!")
        else:
            break
    novo_livro["codigo"] = codigo

    while True:
        titulo = input("Informe o título do livro: ")

        if titulo.strip() == "":
            print("ERRO: O título é obrigatório!")
        else:
            break
    novo_livro["titulo"] = titulo

    while True:
        autor = input("Informe o nome do autor: ")

        if autor.strip() == "":
            print("ERRO: O nome do autor é obrigatório!")
        else:
            break
    novo_livro["autor"] = autor

    while True:
        try:
            quantidade = int(input("Informe a quantidade total de exemplares: "))

            if quantidade > 0:
                break
            else:
                print("ERRO: A quantidade deve ser maior que zero!")

        except ValueError:
            print("ERRO: Digite um número inteiro!")

    while True:
        for i, categoria in enumerate(categorias, start=1):
            print(f"{i} - {categoria}")

        try:
            opcao = int(input("Escolha a categoria do livro: "))

            if 1 <= opcao <= len(categorias):
                novo_livro["categoria"] = categorias[opcao - 1]
                break
            else:
                print("ERRO: Opção inválida!")

        except ValueError:
            print("ERRO: Digite um número inteiro!")
    novo_livro["categoria"] = categorias[opcao - 1]

    novo_livro["quantidade"] = quantidade
    novo_livro["quantidade_disponivel"] = quantidade

    livros.append(novo_livro.copy())
    print("Livro cadastrado com sucesso!")


def cadastrar_usuario():
    limpar_tela()
    usuario["codigo"] = int(input("Informe o código do usuário: "))
    usuario["nome"] = input("Informe o nome do usuário: ")
    usuario["tipo"] = input("Informe o tipo do usuário (aluno, professor, etc.): ")
    usuario["vinculo"] = input("Informe o vínculo do usuário (curso, departamento, etc.): ")
    usuarios.append(usuario.copy())

while conf:
    limpar_tela()
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