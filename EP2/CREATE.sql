-- COLOCANDO OS DROP TABLE AQUI POR SIMPLICIDADE, DEPOIS TEM QUE DEIXAR ELAS NUM ARQUIVO SEPARADO DE CLEAN

DROP TABLE IF EXISTS aluno;
DROP TABLE IF EXISTS professor;
DROP TABLE IF EXISTS usuario;
DROP TABLE IF EXISTS administrador;
DROP TABLE IF EXISTS pessoa;
DROP TABLE IF EXISTS curriculo;
DROP TABLE IF EXISTS perfil;
DROP TABLE IF EXISTS servico;
DROP TABLE IF EXISTS trilha;


-- CREATE MESMO A PARTIR DAQUI

CREATE TABLE pessoa (
	id_pessoa SERIAL,
	nome varchar(100),
	CONSTRAINT pk_pessoa PRIMARY KEY (id_pessoa)
);

CREATE TABLE aluno (
	id_aluno integer,
	ano_ingresso integer,
	CONSTRAINT fk_aluno FOREIGN KEY (id_aluno) REFERENCES pessoa(id_pessoa) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE professor (
	id_professor integer,
	formacao_area varchar(50),  -- not sure disso tbm, deixei aqui so por deixar, q q nois faz?
	--instituto varchar(50),
	CONSTRAINT fk_professor FOREIGN KEY (id_professor) REFERENCES pessoa(id_pessoa) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE usuario (
	id_usuario integer,
	login varchar(20) not NULL,
	email varchar(50) not NULL,
	senha varchar(64),
	CONSTRAINT fk_usuario FOREIGN KEY (id_usuario) REFERENCES pessoa(id_pessoa) ON DELETE CASCADE ON UPDATE CASCADE,
	CONSTRAINT pk_usuario PRIMARY KEY (login),
	CONSTRAINT check_email check (email ~ '^.+\@.+\..+$'),
	CONSTRAINT sec_key UNIQUE (email)
);

CREATE TABLE administrador (
	id_adm integer,
	inicio date,
	fim date,
	CONSTRAINT fk_adm FOREIGN KEY (id_adm) REFERENCES pessoa(id_pessoa) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE curriculo (
	codigo integer not NULL,
	nome varchar(50),
	CONSTRAINT prim_key PRIMARY KEY (codigo)
);

CREATE TABLE perfil (
	id_perfil SERIAL,
	papel varchar(50) not NULL,
	descricao varchar(255),
	CONSTRAINT pk_perfil PRIMARY KEY (id_perfil),
	CONSTRAINT sk_perfil UNIQUE (papel)
);

CREATE TABLE servico (
	id_servico SERIAL,
	tipo varchar(50) not NULL,
	descricao varchar(255),
	CONSTRAINT pk_servico PRIMARY KEY (id_servico),
	CONSTRAINT sk_servico UNIQUE (tipo),
	CONSTRAINT check_tipo check (tipo='visualizacao' OR tipo='remocao' OR tipo='alteracao')
);

CREATE TABLE trilha (
	id_trilha SERIAL,
	nome varchar(50) not NULL,
	descricao varchar(255),
	quant_disc integer,
	CONSTRAINT pk_trilha PRIMARY KEY (id_trilha),
	CONSTRAINT sk_trilha UNIQUE (nome),
	CONSTRAINT check_quant_disc check (quant_disc > 0)
);

/* REVIEW FROM DOWN HERE ==========>

CREATE TABLE modulo (
	id integer not NULL,
	nome varchar(50) not NULL,
	descricao varchar(255),
	quant_disc integer,
	id_trilha integer,
	CONSTRAINT prim_key PRIMARY KEY (id),
	CONSTRAINT sec_key UNIQUE (nome),
	CONSTRAINT check_quant_disc check (quant_disc >= 0),
	CONSTRAINT fk_trilha FOREIGN KEY (id_trilha)
		references trilha(id_trilha)
		ON DELETE CASCADE
		ON UPDATE CASCADE
);

CREATE TABLE disciplina (
	codigo varchar(7) not NULL,
	nome varchar(100),
	creditos_aula integer,
	creditos_trabalho integer,
	instituto varchar(50),
	CONSTRAINT check_codigo check (char_length(codigo)=7 AND codigo ~ '^[A-Z]{3}[0-9]{4}$'),
	CONSTRAINT prim_key PRIMARY KEY (codigo),
	CONSTRAINT check_creditos check (creditos_aula >= 0 AND creditos_trabalho >= 0)
);

CREATE TABLE oferecimento (
	CPF_prof varchar(11),
	CPF_aluno varchar(11),
	codigo varchar(7),
	ano integer,
	duracao integer,
	periodo integer,
	CONSTRAINT fk_prof FOREIGN KEY (CPF_prof)
		references professor(CPF_prof)
		ON DELETE CASCADE
		ON UPDATE CASCADE
	CONSTRAINT fk_aluno FOREIGN KEY (CPF_aluno)
		references aluno(CPF_aluno)
		ON DELETE CASCADE
		ON UPDATE CASCADE
	CONSTRAINT fk_disciplina FOREIGN KEY (codigo)
		references disciplina(codigo)
		ON DELETE CASCADE
		ON UPDATE CASCADE
	CONSTRAINT check_ano check (ano > 0),
	CONSTRAINT check_duracao_periodo check (periodo>0 AND (duracao=6 AND periodo<=2 OR duracao=3 AND periodo<=4))
);

CREATE TABLE rel_us_pf (
	id integer,
	login varchar(20),
	CONSTRAINT fk_usuario FOREIGN KEY (id)
		REFERENCES usuario(id)
		ON DELETE CASCADE
		ON UPDATE CASCADE,
	CONSTRAINT fk_usuario FOREIGN KEY (login)
		REFERENCES perfil(login)
		ON DELETE CASCADE
		ON UPDATE CASCADE
);

CREATE TABLE rel_pf_se (
	login varchar(20),
	id integer,
	CONSTRAINT fk_usuario FOREIGN KEY (login)
		REFERENCES usuario(login)
		ON DELETE CASCADE
		ON UPDATE CASCADE,
	CONSTRAINT fk_servico FOREIGN KEY (id)
		REFERENCES servico(id)
		ON DELETE CASCADE
		ON UPDATE CASCADE
);

CREATE TABLE planeja (
	CPF varchar(11),
	codigo varchar(7),
	semestre integer,
	CONSTRAINT fk_aluno FOREIGN KEY (CPF)
		REFERENCES aluno(CPF)
		ON DELETE CASCADE
		ON UPDATE CASCADE,
	CONSTRAINT fk_disciplina FOREIGN KEY (codigo)
		REFERENCES disciplina(codigo)
		ON DELETE CASCADE
		ON UPDATE CASCADE
);

CREATE TABLE rel_cur_tri (
	codigo integer,
	id integer,
	CONSTRAINT fk_curriculo FOREIGN KEY (codigo)
		REFERENCES curriculo(codigo)
		ON DELETE CASCADE
		ON UPDATE CASCADE,
	CONSTRAINT fk_trilha FOREIGN KEY (id)
		REFERENCES trilha(id)
		ON DELETE CASCADE
		ON UPDATE CASCADE
);

CREATE TABLE rel_mod_dis (
	id integer,
	codigo varchar(7),
	obrigatoria integer,
	CONSTRAINT fk_modulo FOREIGN KEY (id)
		REFERENCES modulo(id)
		ON DELETE CASCADE
		ON UPDATE CASCADE,
	CONSTRAINT fk_disciplina FOREIGN KEY (codigo)
		REFERENCES disciplina(codigo)
		ON DELETE CASCADE
		ON UPDATE CASCADE,
	CONSTRAINT check_obrigatoria check (obrigatoria=0 OR obrigatoria=1)
);
*/
