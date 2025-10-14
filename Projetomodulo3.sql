-- ======================================================
-- PROJETO: SISTEMA DE GESTÃO DE PEDIDOS
-- DISCIPLINA: PROJETO INTEGRADOR DE TECNOLOGIA DA INFORMAÇÃO II
-- AUTOR: Rafael Regis Ferreira de Lima
-- SEMESTRE: 2025.2
-- ======================================================

-- 1. CRIAÇÃO DO BANCO DE DADOS
CREATE DATABASE gestao_pedidos;
USE gestao_pedidos;

-- 2. CRIAÇÃO DAS TABELAS
CREATE TABLE cliente (
    id_cliente INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    email VARCHAR(120) UNIQUE NOT NULL,
    telefone VARCHAR(20),
    cidade VARCHAR(60)
);

CREATE TABLE produto (
    id_produto INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    preco DECIMAL(10,2) NOT NULL,
    estoque INT NOT NULL DEFAULT 0
);

CREATE TABLE pedido (
    id_pedido INT AUTO_INCREMENT PRIMARY KEY,
    id_cliente INT NOT NULL,
    data_pedido DATE NOT NULL,
    status_pedido ENUM('PENDENTE','PAGO','CANCELADO') DEFAULT 'PENDENTE',
    FOREIGN KEY (id_cliente) REFERENCES cliente(id_cliente)
);

CREATE TABLE item_pedido (
    id_item INT AUTO_INCREMENT PRIMARY KEY,
    id_pedido INT NOT NULL,
    id_produto INT NOT NULL,
    quantidade INT NOT NULL,
    valor_unitario DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (id_pedido) REFERENCES pedido(id_pedido),
    FOREIGN KEY (id_produto) REFERENCES produto(id_produto)
);

-- 3. INSERÇÃO DE DADOS
INSERT INTO cliente (nome, email, telefone, cidade) VALUES
('Ana Souza', 'ana.souza@email.com', '(67) 99999-1111', 'Campo Grande'),
('Bruno Lima', 'bruno.lima@email.com', '(67) 98888-2222', 'Dourados'),
('Carla Mendes', 'carla.mendes@email.com', '(67) 97777-3333', 'Três Lagoas');

INSERT INTO produto (nome, preco, estoque) VALUES
('Camiseta Bordada', 45.90, 50),
('Colar Artesanal', 35.00, 30),
('Pulseira de Miçanga', 20.00, 80),
('Quadro Decorativo', 150.00, 15);

INSERT INTO pedido (id_cliente, data_pedido, status_pedido) VALUES
(1, '2025-10-10', 'PAGO'),
(2, '2025-10-12', 'PENDENTE'),
(3, '2025-10-13', 'CANCELADO');

INSERT INTO item_pedido (id_pedido, id_produto, quantidade, valor_unitario) VALUES
(1, 1, 2, 45.90),
(1, 2, 1, 35.00),
(2, 3, 3, 20.00),
(3, 4, 1, 150.00);

-- 4. CONSULTAS (SELECT)
-- 4.1 Listar todos os pedidos com nome do cliente
SELECT p.id_pedido, c.nome AS cliente, p.data_pedido, p.status_pedido
FROM pedido p
JOIN cliente c ON p.id_cliente = c.id_cliente;

-- 4.2 Consultar itens e total de um pedido
SELECT 
    i.id_pedido,
    c.nome AS cliente,
    SUM(i.quantidade * i.valor_unitario) AS total_pedido
FROM item_pedido i
JOIN pedido p ON i.id_pedido = p.id_pedido
JOIN cliente c ON p.id_cliente = c.id_cliente
GROUP BY i.id_pedido, c.nome;

-- 4.3 Consultar produtos com estoque baixo
SELECT nome, estoque 
FROM produto
WHERE estoque < 20;

-- 4.4 Consultar clientes com pedidos pagos
SELECT DISTINCT c.nome, c.email
FROM cliente c
JOIN pedido p ON c.id_cliente = p.id_cliente
WHERE p.status_pedido = 'PAGO';

-- 5. ATUALIZAÇÃO DE DADOS (UPDATE)
UPDATE produto
SET estoque = estoque - 3
WHERE id_produto = 3;

UPDATE pedido
SET status_pedido = 'PAGO'
WHERE id_pedido = 2;

-- 6. REMOÇÃO DE DADOS (DELETE)
DELETE FROM item_pedido
WHERE id_item = 4;

DELETE FROM pedido
WHERE id_pedido = 3;

-- 7. CONSULTA FINAL - VISUALIZAÇÃO GERAL
SELECT 
    p.id_pedido,
    c.nome AS cliente,
    p.data_pedido,
    p.status_pedido,
    SUM(i.quantidade * i.valor_unitario) AS valor_total
FROM pedido p
JOIN cliente c ON p.id_cliente = c.id_cliente
JOIN item_pedido i ON p.id_pedido = i.id_pedido
GROUP BY p.id_pedido, c.nome, p.data_pedido, p.status_pedido
ORDER BY p.data_pedido DESC;
