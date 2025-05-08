CREATE TABLE cliente (
id_cliente INT PRIMARY KEY AUTO_INCREMENT,
nome VARCHAR(65) NOT NULL,
sexo VARCHAR(1) CHECK (sexo = 'm' or sexo = 'f' or sexo = 'o'),
idade TINYINT,
nascimento DATE
);

CREATE TABLE cliente_especial (
id_especial INT PRIMARY KEY AUTO_INCREMENT,
nome VARCHAR(65) NOT NULL,
sexo VARCHAR(1) CHECK (sexo = 'm' or sexo = 'f' or sexo = 'o'),
idade TINYINT,
cashback_perc DECIMAL(5,2) NOT NULL,
id_cliente INT NOT NULL,
FOREIGN KEY(id_cliente) REFERENCES cliente(id_cliente)
);

CREATE TABLE funcionario (
id_func INT PRIMARY KEY AUTO_INCREMENT,
nome VARCHAR(65) NOT NULL,
idade TINYINT,
sexo VARCHAR(1) CHECK (sexo = 'm' or sexo = 'f' or sexo = 'o'),
cargo VARCHAR(10) NOT NULL CHECK (cargo = 'vendedor' or cargo = 'gerente' or cargo = 'ceo'),
salario DECIMAL(10,2) NOT NULL,
nascimento DATE
);

CREATE TABLE produto (
id_produto INT PRIMARY KEY AUTO_INCREMENT,
nome VARCHAR(65) NOT NULL,
qtd INT NOT NULL,
descricao VARCHAR(160),
valor DECIMAL(10,2)
);

CREATE TABLE venda (
id_venda INT PRIMARY KEY AUTO_INCREMENT,
id_func INT,
id_cliente INT,
dia_venda DATETIME,
FOREIGN KEY(id_func) REFERENCES funcionario(id_func),
FOREIGN KEY(id_cliente) REFERENCES cliente(id_cliente)
);