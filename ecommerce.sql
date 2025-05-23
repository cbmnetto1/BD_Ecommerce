CREATE DATABASE ecommerce;

USE ecommerce;

CREATE TABLE cliente (
	id SERIAL PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    sexo CHAR(1) CHECK (sexo IN ('m', 'f', 'o')),
    idade INT CHECK (idade >= 0),
    nascimento DATE NOT NULL
);

CREATE TABLE clienteespecial (
	id SERIAL PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    sexo CHAR(1) CHECK (sexo IN('m','f','o')),
    idade INT CHECK (idade >= 0),
    id_cliente INT UNIQUE REFERENCES cliente(id) ON DELETE CASCADE,
    cashback DECIMAL (10,2) DEFAULT 0.00
);

CREATE TABLE funcionario (
	id SERIAL PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    idade INT CHECK (idade >= 18),
    sexo CHAR(1) CHECK (sexo IN ('m', 'f', 'o')),
    cargo VARCHAR(20) CHECK (cargo IN ('vendedor', 'gerente', 'CEO')),
    salario DECIMAL(10,2) NOT NULL CHECK (salario >= 0),
    nascimento DATE NOT NULL
);

CREATE TABLE produto (
	id SERIAL PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
	quantidade INT CHECK (quantidade >= 0),
    descricao TEXT,
    valor DECIMAL (10,2) CHECK (valor >= 0)
);

CREATE TABLE venda (
	id SERIAL PRIMARY KEY,
    id_vendedor INT REFERENCES funcionario(id) ON DELETE SET NULL,
    id_cliente INT REFERENCES cliente(id) ON DELETE SET NULL,
    data TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE funcionarioespecial (
	id SERIAL PRIMARY KEY,
    id_funcionario INT UNIQUE REFERENCES funcionario(id) ON DELETE CASCADE,
    total_vendido DECIMAL (10,2) DEFAULT 0.00,
    bonus DECIMAL (10,2) DEFAULT 0.00
);

CREATE TABLE item_venda (
	id SERIAL PRIMARY KEY,
    id_venda INT REFERENCES venda(id) ON DELETE CASCADE,
    id_produto INT REFERENCES produto(id) ON DELETE CASCADE,
    quantidade INT CHECK (quantidade > 0),
    valor_unitario DECIMAL(10,2) NOT NULL
);

CREATE TABLE vouchers (
    id SERIAL PRIMARY KEY,
    id_cliente INT NOT NULL,
    valor DECIMAL(10,2) NOT NULL,
    data_emissao TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    utilizado BOOLEAN DEFAULT FALSE,
    codigo VARCHAR(20) UNIQUE,
    FOREIGN KEY (id_cliente) REFERENCES cliente(id) ON DELETE CASCADE
);

-- VIEW 1 Relatório de vendas por vendedor com detalhes
CREATE OR REPLACE VIEW relatorio_vendas_vendedor AS
SELECT 
    f.id AS id_vendedor,
    f.nome AS nome_vendedor,
    f.cargo,
    COUNT(v.id) AS total_vendas,
    SUM(iv.quantidade * iv.valor_unitario) AS valor_total_vendido,
    SUM(iv.quantidade) AS itens_vendidos
FROM funcionario f
LEFT JOIN venda v ON f.id = v.id_vendedor
LEFT JOIN item_venda iv ON v.id = iv.id_venda
GROUP BY f.id, f.nome, f.cargo
ORDER BY valor_total_vendido DESC;

-- VIEW 2 Relatório de clientes especiais e seus benefícis
CREATE OR REPLACE VIEW relatorio_clientes_especiais AS
SELECT 
    ce.id,
    c.nome AS cliente,
    c.idade,
    c.sexo,
    ce.cashback AS cashback_acumulado,
    (SELECT COUNT(*) FROM venda WHERE id_cliente = c.id) AS total_compras,
    (SELECT SUM(iv.quantidade * iv.valor_unitario) 
     FROM venda v 
     JOIN item_venda iv ON v.id = iv.id_venda 
     WHERE v.id_cliente = c.id) AS total_gasto
FROM clienteespecial ce
JOIN cliente c ON ce.id_cliente = c.id
ORDER BY total_gasto DESC;

-- VIEW 3 Estoque crítico (produtos com menos de 10 unidades)
CREATE OR REPLACE VIEW estoque_critico AS
SELECT 
    p.id,
    p.nome,

INSERT INTO cliente (nome, sexo, idade, nascimento) VALUES
('Gustavo Dias', 'm', 21, '2004-01-06'),
('Miguel Farias', 'm', 22, '2003-01-30'),
('Pedro Lima', 'm', 23, '2002-02-23'),
('José Rodrigues', 'm', 24, '2001-03-19'),
('João Neves', 'm', 25, '2000-04-12'),
('Bruno Martins', 'm', 26, '1999-05-06'),
('Rodrigo Vieira', 'm', 26, '1998-05-30'),
('Eduardo Duarte', 'm', 27, '1997-06-23'),
('Diego Oliveira', 'm', 28, '1996-07-17'),
('Alexandre Souza', 'm', 29, '1995-08-10'),
('Carlos Andrade', 'm', 30, '1994-09-03'),
('Vitor Araújo', 'm', 31, '1993-09-27'),
('Caio Fernandes', 'm', 32, '1992-10-21'),
('Marcos Guimarães', 'm', 33, '1991-11-14'),
('Ricardo Marques', 'm', 34, '1990-12-08'),
('Fernando Lopes', 'm', 36, '1989-01-07'),
('Murilo Melo', 'm', 37, '1988-01-31'),
('Marcelo Freitas', 'm', 38, '1987-02-24'),
('Luiz Almeida', 'm', 39, '1986-03-20'),
('Leandro Silva', 'm', 40, '1985-04-13'),
('Igor Santos', 'm', 41, '1984-05-07'),
('Anderson Ferreira', 'm', 41, '1983-05-31'),
('Vicente Alves', 'm', 42, '1982-06-24'),
('Fábio Pereira', 'm', 43, '1981-07-18'),
('Renan Gomes', 'm', 44, '1980-08-11'),
('Wesley Alencar', 'm', 21, '2003-09-04'),
('Jonathan Carvalho', 'm', 22, '2002-09-28'), 
('Felipe Mendes', 'm', 23, '2001-10-22'),
('Arthur Garcia', 'm', 24, '2000-11-15'),
('Otávio Costa', 'm', 25, '1999-12-09'),
('Hugo Siqueira', 'm', 27, '1998-01-08'),
('Adriano Muniz', 'm', 28, '1997-02-01'),
('Jefferson Barbosa', 'm', 29, '1996-02-25'),
('Jorge Cavalcanti', 'm', 30, '1995-03-21'),
('Wellington Correia', 'm', 31, '1994-04-14'),
('Márcio Lacerda', 'm', 32, '1993-05-08'),
('Sérgio Queiroz', 'm', 32, '1992-06-01'),
('Renato Ribeiro', 'm', 33, '1991-06-25'),
('Breno Moreira', 'm', 34, '1990-07-19'),
('Júlio Pinheiro', 'm', 35, '1989-08-12'),
('Roberto Barros', 'm', 36, '1988-09-05'),
('Robson Castro', 'm', 37, '1987-09-29'),
('Luciano Ferraz', 'm', 38, '1986-10-23'),
('Pablo Tavares', 'm', 39, '1985-11-16'),
('Maurício Dantas', 'm', 40, '1984-12-10'),
('Rogério Magalhães', 'm', 42, '1983-01-09'),
('Flávio Soares', 'm', 43, '1982-02-02'),
('Mário Machado', 'm', 44, '1981-02-26'),
('Ronaldo Cardoso', 'm', 45, '1980-03-22'),
('Henrique Morais', 'm', 21, '2004-04-15'),
('Cecília Nascimento', 'f', 22, '2003-05-09'),
('Helena Coutinho', 'f', 22, '2002-06-02'),
('Maria Lessa', 'f', 23, '2001-06-26'),
('Mariana Aguiar', 'f', 24, '2000-07-20'),
('Laís Campos', 'f', 25, '1999-08-13'),
('Lorena Brito', 'f', 26, '1998-09-06'),
('Lívia Sampaio', 'f', 27, '1997-09-30'),
('Alice Novaes', 'f', 28, '1996-10-24'),
('Camila Nunes', 'f', 29, '1995-11-17'),
('Yasmin Batista', 'f', 30, '1994-12-11'),
('Sofia Menezes', 'f', 32, '1993-01-10'),
('Juliana Diniz', 'f', 33, '1992-02-03'),
('Isadora Moura', 'f', 34, '1991-02-27'),
('Bruna Lira', 'f', 35, '1990-03-23'),
('Vitória Pessoa', 'f', 36, '1989-04-16'),
('Manuela Silveira', 'f', 37, '1988-05-10'),
('Melissa Macedo', 'f', 37, '1987-06-03'),
('Jéssica Medeiros', 'f', 38, '1986-06-27'),
('Gabriela Guedes', 'f', 39, '1985-07-21'),
('Carolina Chaves', 'f', 40, '1984-08-14'),
('Bianca Marinho', 'f', 41, '1983-09-07'),
('Heloísa Bastos', 'f', 42, '1982-10-01'),
('Giovanna Pinto', 'f', 43, '1981-10-25'),
('Milena Barreto', 'f', 44, '1980-11-18'),
('Vanessa Cunha', 'f', 45, '1979-12-12'),
('Rafaela Figueiredo', 'f', 21, '2004-01-11'),
('Isabella Gouveia', 'f', 22, '2003-02-04'),
('Catarina Maia', 'f', 23, '2002-02-28'),
('Nicole Nogueira', 'f', 24, '2001-03-24'),
('Bárbara Paiva', 'f', 25, '2000-04-17'),
('Sabrina Ramos', 'f', 26, '1999-05-11'),
('Patrícia Teixeira', 'f', 26, '1998-06-04'),
('Thaís Albuquerque', 'f', 27, '1997-06-28'),
('Adriana Goés', 'f', 28, '1996-07-22'),
('Brenda Meireles', 'f', 29, '1995-08-15'),
('Daniela Rezende', 'f', 30, '1994-09-08'),
('Eduarda Santana', 'f', 31, '1993-10-02'),
('Alana Monteiro', 'f', 32, '1992-10-26'),
('Priscila Fonseca', 'f', 33, '1991-11-19'),
('Joana Azevedo', 'f', 34, '1990-12-13'),
('Diana Sales', 'f', 36, '1989-01-12'),
('Luísa Trindade', 'f', 37, '1988-02-05'),
('Clara Camargo', 'f', 38, '1987-03-01'),
('Natália Rocha', 'f', 39, '1986-03-25'),
('Marcela Amorim', 'f', 40, '1985-04-18'),
('Beatriz Lins', 'f', 41, '1984-05-12'),
('Luciana Matos', 'f', 41, '1983-06-05'),
('Renata Pimentel', 'f', 42, '1982-06-29'),
('Andressa Torres', 'f', 43, '1981-07-23'),
('Carla Junqueira', 'f', 44, '1980-08-16');

INSERT INTO produto (nome, quantidade, descricao, valor) VALUES
('Notebook Gamer', 15, 'Notebook com RTX 3060', 5800.00),
('Smartphone Galaxy', 50, 'Samsung Galaxy S22', 3500.00),
('TV 4K 55" ', 20, 'Smart TV 4K UHD', 2900.00),
('Fone Bluetooth', 100, 'Fone de ouvido sem fio', 200.00),
('Cadeira Gamer', 30, 'Cadeira reclinável ergonômica', 980.00),
('Mouse Óptico', 150, 'Mouse com 2400 DPI', 120.00),
('Teclado Mecânico', 80, 'Teclado RGB Switch Azul', 340.00),
('Roteador Wi-Fi 6', 45, 'Roteador com 4 antenas', 460.00),
('Monitor 27" ', 25, 'Monitor Full HD IPS', 1100.00),
('HD Externo 1TB', 60, 'Disco rígido USB 3.0', 390.00),
('SSD 512GB', 40, 'SSD NVMe M.2', 520.00),
('Carregador Turbo', 200, 'Carregador 30W', 90.00),
('Webcam Full HD', 50, 'Webcam com microfone embutido', 180.00),
('Impressora Wi-Fi', 30, 'Multifuncional a jato de tinta', 780.00),
('Caixa de Som Bluetooth', 75, 'Speaker com 12h de bateria', 320.00),
('Pen Drive 64GB', 300, 'USB 3.1', 60.00),
('Controle Xbox', 40, 'Controle sem fio original', 450.00),
('Placa de Vídeo RX 6600', 10, '8GB GDDR6', 2100.00),
('Cooler RGB', 70, 'Cooler para gabinete', 140.00),
('Estabilizador 1000VA', 20, 'Proteção de energia', 310.00);

INSERT INTO funcionario (nome, idade, sexo, cargo, salario, nascimento) VALUES
('Eduardo Leão', 45, 'm', 'CEO', 15000.00, '1979-04-18'),
('Fernanda Reis', 38, 'f', 'gerente', 9000.00, '1986-02-11'),
('Marcos Coelho', 29, 'm', 'vendedor', 3500.00, '1995-06-24'),
('Juliana Cabral', 32, 'f', 'vendedor', 3600.00, '1992-10-05'),
('Rafael Braga', 40, 'm', 'gerente', 8800.00, '1984-07-19');

CREATE USER 'administrador'@'localhost' IDENTIFIED BY 'admin123';
CREATE USER 'gerente'@'localhost' IDENTIFIED BY 'gerente123';
CREATE USER 'funcionario'@'localhost' IDENTIFIED BY 'funcionario123';

GRANT ALL PRIVILEGES ON ecommerce.* TO 'administrador'@'localhost';

GRANT SELECT, UPDATE, DELETE ON ecommerce.* TO 'gerente'@'localhost';

GRANT INSERT, SELECT ON ecommerce.* TO 'funcionario'@'localhost';
 
FLUSH PRIVILEGES;

/* Inicio das triggers */ 

CREATE OR REPLACE VIEW vendas_por_vendedor AS 
SELECT v.id_vendedor, SUM(iv.quantidade * iv.valor_unitario) AS total_vendido
FROM venda v
JOIN item_venda iv ON iv.id_venda = v.id
GROUP BY v.id_vendedor;

DELIMITER //

CREATE TRIGGER trg_bonus_vendedor
AFTER INSERT ON item_venda
FOR EACH ROW 
BEGIN 
    DECLARE total DECIMAL(10,2);
    DECLARE funcionario_id INT;
    DECLARE bonus DECIMAL(10,2);

    SELECT id_vendedor INTO funcionario_id
    FROM venda
    WHERE id = NEW.id_venda;

    SELECT SUM(iv.quantidade * iv.valor_unitario)
    INTO total
    FROM item_venda iv
    JOIN venda v ON iv.id_venda = v.id 
    WHERE v.id_vendedor = funcionario_id;

    IF total > 1000 THEN
        SET bonus = total * 0.05;

        INSERT INTO funcionarioespecial (id_funcionario, total_vendido, bonus)
        VALUES (funcionario_id, total, bonus)
        ON DUPLICATE KEY UPDATE total_vendido = total, bonus = bonus;
    END IF;
END;
//

DELIMITER ;

CREATE OR REPLACE VIEW gastos_por_cliente AS 
SELECT v.id_cliente, SUM(iv.quantidade * iv.valor_unitario) AS total_gasto 
FROM venda v
JOIN item_venda iv ON iv.id_venda = v.id
GROUP BY v.id_cliente;

DELIMITER //

CREATE TRIGGER trg_cashback_cliente
AFTER INSERT ON item_venda
FOR EACH ROW 
BEGIN 
    DECLARE cliente_id INT;
    DECLARE total DECIMAL(10,2);
    DECLARE cashback DECIMAL(10,2);

    SELECT id_cliente INTO cliente_id
    FROM venda 
    WHERE id = NEW.id_venda;

    SELECT SUM(iv.quantidade * iv.valor_unitario)
    INTO total
    FROM item_venda iv
    JOIN venda v ON iv.id_venda = v.id
    WHERE v.id_cliente = cliente_id;

    IF total > 500 THEN 
        SET cashback = total * 0.02;

        INSERT INTO clienteespecial (nome, sexo, idade, id_cliente, cashback )
        SELECT c.nome, c.sexo, c.idade, c.id, cashback 
        FROM cliente c
        WHERE c.id = cliente_id 
        ON DUPLICATE KEY UPDATE cashback = cashback;
    END IF;
END;
//

DELIMITER ;

DELIMITER //

CREATE TRIGGER trg_remover_cliente_especial 
AFTER UPDATE ON clienteespecial
FOR EACH ROW 
BEGIN 
    IF NEW.cashback = 0 THEN
        DELETE FROM clienteespecial WHERE id = NEW.id;
    END IF;
END;
//

DELIMITER ;

DELIMITER //

CREATE PROCEDURE ReajusteSalario(IN cargo_tipo VARCHAR(20), IN percentual DECIMAL(5,2))
BEGIN
    UPDATE funcionario
    SET salario = salario * (1 + (percentual / 100))
    WHERE cargo = cargo_tipo;
END;
//

DELIMITER ;

DELIMITER //
CREATE PROCEDURE SorteioClientes()
BEGIN
    DECLARE cliente_sorteado INT;
    DECLARE valor_voucher DECIMAL(10,2);
    DECLARE codigo_voucher VARCHAR(20);
    
    SELECT id INTO cliente_sorteado FROM cliente ORDER BY RAND() LIMIT 1;
    
    -- Verifica se é cliente especial para definir o valor
    IF EXISTS (SELECT 1 FROM clienteespecial WHERE id_cliente = cliente_sorteado) THEN
        SET valor_voucher = 200.00;
    ELSE
        SET valor_voucher = 100.00;
    END IF;
    
    -- Gera um código único para o voucher
    SET codigo_voucher = CONCAT('VOUCHER-', FLOOR(RAND() * 1000000));
    
    INSERT INTO vouchers (id_cliente, valor, codigo)
    VALUES (cliente_sorteado, valor_voucher, codigo_voucher);
    
    SELECT CONCAT('Cliente sorteado: ', (SELECT nome FROM cliente WHERE id = cliente_sorteado), 
                  ' - Voucher: ', codigo_voucher, 
                  ' - Valor: R$ ', valor_voucher) AS resultado;
END //
DELIMITER ;

DELIMITER //
CREATE PROCEDURE RegistrarVenda(IN id_cliente INT, IN id_vendedor INT, IN id_produto INT, IN quantidade INT, IN valor_unitario DECIMAL(10,2))
BEGIN
    DECLARE venda_id INT;
    DECLARE estoque_atual INT;
    
    -- Verificar estoque
    SELECT qtd INTO estoque_atual FROM produto WHERE id_produto = id_produto;
    
    IF estoque_atual >= quantidade THEN
        -- Registrar venda
        INSERT INTO venda (id_cliente, id_vendedor, dia_venda) VALUES (id_cliente, id_vendedor, NOW());
        SET venda_id = LAST_INSERT_ID();
        
        -- Registrar itens
        INSERT INTO item_venda (id_venda, id_produto, quantidade, valor_unitario) 
        VALUES (venda_id, id_produto, quantidade, valor_unitario);
        
        -- Atualizar estoque
        UPDATE produto SET qtd = qtd - quantidade WHERE id_produto = id_produto;
    ELSE
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Estoque insuficiente';
    END IF;
END //
DELIMITER ;

DELIMITER //
CREATE PROCEDURE EstatisticasVendas()
BEGIN
    -- Produto mais vendido
    SELECT p.nome as produto_mais_vendido, SUM(iv.quantidade) as quantidade
    FROM item_venda iv
    JOIN produto p ON iv.id_produto = p.id_produto
    GROUP BY iv.id_produto
    ORDER BY quantidade DESC
    LIMIT 1;
    
    -- Produto menos vendido
    SELECT p.nome as produto_menos_vendido, SUM(iv.quantidade) as quantidade
    FROM item_venda iv
    JOIN produto p ON iv.id_produto = p.id_produto
    GROUP BY iv.id_produto
    ORDER BY quantidade ASC
    LIMIT 1;
    
    -- Meses com maior/menor vendas
    SELECT 
        MONTH(v.dia_venda) as mes,
        COUNT(v.id_venda) as total_vendas
    FROM venda v
    GROUP BY MONTH(v.dia_venda)
    ORDER BY total_vendas DESC;
END //
DELIMITER ;
