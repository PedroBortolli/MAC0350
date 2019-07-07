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

CREATE TABLE administrador (
	id_adm integer PRIMARY KEY,
	inicio date,
	fim date,
	CONSTRAINT fk_adm FOREIGN KEY (id_adm) REFERENCES pessoa(id_pessoa) ON DELETE CASCADE ON UPDATE CASCADE
);