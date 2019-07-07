CREATE EXTENSION IF NOT EXISTS pgcrypto;

SELECT cria_pessoa('Bortolli');
SELECT cria_pessoa('Teotonio');
SELECT cria_pessoa('Daher');
SELECT cria_pessoa('Jonas');
SELECT cria_pessoa('Enzo');
SELECT cria_pessoa('Moretto');
SELECT cria_pessoa('Rubens');
SELECT cria_pessoa('Thiago');
SELECT cria_pessoa('Ricardo');
SELECT cria_pessoa('Breno');
SELECT cria_pessoa('Jef');
SELECT cria_pessoa('Carlinhos');
SELECT cria_pessoa('Hirata');
SELECT cria_pessoa('Renata');
SELECT cria_pessoa('Daniel');
SELECT cria_pessoa('Fabio');
SELECT cria_pessoa('Coelho');
SELECT cria_pessoa('Cris');
SELECT cria_pessoa('Roberto');
SELECT cria_pessoa('Nina');
SELECT cria_pessoa('Decio');


SELECT cria_aluno('Bortolli', 2016);
INSERT INTO aluno(id_aluno, ano_ingresso) VALUES
	(2, 2016),
	(3, 2015),
	(4, 2016),
	(5, 2015),
	(6, 2017),
	(7, 2016),
	(8, 2017),
	(9, 2015),
	(10, 2017);

SELECT cria_professor('Jef', 'Banco de dados');
INSERT INTO professor(id_professor, formacao_area) VALUES
	(12, 'Teoria'),
	(13, 'Machine Learning'),
	(14, 'IA'),
	(15, 'Sistemas'),
	(16, 'Sistemas'),
	(17, 'Teoria'),
	(18, 'Teoria'),
	(19, 'Machine Learning'),
	(20, 'Machine Learning');

SELECT cria_administrador('Jef', '20-05-2019', '20-05-2020');
INSERT INTO administrador(id_adm, inicio, fim) VALUES
	(12, '01-01-2010', '01-01-2040'),
	(13, '01-01-2015', '01-01-2050'),
	(14, '03-01-2016', '01-01-2050'),
	(15, '20-05-2016', '20-01-2040'),
	(16, '06-01-2017', '01-01-2050'),
	(17, '07-01-2015', '01-01-2030'),
	(18, '07-05-2018', '01-01-2030'),
	(20, '01-05-2019', '01-01-2020'),
	(21, '02-01-2019', '01-01-2022');