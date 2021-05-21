CREATE TABLE Empregado (
	Cod_emp			VARCHAR (20)	NOT NULL PRIMARY KEY,
	Nome_emp		VARCHAR (20)	NOT NULL, 
	Salario_emp		NUMERIC (5)		NOT NULL, 
	Comissao_emp	NUMERIC (5)		NOT NULL, 
	Cod_depto_emp	VARCHAR (20)	NOT NULL
);

CREATE TABLE Departamento (
	Cod_depto	VARCHAR (20)	NOT NULL PRIMARY KEY,
	Nome_depto	VARCHAR (20)	NOT NULL
);

CREATE TABLE Projeto( 
	Cod_proj			VARCHAR (20)	NOT NULL PRIMARY  KEY, 
	Nome_proj			VARCHAR (20)	NOT NULL,
	Cod_gerente_proj	VARCHAR (20)	NOT NULL 
); 

CREATE TABLE Equipe_Projeto(
	Cod_proj_equipe VARCHAR (20)	NOT NULL,
	Cod_emp_equipe	VARCHAR (20)	NOT NULL
);

ALTER TABLE Empregado
ADD FOREIGN KEY (Cod_depto_emp) REFERENCES DEPARTAMENTO(Cod_depto);

ALTER TABLE Projeto
ADD FOREIGN KEY (Cod_gerente_proj) REFERENCES EMPREGADO(Cod_emp);

ALTER TABLE Equipe_Projeto 
ADD FOREIGN KEY (Cod_proj_equipe) REFERENCES PROJETO(Cod_proj),
	FOREIGN KEY (Cod_emp_equipe) REFERENCES EMPREGADO(Cod_emp);

INSERT INTO Empregado
VALUES ('EMP01', 'Tony', 1800, 20, 'DP01'),
	   ('EMP02', 'Paul', 2400, 15, 'DP03'),
	   ('EMP03', 'Rick', 2600, 22, 'DP06'),
	   ('EMP04', 'Alex', 3700, 19, 'DP04'),
	   ('EMP05', 'Carl', 4500, 21, 'DP01'),
	   ('EMP06', 'Nick', 5300, 23, 'DP03'),
	   ('EMP07', 'John', 7000, 30, 'DP05'),
	   ('EMP08', 'Jake', 7200, 29, 'DP02'),
	   ('EMP09', 'Rony', 8500, 40, 'DP06'),
	   ('EMP10', 'Liam', 9300, 36, 'DP05'),
	   ('EMP11', 'Noah', 9900, 50, 'DP06');

INSERT INTO Departamento
VALUES ('DP01', 'Departamento A'),
	   ('DP02', 'Departamento B'),
	   ('DP03', 'Departamento C'),
	   ('DP04', 'Departamento D'),
	   ('DP05', 'Departamento E'),
	   ('DP06', 'Departamento F');

INSERT INTO Projeto
VALUES ('PRJ01', 'Projeto A', 'EMP10'),
	   ('PRJ02', 'Projeto B', 'EMP11'),
	   ('PRJ03', 'Projeto C', 'EMP09'),
	   ('PRJ04', 'Projeto D', 'EMP09'),
	   ('PRJ05', 'Projeto E', 'EMP11'),
	   ('PRJ06', 'Projeto F', 'EMP11');

INSERT INTO Equipe_Projeto
VALUES ('PRJ01', 'EMP02'),
	   ('PRJ01', 'EMP03'),
	   ('PRJ01', 'EMP10'),
	   ('PRJ02', 'EMP05'),
	   ('PRJ02', 'EMP01'),
	   ('PRJ02', 'EMP11'),
	   ('PRJ03', 'EMP06'),
	   ('PRJ03', 'EMP09'),
	   ('PRJ04', 'EMP04'),
	   ('PRJ04', 'EMP09'),
	   ('PRJ04', 'EMP04'),
	   ('PRJ05', 'EMP07'),
	   ('PRJ05', 'EMP06'),
	   ('PRJ06', 'EMP11'),	 
	   ('PRJ06', 'EMP01'),
	   ('PRJ06', 'EMP05'),
	   ('PRJ06', 'EMP11');	   

select * from Empregado;
select * from Departamento;
select * from projeto;
select * from Equipe_Projeto;

--#01
SELECT DISTINCT Empregado.Nome_emp
FROM Empregado
INNER JOIN Equipe_Projeto ON Empregado.Cod_emp=Equipe_Projeto.Cod_emp_equipe
AND Equipe_Projeto.Cod_proj_equipe = 'PRJ01';

--#02
SELECT Empregado.Nome_emp, Salario_emp, Departamento.Nome_depto
FROM Empregado
INNER JOIN Departamento ON Empregado.Cod_depto_emp=Departamento.Cod_depto
AND Empregado.Salario_emp > 1000
ORDER BY Empregado.Nome_emp;

--#03 (obs: empregado com código "15029" => empregado "0600")
SELECT Projeto.Cod_proj, Projeto.Nome_proj, Projeto.Cod_gerente_proj 
FROM Empregado
JOIN Equipe_Projeto ON Empregado.Cod_emp=Equipe_Projeto.Cod_emp_equipe
AND Equipe_Projeto.Cod_emp_equipe = 'EMP06'
JOIN Projeto ON Equipe_Projeto.Cod_proj_equipe=Projeto.Cod_proj;

--#04 
SELECT DISTINCT Empregado.Nome_emp, Departamento.Cod_depto, Departamento.Nome_depto, Projeto.Nome_proj
FROM Empregado
JOIN Departamento ON Empregado.Cod_depto_emp=Departamento.Cod_depto
JOIN Equipe_Projeto ON Empregado.Cod_emp=Equipe_Projeto.Cod_emp_equipe
JOIN Projeto ON Equipe_Projeto.Cod_proj_equipe=Projeto.Cod_proj;

--#05
SELECT Empregado.Nome_emp, Empregado.Cod_emp, Projeto.Nome_proj
FROM Empregado
JOIN Projeto ON Empregado.Cod_emp=Projeto.Cod_gerente_proj
ORDER BY Empregado.Nome_emp;

--#06
SELECT Empregado.Nome_emp, Empregado.Salario_emp, Departamento.Nome_depto
FROM Empregado
JOIN Departamento ON Empregado.Cod_depto_emp=Departamento.Cod_depto 
AND Empregado.Salario_emp > 1200
ORDER BY Empregado.Nome_emp;

--#07
SELECT Empregado.Nome_emp
FROM Empregado
JOIN Equipe_Projeto ON Empregado.Cod_emp=Equipe_Projeto.Cod_emp_equipe
JOIN Projeto ON Equipe_Projeto.Cod_proj_equipe=Projeto.Cod_proj
AND Empregado.Cod_emp != Projeto.Cod_gerente_proj;