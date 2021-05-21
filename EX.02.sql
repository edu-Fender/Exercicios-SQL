CREATE TABLE Tb_VENDEDOR ( 
	Nro_VEND		NUMERIC (5)		NOT NULL PRIMARY KEY,
	Nm_VEND			VARCHAR (20)	NOT NULL, 
	COMISSAO		NUMERIC (5)		NOT NULL, 
	ANO_CONTRATACAO	NUMERIC (4)	    NOT NULL, 
	Nro_ESCR		NUMERIC (5)		NOT NULL 
);

CREATE TABLE Tb_CLIENTE (
	Nro_CLI			NUMERIC (5)		NOT NULL PRIMARY KEY,
	Nm_CLI			VARCHAR (20)	NOT NULL, 
	Nro_VEND		NUMERIC (5)		NOT NULL,
	CIDADE_MATRIZ	VARCHAR (20)	NOT NULL
);
		
CREATE TABLE Tb_VENDAS (
	Nro_VEND	NUMERIC (5)		NOT NULL PRIMARY KEY, 
	Nro_PROD	NUMERIC (5)		NOT NULL,
	Qtde		NUMERIC (5)		NOT NULL
);

CREATE TABLE Tb_Empregadodocliente (
	Nro_CLI	 NUMERIC (5)	NOT NULL, 
	Nro_EMP	 NUMERIC (5)	NOT NULL PRIMARY KEY,
	Nm_EMP	 VARCHAR (20)	NOT NULL, 
	CARGO	 VARCHAR (20)	NOT NULL
);

CREATE TABLE Tb_Produto (
	Nro_prod	NUMERIC (5)		NOT NULL PRIMARY KEY, 
	Nm_prod		VARCHAR (20)	NOT NULL,
	Pr_unit		NUMERIC (5)		NOT NULL
);

ALTER TABLE Tb_CLIENTE
ADD FOREIGN KEY (Nro_VEND) REFERENCES Tb_VENDEDOR(Nro_VEND)

ALTER TABLE Tb_VENDAS
ADD FOREIGN KEY (Nro_PROD) REFERENCES Tb_Produto(Nro_PROD) 

ALTER TABLE Tb_Empregadodocliente
ADD FOREIGN KEY (Nro_CLI) REFERENCES Tb_CLIENTE(Nro_CLI)

INSERT INTO Tb_VENDEDOR
VALUES (137, 'Baker', 10, 1995, 1284),
	   (186, 'Adams', 15, 2001, 1253),
	   (204, 'Dickens', 10, 1998, 1209),
	   (361, 'Carlyle', 20, 2001, 1227);
	   
INSERT INTO Tb_CLIENTE
VALUES (0121, 'Main', 137, 'Nova York'),
	   (0839, 'Jane´s', 186, 'Chicago'),
	   (0933, 'ABC',	137, 'Los Angeles'),
	   (1525, 'Acme', 361, 'Atlanta');
	   
INSERT INTO Tb_VENDAS
VALUES (137, 19440, 473),
	   (186, 16386, 1745),
	   (204, 21765, 809),
	   (187, 24013, 3110);
	   
INSERT INTO Tb_EmpregadodoCliente
VALUES (0121, 27498, 'Smith', 'Co-proprietario'),
	   (1525, 33779, 'Baker', 'Gerente vendas'),
	   (0933, 30441, 'Levy', 'Gerente vendas'),
	   (0839, 27470, 'Smith', 'Presidente');
	   
INSERT INTO Tb_Produto
VALUES (16386, 'Chave Inglesa', 12.95),
	   (19440, 'Martelo', 17.50),
	   (21765, 'Furadeira', 32.99),
	   (24013, 'Serrote', 26.25);

SELECT * FROM Tb_VENDEDOR;
SELECT * FROM Tb_CLIENTE;
SELECT * FROM Tb_VENDAS;
SELECT * FROM Tb_Empregadodocliente;
SELECT * FROM Tb_Produto;

--a)
SELECT Nro_CLI AS Numero_Cliente, Nm_CLI AS Nome_Cliente, CIDADE_MATRIZ AS Cidade_Principal
FROM Tb_CLIENTE
WHERE CIDADE_MATRIZ = 'Atlanta'
AND Nro_CLI > 1500

--b)
SELECT Tb_Produto.Nm_prod AS Numero_Produto, Tb_VENDAS.Nro_VEND AS Numero_Vendedor
FROM Tb_Produto 
JOIN Tb_VENDAS ON Tb_Produto.Nro_prod=Tb_VENDAS.Nro_PROD
AND Nro_VEND=186
AND Qtde > 1500

--c)
SELECT Tb_CLIENTE.Nm_CLI, Tb_VENDAS.Nro_prod
FROM Tb_VENDAS
JOIN Tb_CLIENTE ON Tb_VENDAS.Nro_VEND=Tb_CLIENTE.Nro_VEND
WHERE Tb_CLIENTE.Nro_VEND = 137

--d)
SELECT Tb_Empregadodocliente.CARGO, Tb_Empregadodocliente.Nm_EMP
FROM Tb_Empregadodocliente
JOIN Tb_CLIENTE ON Tb_Empregadodocliente.Nro_CLI=Tb_CLIENTE.Nro_CLI
JOIN Tb_VENDEDOR ON Tb_CLIENTE.Nro_VEND=Tb_VENDEDOR.Nro_VEND
WHERE Tb_VENDEDOR.ANO_CONTRATACAO > 2000

--e.1 Mostrar todos os vendedores que possuem algum cliente, bem como seu respectivo cliente e a cidade matriz do cliente
SELECT Tb_VENDEDOR.Nm_VEND, Tb_CLIENTE.Nm_CLI, Tb_CLIENTE.CIDADE_MATRIZ
FROM Tb_VENDEDOR
INNER JOIN Tb_CLIENTE ON Tb_VENDEDOR.Nro_VEND=Tb_CLIENTE.Nro_VEND

--e.2 Mostrar todos os vendedores e todos os clientes, bem como as cidades matrizes dos clientes
SELECT Tb_VENDEDOR.Nm_VEND, Tb_CLIENTE.Nm_CLI, Tb_CLIENTE.CIDADE_MATRIZ
FROM Tb_VENDEDOR
FULL JOIN Tb_CLIENTE ON Tb_VENDEDOR.Nro_VEND=Tb_CLIENTE.Nro_VEND

--e.3 Mostrar todos os vendedores, porém somente os clientes que possuem algum vendendor, bem como sua cidade matriz
SELECT Tb_VENDEDOR.Nm_VEND, Tb_CLIENTE.Nm_CLI, Tb_CLIENTE.CIDADE_MATRIZ
FROM Tb_VENDEDOR
LEFT JOIN Tb_CLIENTE ON Tb_VENDEDOR.Nro_VEND=Tb_CLIENTE.Nro_VEND

--e.4 Mostrar todos os clientes e suas respectivas cidades, porém somente os vendedores que possuem algum cliente
SELECT Tb_VENDEDOR.Nm_VEND, Tb_CLIENTE.Nm_CLI, Tb_CLIENTE.CIDADE_MATRIZ
FROM Tb_VENDEDOR
RIGHT JOIN Tb_CLIENTE ON Tb_VENDEDOR.Nro_VEND=Tb_CLIENTE.Nro_VEND
