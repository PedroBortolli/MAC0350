CREATE EXTENSION IF NOT EXISTS pgcrypto;

INSERT INTO pessoa(nome) VALUES
	('Bortolli'),
	('Teotonio'),
	('Daher'),
	('Jonas'),
	('Enzo'),
	('Jef'),
	('Carlinhos'),
	('Hirata'),
	('Renata'),
	('Daniel'),
	('Decio');

INSERT INTO aluno(id_aluno, ano_ingresso) VALUES
	(1, 2016),
	(2, 2016),
	(3, 2015),
	(4, 2016);

INSERT INTO professor(id_professor, formacao_area) VALUES
	(6, 'Banco de dados'),
	(7, 'Teoria'),
	(8, 'Machine Learning'),
	(9, 'IA'),
	(10, 'Sistemas');

INSERT INTO administrador(id_adm, inicio, fim) VALUES
	(11, '20-05-2019', '20-05-2020'),
	(10, '01-01-2010', '01-01-2040'),
	(9, '01-01-2015', '01-01-2050');