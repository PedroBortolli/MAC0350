CREATE EXTENSION IF NOT EXISTS pgcrypto;

INSERT INTO curriculo(codigo, nome) VALUES
	(45, 'Bacharelado em Ciência da Computação'),
	(46, 'Bacharelado em Ciência da Computação 2'),
	(50, 'Matemática Pura'),
	(60, 'Matemática Aplicada'),
	(61, 'Matemática Aplicada e Computacional'),
	(70, 'Estatística'),
	(80, 'Licenciatura em Matemática'),
	(81, 'Licenciatura em Matemática 2'),
	(82, 'Licenciatura em Matemática 3'),
	(83, 'Licenciatura em Matemática 4');

INSERT INTO trilha(nome, descricao, quant_mod) VALUES
	('teoria', 'Teoria da computação, matemática discreta, algoritmos, etc.', 12),
	('sistemas', 'Sistemas de software, banco de dados, programação paralela, etc.', 16),
	('ia', 'Inteligência artificial, machine learning, etc.', 6),
	('cdbioinformatica', 'Ciência de dados, bioinformática', 8),
	('cdeconomia', 'Ciência de dados, economia', 8),
	('cdadministracao', 'Ciência de dados, administração', 8),
	('cdmecatronica', 'Ciência de dados, mecatrônica', 8),
	('cdastronomia', 'Ciência de dados, astronomia', 8),
	('cdmusica', 'Ciência de dados, música', 8),
	('cdengenharia', 'Ciência de dados, engenharia', 8);


INSERT INTO modulo(id_trilha, nome, descricao, quant_disc) VALUES
	(1, 'matematica discreta', 'Matérias de matemática discreta', 6),
	(1, 'algoritmos', 'Matérias de algoritmos e estruturas de dados', 5),
	(2, 'banco de dados', 'Matérias relacionadas a banco de dados', 3),
	(2, 'sistemas paralelos e distribuidos', 'Matérias de sistemas paralelos e distribuidos', 3),
	(3, 'machine learning', 'Matérias de machine learning', 3),
	(3, 'introducao a ia', 'Matérias de introdução à IA', 4),
	(3, 'teoria associada a ia', 'Matérias de teoria associada à IA', 4),
	(4, 'nucleo 1', 'Matérias do núcleo 1 relacionadas a introdução a ciencia de dados', 3),
	(4, 'nucleo 2', 'Matérias do núcleo 2 relacionadas a estatística', 3),
	(4, 'nucleo 3', 'Matérias do núcleo 3 relacionadas a otimização', 3);


INSERT INTO disciplina(codigo, nome, creditos_aula, creditos_trabalho, instituto) VALUES
	('MAC0350', 'Introdução ao Desenvolvimento de Sistemas de Software', 4, 2, 'IME'),
	('MAC0470', 'Desenvolvimento de Software Livre', 4, 2, 'IME'),
	('MAC0105', 'Fundamentos de Matemática para a Computação', 4, 0, 'IME'),
	('MAC0110', 'Introdução à Computação', 4, 0, 'IME'),
	('MAC0121', 'Algoritmo e Estruturas de Dados I', 4, 0, 'IME'),
	('MAC0323', 'Algoritmo e Estruturas de Dados II', 4, 0, 'IME'),
	('MAT0122', 'Álgebra Linear I', 4, 0, 'IME'),
	('MAT2453', 'Cálculo Diferencial e Integral I', 6, 0, 'IME'),
	('MAT2454', 'Cálculo Diferencial e Integral II', 4, 0, 'IME'),
	('MAT0236', 'Funções Diferenciáveis e Séries', 4, 0, 'IME');

INSERT INTO requisito(codigo_disc, codigo_req) VALUES
	('MAC0323', 'MAC0121'),
	('MAT2454', 'MAT2453'),
	('MAT0236', 'MAT2454'),
	('MAC0350', 'MAC0323'),
	('MAC0470', 'MAC0121'),
	('MAC0470', 'MAC0350'),
	('MAT0236', 'MAT0122'),
	('MAC0121', 'MAC0110'),
	('MAC0323', 'MAC0105'),
	('MAT0236', 'MAC0105');

INSERT INTO rel_cur_tri(codigo, id_trilha) VALUES
	(45, 1),
	(45, 2),
	(45, 3),
	(45, 4),
	(45, 5),
	(46, 6),
	(46, 7),
	(46, 8),
	(46, 9),
	(46, 10);

INSERT INTO rel_mod_dis(id_modulo, codigo, obrigatoria) VALUES
	(1, 'MAC0350', '1'),
	(2, 'MAC0470', '1'),
	(3, 'MAC0105', '0'),
	(4, 'MAC0110', '0'),
	(5, 'MAC0121', '0'),
	(6, 'MAC0323', '1'),
	(7, 'MAT0122', '1'),
	(8, 'MAT2453', '0'),
	(9, 'MAT2454', '0'),
	(10, 'MAT0236', '1');