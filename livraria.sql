CREATE DATABASE livraria;
USE livraria;

CREATE TABLE Produto (
    id_produto INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    preco DECIMAL(10,2) NOT NULL,
    estoque INT NOT NULL
);

CREATE TABLE Pedido (
    id_pedido INT AUTO_INCREMENT PRIMARY KEY,
    data_pedido DATE NOT NULL,
    nome_cliente VARCHAR(100) NOT NULL
);

CREATE TABLE ItemPedido (
    id_item INT AUTO_INCREMENT PRIMARY KEY,
    id_pedido INT NOT NULL,
    id_produto INT NOT NULL,
    quantidade INT NOT NULL,
    FOREIGN KEY (id_pedido) REFERENCES Pedido(id_pedido),
    FOREIGN KEY (id_produto) REFERENCES Produto(id_produto)
);

INSERT INTO Produto (nome, preco, estoque) VALUES
('Dom Casmurro', 45.90, 10),
('1984', 39.50, 15),
('A Revolução dos Bichos', 29.90, 20);

INSERT INTO Pedido (data_pedido, nome_cliente) VALUES
('2025-10-14', 'João Pereira'),
('2025-10-14', 'Maria Silva'),
('2025-10-15', 'Carlos Souza');

INSERT INTO ItemPedido (id_pedido, id_produto, quantidade) VALUES
(1, 1, 1),
(1, 2, 2),
(2, 3, 1),
(3, 1, 1),
(3, 3, 3);
