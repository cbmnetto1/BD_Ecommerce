import mysql.connector

def main():
    
    # inicia bd com essas informacoes
    conn = mysql.connector.connect(
        host='localhost',
        user='root',
        password="password", # CHANGE BEFORE COMMITING
        port=3306
    )

    cursor = conn.cursor()

    options(cursor)

    conn.commit()
    cursor.close()
    conn.close()


def options(cursor):
    print("Opções:")
    print("1 - Criar banco de dados")
    print("2 - Cadastrar produto")
    print("3 - Cadastrar cliente")
    print("4 - Deletar banco de dados")

    option = (input("Escolha uma opcao: "))

    if option == "1":
        create_db(cursor, 'ecommerce.sql')
    elif option == "2":
        create_product(cursor)
    elif option == "3":
        create_client(cursor)
    elif option == "4":
        drop_db(cursor)
    else:
        print("Selecione uma opcao valida.")


def create_db(cursor, filename):
    try:
        with open(filename, "r", "utf-8") as file:
            sql_script = file.read()

        for statement in sql_script.strip().split(";"):
            if statement.strip():
                cursor.execute(statement + ";")
        
        print("Banco de dados criado com sucesso.")
    except Exception as e:
        print(f"Erro ao criar banco: {e}")

def drop_db(cursor):
    try:
        cursor.execute("DROP DATABASE ecommerce")
        print("Banco de dados deletado com sucesso.")
    except Exception as e:
        print(f"Erro ao deletar banco: {e}")

def create_product(cursor):
    nome = input('Nome do produto: ')
    quantidade = input('Quantidade: ')
    descricao = input('Descricao: ')
    valor = input('Valor: ')

    try:
        cursor.execute(
            "INSERT INTO produto (nome, quantidade, descricao, valor) VALUES (%s, %s, %s, %s)",
            (nome, quantidade, descricao, valor)
        )
        print("Produto cadastrado com sucesso.")
    except Exception as e:
        print(f"Erro ao cadastrar produto: {e}")

def create_client(cursor): 
    nome = input('Nome do cliente: ')
    sexo = input('Sexo: ')
    idade = input('Idade: ')
    nascimento = input('Data de nascimento (YYYY-MM-DD): ')

    try:
        cursor.execute(
            "INSERT INTO cliente (nome, sexo, idade, nascimento) VALUES (%s, %s, %s, %s)",
            (nome, sexo, idade, nascimento)
        )
        print("Cliente cadastrado com sucesso.")
    except Exception as e:
        print(f"Erro ao cadastrar cliente: {e}")

if __name__ == '__main__':
    main()