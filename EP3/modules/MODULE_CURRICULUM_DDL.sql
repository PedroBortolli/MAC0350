DROP DATABASE IF EXISTS mod_cur;
CREATE DATABASE mod_cur;
\c mod_cur;


CREATE TABLE curriculo (
	codigo integer PRIMARY KEY,
	nome varchar(50),
	id_adm integer,
	CONSTRAINT fk_curriculo FOREIGN KEY (id_adm) REFERENCES administrador(id_adm) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE trilha (
	id_trilha SERIAL PRIMARY KEY,
	nome varchar(50) not NULL UNIQUE,
	descricao varchar(255),
	quant_mod integer,
	CONSTRAINT check_quant_mod check (quant_mod > 0)
);

CREATE TABLE modulo (
	id_modulo SERIAL PRIMARY KEY,
	id_trilha integer,
	nome varchar(50) not NULL UNIQUE,
	descricao varchar(255),
	quant_disc integer,
	CONSTRAINT check_quant_disc check (quant_disc > 0),
	CONSTRAINT fk_trilha FOREIGN KEY (id_trilha) references trilha(id_trilha) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE disciplina (
	codigo varchar(7) PRIMARY KEY,
	nome varchar(100),
	creditos_aula integer,
	creditos_trabalho integer,
	instituto varchar(50),
	CONSTRAINT check_codigo check (char_length(codigo)=7 AND codigo ~ '^[A-Z]{3}[0-9]{4}$'),
	CONSTRAINT check_creditos check (creditos_aula >= 0 AND creditos_trabalho >= 0)
);

CREATE TABLE requisito (
	codigo_disc varchar(7),
	codigo_req varchar(7),
	PRIMARY KEY (codigo_disc, codigo_req),
	CONSTRAINT fk_codigo_disc FOREIGN KEY (codigo_disc) REFERENCES disciplina(codigo) ON DELETE CASCADE ON UPDATE CASCADE,
	CONSTRAINT fk_codigo_req FOREIGN KEY (codigo_req) REFERENCES disciplina(codigo) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE rel_cur_tri (
	codigo integer,
	id_trilha integer,
	PRIMARY KEY (codigo, id_trilha),
	CONSTRAINT fk_curriculo FOREIGN KEY (codigo) REFERENCES curriculo(codigo) ON DELETE CASCADE ON UPDATE CASCADE,
	CONSTRAINT fk_trilha FOREIGN KEY (id_trilha) REFERENCES trilha(id_trilha) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE rel_mod_dis (
	id_modulo integer,
	codigo varchar(7),
	obrigatoria BIT NOT NULL,
	PRIMARY KEY (id_modulo, codigo),
	CONSTRAINT fk_modulo FOREIGN KEY (id_modulo) REFERENCES modulo(id_modulo) ON DELETE CASCADE ON UPDATE CASCADE,
	CONSTRAINT fk_disciplina FOREIGN KEY (codigo) REFERENCES disciplina(codigo) ON DELETE CASCADE ON UPDATE CASCADE
);