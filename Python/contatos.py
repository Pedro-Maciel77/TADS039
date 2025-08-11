contatos = []  

def cadastrar_contato():
    nome = input("Nome: ")
    telefone = input("Telefone: ")
    email = input("E-mail: ")
    contatos.append({"nome": nome, "telefone": telefone, "email": email})
    print("Contato cadastrado com sucesso!\n")

def listar_contatos():
    if not contatos:
        print("Nenhum contato cadastrado.\n")
        return
    for i, contato in enumerate(contatos, start=1):
        print(f"{i}. {contato['nome']} - {contato['telefone']} - {contato['email']}")
    print()

def atualizar_contato():
    listar_contatos()
    if not contatos:
        return
    indice = int(input("Digite o número do contato a atualizar: ")) - 1
    if 0 <= indice < len(contatos):
        contatos[indice]['nome'] = input("Novo nome: ")
        contatos[indice]['telefone'] = input("Novo telefone: ")
        contatos[indice]['email'] = input("Novo e-mail: ")
        print("Contato atualizado com sucesso!\n")
    else:
        print("Contato não encontrado.\n")

def excluir_contato():
    listar_contatos()
    if not contatos:
        return
    indice = int(input("Digite o número do contato a excluir: ")) - 1
    if 0 <= indice < len(contatos):
        contatos.pop(indice)
        print("Contato excluído com sucesso!\n")
    else:
        print("Contato não encontrado.\n")

def menu():
    while True:
        print("===== GERENCIADOR DE CONTATOS =====")
        print("1. Cadastrar Contato")
        print("2. Listar Contatos")
        print("3. Atualizar Contato")
        print("4. Excluir Contato")
        print("5. Sair")
        opcao = input("Escolha uma opção: ")

        if opcao == "1":
            cadastrar_contato()
        elif opcao == "2":
            listar_contatos()
        elif opcao == "3":
            atualizar_contato()
        elif opcao == "4":
            excluir_contato()
        elif opcao == "5":
            print("Saindo do programa...")
            break
        else:
            print("Opção inválida.\n")

# Executar o menu
menu()
