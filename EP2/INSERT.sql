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
	(4, 2016),
	(5, 2016);


INSERT INTO professor(id_professor, formacao_area) VALUES
	(6, 'Banco de dados'),
	(7, 'Teoria'),
	(8, 'Machine Learning'),
	(9, 'IA'),
	(10, 'Sistemas');


INSERT INTO usuario(id_usuario, login, email, senha) VALUES
	(1, 'bortolli', 'bortolli@ime.usp.br', crypt('bortollipassword', gen_salt('bf')));


INSERT INTO administrador(id_adm, inicio, fim) VALUES
	(11, '20-05-2019', '20-05-2020');


INSERT INTO curriculo(codigo, nome) VALUES
	(45, 'Bacharelado em Ciência da Computação');  -- usando utf8... pode? aqui deu bom


-- INSERT INTO perfil(papel, descricao) VALUES  -- nao sei o que inserir aqui


INSERT INTO servico(tipo, descricao) VALUES
	('visualizacao', 'Permite que um usuário visualize matérias e trilhas no sistema'),
	('remocao', 'Permite que um usuário remova matérias associadas ao seu perfil'),
	('alteracao', 'Permite que um usuário faça alterações em matérias escolhidas');


INSERT INTO trilha(nome, descricao, quant_disc) VALUES
	('teoria', 'Teoria da computação, matemática discreta, algoritmos, etc.', 12), -- checar numero de disciplinas
	('sistemas', 'Sistemas de software, banco de dados, programação paralela, etc.', 16), -- checar numero de disciplinas
	('ia', 'Inteligência artificial, machine learning, etc.', 6); -- checar numero de disciplinas


INSERT INTO modulo(id_trilha, nome, descricao, quant_disc) VALUES
	(1, 'matematica discreta', 'Matérias de matemática discreta', 6), -- checar numero de disciplinas
	(1, 'algoritmos', 'Matérias de algoritmos e estruturas de dados', 5), -- checar numero de disciplinas
	(2, 'banco de dados', 'Matérias relacionadas a banco de dados', 3), -- chegar numero de disciplinas
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


-- TODO: Insert rows on table 'oferecimento' once its Create query is properly working

INSERT INTO oferecimento(id_professor, 	id_aluno, codigo, ano, duracao, instituto, periodo) VALUES
    (7, 1, 'MAC0121', 2016, 6, 'IME', 2);

-- TODO: Insert rows on table 'rel_us_pf' once its Create query is properly working

INSERT INTO rel_us_pf(id_usuario, login) VALUES
    (1, 'bortolli');

INSERT INTO rel_pf_se(login, id_servico) VALUES
	('bortolli', 1),
	('bortolli', 2),
	('bortolli', 3);