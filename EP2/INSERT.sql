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


INSERT INTO usuario(id_usuario, login, email, senha) VALUES
	(1, 'bortolli', 'bortolli@ime.usp.br', crypt('bortollipassword', gen_salt('bf'))),
	(2, 'teotonio', 'teotonio@ime.usp.br', crypt('teopass', gen_salt('bf'))),
	(3, 'daher', 'daher@ime.usp.br', crypt('dahersenha', gen_salt('bf')));


INSERT INTO administrador(id_adm, inicio, fim) VALUES
	(11, '20-05-2019', '20-05-2020'),
	(10, '01-01-2010', '01-01-2040'),
	(9, '01-01-2015', '01-01-2050');


INSERT INTO curriculo(codigo, nome) VALUES
	(45, 'Bacharelado em Ciência da Computação'),
	(46, 'Bacharelado em Ciência da Computação 2'),
	(50, 'Matemática Pura'),
	(60, 'Matemática Aplicada'),
	(70, 'Estatística'),
	(80, 'Licenciatura em Matemática');


INSERT INTO servico(tipo, descricao) VALUES
	('visualizacao', 'Permite que um usuário visualize matérias e trilhas no sistema'),
	('remocao', 'Permite que um usuário remova matérias associadas ao seu perfil'),
	('alteracao', 'Permite que um usuário faça alterações em matérias escolhidas');


INSERT INTO trilha(nome, descricao, quant_disc) VALUES
	('teoria', 'Teoria da computação, matemática discreta, algoritmos, etc.', 12),
	('sistemas', 'Sistemas de software, banco de dados, programação paralela, etc.', 16),
	('ia', 'Inteligência artificial, machine learning, etc.', 6);


INSERT INTO modulo(id_trilha, nome, descricao, quant_disc) VALUES
	(1, 'matematica discreta', 'Matérias de matemática discreta', 6),
	(1, 'algoritmos', 'Matérias de algoritmos e estruturas de dados', 5),
	(2, 'banco de dados', 'Matérias relacionadas a banco de dados', 3),
	(3, 'machine learning', 'Matérias de machine learning', 3);


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


INSERT INTO oferecimento(id_professor, 	id_aluno, codigo, ano, duracao, instituto, periodo) VALUES
    (7, 1, 'MAC0121', 2016, 6, 'IME', 2),
    (8, 1, 'MAC0122', 2016, 6, 'IME', 2),
    (9, 1, 'MAC0123', 2017, 6, 'IME', 2),
    (10, 1, 'MAC0124', 2018, 4, 'IME', 1),
    (11, 1, 'MAC0125', 2019, 4, 'IME', 1);


INSERT INTO rel_us_pf(id_usuario, login) VALUES
    (1, 'bortolli'),
    (2, 'teotonio'),
    (3, 'daher');

INSERT INTO rel_pf_se(login, id_servico) VALUES
	('bortolli', 1),
	('bortolli', 2),
	('bortolli', 3),
	('teotonio', 1),
	('teotonio', 2),
	('teotonio', 3),
	('daher', 1),
	('daher', 2),
	('daher', 3);