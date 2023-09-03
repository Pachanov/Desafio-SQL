-- Replique a modelagem do projeto lógico de banco de dados para o cenário de 
-- e-commerce. Fique atento as definições de chave primária e estrangeira,
--  assim como as constraints presentes no cenário modelado. Perceba que 
-- dentro desta modelagem haverá relacionamentos presentes no modelo EER. 
-- Sendo assim, consulte como proceder para estes casos. Além disso, aplique o 
-- mapeamento de modelos aos refinamentos propostos no módulo de modelagem conceitual.

-- Criação das tabelas
CREATE TABLE Cliente
(
    ClienteID INT PRIMARY KEY,
    Nome VARCHAR(255),
    CPF VARCHAR(11),
    CNPJ VARCHAR(14),
    Email VARCHAR(255),
    Telefone VARCHAR(20)
);

CREATE TABLE Conta
(
    ContaID INT PRIMARY KEY,
    ClienteID INT,
    Tipo VARCHAR(2),
    FOREIGN KEY (ClienteID) REFERENCES Cliente(ClienteID)
);

-- Crie as tabelas restantes seguindo o mesmo padrão

-- Consultas SQL
-- Recuperação simples de todos os produtos
SELECT *
FROM Produto;

-- Recuperação de clientes com filtro por tipo de conta
SELECT *
FROM Cliente
WHERE Tipo = 'PJ';

-- Criação de atributo derivado para calcular o total de um pedido
SELECT Pedido.PedidoID, SUM(ItemPedido.Quantidade * ItemPedido.PrecoUnitario) AS Total
FROM Pedido
    JOIN ItemPedido ON Pedido.PedidoID = ItemPedido.PedidoID
GROUP BY Pedido.PedidoID;

-- Ordenação de produtos por preço
SELECT *
FROM Produto
ORDER BY Preco DESC;

-- Filtros e agregação para encontrar clientes que fizeram mais de 3 pedidos
SELECT Cliente.ClienteID, Cliente.Nome, COUNT(Pedido.PedidoID) AS TotalPedidos
FROM Cliente
    JOIN Pedido ON Cliente.ClienteID = Pedido.ClienteID
GROUP BY Cliente.ClienteID, Cliente.Nome
HAVING COUNT(Pedido.PedidoID) > 3;

-- Junção de tabelas para obter informações detalhadas do pedido e do cliente
SELECT Pedido.PedidoID, Cliente.Nome AS NomeCliente, Pedido.Status, Entrega.Status AS StatusEntrega
FROM Pedido
    JOIN Cliente ON Pedido.ClienteID = Cliente.ClienteID
    LEFT JOIN Entrega ON Pedido.PedidoID = Entrega.PedidoID;
