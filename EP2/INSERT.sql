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