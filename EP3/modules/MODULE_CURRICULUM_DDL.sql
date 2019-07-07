CREATE TABLE IF NOT EXISTS curriculo (
	codigo INTEGER PRIMARY KEY,
	nome VARCHAR(50)
);

CREATE TABLE IF NOT EXISTS trilha (
	id_trilha SERIAL PRIMARY KEY,
	nome VARCHAR(50) NOT NULL UNIQUE,
	descricao VARCHAR(255),
	quant_mod INTEGER CHECK (quant_mod > 0)
);

CREATE TABLE IF NOT EXISTS modulo (
	id_modulo SERIAL PRIMARY KEY,
	nome VARCHAR(50) NOT NULL UNIQUE,
	descricao VARCHAR(255),
	quant_disc INTEGER CHECK (quant_disc > 0),
	id_trilha INTEGER REFERENCES trilha(id_trilha) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS disciplina (
	codigo VARCHAR(7) PRIMARY KEY CHECK (char_length(codigo)=7 AND codigo ~ '^[A-Z]{3}[0-9]{4}$'),
	nome VARCHAR(100),
	creditos_aula INTEGER CHECK (creditos_aula >= 0),
	creditos_trabalho INTEGER CHECK (creditos_trabalho >= 0),
	instituto VARCHAR(50)
);

CREATE TABLE IF NOT EXISTS requisito (
	codigo_disc varchar(7),
	codigo_req varchar(7),
	codigo_cur integer,
	PRIMARY KEY (codigo_disc, codigo_req, codigo_cur),
	CONSTRAINT fk_codigo_disc FOREIGN KEY (codigo_disc) REFERENCES disciplina(codigo) ON DELETE CASCADE ON UPDATE CASCADE,
	CONSTRAINT fk_codigo_req FOREIGN KEY (codigo_req) REFERENCES disciplina(codigo) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS rel_cur_tri (
	codigo integer,
	id_trilha integer,
	PRIMARY KEY (codigo, id_trilha),
	CONSTRAINT fk_curriculo FOREIGN KEY (codigo) REFERENCES curriculo(codigo) ON DELETE CASCADE ON UPDATE CASCADE,
	CONSTRAINT fk_trilha FOREIGN KEY (id_trilha) REFERENCES trilha(id_trilha) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS rel_mod_dis (
	id_modulo integer,
	codigo varchar(7),
	obrigatoria BIT NOT NULL,
	PRIMARY KEY (id_modulo, codigo),
	CONSTRAINT fk_modulo FOREIGN KEY (id_modulo) REFERENCES modulo(id_modulo) ON DELETE CASCADE ON UPDATE CASCADE,
	CONSTRAINT fk_disciplina FOREIGN KEY (codigo) REFERENCES disciplina(codigo) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS rel_dis_cur (
    codigo_dis varchar(7),
    codigo_cur INTEGER,
    rel VARCHAR(11) CHECK ((rel = 'eletiva') OR (rel = 'obrigatoria')),
    PRIMARY KEY (codigo_dis, codigo_cur),
    CONSTRAINT fk_codigo_disc FOREIGN KEY (codigo_dis) REFERENCES disciplina(codigo) ON DELETE CASCADE ON UPDATE CASCADE,
	CONSTRAINT fk_codigo_cur FOREIGN KEY (codigo_cur) REFERENCES curriculo(codigo) ON DELETE CASCADE ON UPDATE CASCADE
);