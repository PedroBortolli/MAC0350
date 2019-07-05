CREATE EXTENSION IF NOT EXISTS pgcrypto;

INSERT INTO pessoa(nome) VALUES
	('Bortolli'),
	('Teotonio'),
	('Daher'),
	('Jonas'),
	('Enzo'),
	('Moretto'),
	('Rubens'),
	('Thiago'),
	('Ricardo'),
	('Breno'),
	('Jef'),
	('Carlinhos'),
	('Hirata'),
	('Renata'),
	('Daniel'),
	('Fabio'),
	('Coelho'),
	('Cris'),
	('Roberto'),
	('Nina'),
	('Decio');

INSERT INTO aluno(id_aluno, ano_ingresso) VALUES
	(1, 2016),
	(2, 2016),
	(3, 2015),
	(4, 2016),
	(5, 2015),
	(6, 2017),
	(7, 2016),
	(8, 2017),
	(9, 2015),
	(10, 2017);

INSERT INTO professor(id_professor, formacao_area) VALUES
	(11, 'Banco de dados'),
	(12, 'Teoria'),
	(13, 'Machine Learning'),
	(14, 'IA'),
	(15, 'Sistemas'),
	(16, 'Sistemas'),
	(17, 'Teoria'),
	(18, 'Teoria'),
	(19, 'Machine Learning'),
	(20, 'Machine Learning');

INSERT INTO administrador(id_adm, inicio, fim) VALUES
	(11, '20-05-2019', '20-05-2020'),
	(12, '01-01-2010', '01-01-2040'),
	(13, '01-01-2015', '01-01-2050'),
	(14, '03-01-2016', '01-01-2050'),
	(15, '20-05-2016', '20-01-2040'),
	(16, '06-01-2017', '01-01-2050'),
	(17, '07-01-2015', '01-01-2030'),
	(18, '07-05-2018', '01-01-2030'),
	(20, '01-05-2019', '01-01-2020'),
	(21, '02-01-2019', '01-01-2022');