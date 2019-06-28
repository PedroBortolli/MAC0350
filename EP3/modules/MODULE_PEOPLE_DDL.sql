DROP TABLE IF EXISTS aluno;
DROP TABLE IF EXISTS professor;
DROP TABLE IF EXISTS pessoa;

CREATE TABLE pessoa (
	id_pessoa SERIAL PRIMARY KEY,
	nome varchar(100)
);

CREATE TABLE aluno (
	id_aluno integer PRIMARY KEY,
	ano_ingresso integer,
	CONSTRAINT fk_aluno FOREIGN KEY (id_aluno) REFERENCES pessoa(id_pessoa) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE professor (
	id_professor integer PRIMARY KEY,
	formacao_area varchar(50),
	CONSTRAINT fk_professor FOREIGN KEY (id_professor) REFERENCES pessoa(id_pessoa) ON DELETE CASCADE ON UPDATE CASCADE
);