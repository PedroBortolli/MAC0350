-- COLOCANDO OS DROP TABLE AQUI POR SIMPLICIDADE, DEPOIS TEM QUE DEIXAR ELAS NUM ARQUIVO SEPARADO DE CLEAN

DROP TABLE IF EXISTS rel_mod_dis;
DROP TABLE IF EXISTS rel_cur_tri;
DROP TABLE IF EXISTS planeja;
DROP TABLE IF EXISTS rel_us_pf;
DROP TABLE IF EXISTS rel_pf_se;
DROP TABLE IF EXISTS oferecimento;
DROP TABLE IF EXISTS aluno;
DROP TABLE IF EXISTS professor;
DROP TABLE IF EXISTS usuario;
DROP TABLE IF EXISTS administrador;
DROP TABLE IF EXISTS pessoa;
DROP TABLE IF EXISTS curriculo;
DROP TABLE IF EXISTS perfil;
DROP TABLE IF EXISTS servico;
DROP TABLE IF EXISTS modulo;
DROP TABLE IF EXISTS trilha;
DROP TABLE IF EXISTS disciplina;


-- CREATE MESMO A PARTIR DAQUI

CREATE TABLE pessoa (
	id_pessoa SERIAL,
	nome varchar(100),
	CONSTRAINT pk_pessoa PRIMARY KEY (id_pessoa)
);


CREATE TABLE aluno (
	id_aluno integer,
	ano_ingresso integer,
	CONSTRAINT fk_aluno FOREIGN KEY (id_aluno) REFERENCES pessoa(id_pessoa) ON DELETE CASCADE ON UPDATE CASCADE,
	CONSTRAINT pk_aluno PRIMARY KEY (id_aluno) -- nao sei se ta certo, talvez tenha so que colocar como unique
);


CREATE TABLE professor (
	id_professor integer,
	formacao_area varchar(50),  -- not sure disso tbm, deixei aqui so por deixar, q q nois faz? acho que melhor tirar
	--instituto varchar(50), acho melhor tirar tambem
	CONSTRAINT fk_professor FOREIGN KEY (id_professor) REFERENCES pessoa(id_pessoa) ON DELETE CASCADE ON UPDATE CASCADE,
	CONSTRAINT pk_professor PRIMARY KEY (id_professor) --ditto
);


CREATE TABLE usuario (
	id_usuario integer,
	login varchar(20) not NULL,
	email varchar(50) not NULL,
	senha varchar(64),
	CONSTRAINT fk_usuario FOREIGN KEY (id_usuario) REFERENCES pessoa(id_pessoa) ON DELETE CASCADE ON UPDATE CASCADE,
	CONSTRAINT pk_usuario PRIMARY KEY (login), --ditto
	CONSTRAINT check_email check (email ~ '^.+\@.+\..+$'),
	CONSTRAINT sec_key UNIQUE (email),
	CONSTRAINT cand_key UNIQUE (id_usuario)
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
	descricao varchar(255), --talvez tirar? nao parece necessario
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


CREATE TABLE modulo (
	id_modulo SERIAL,
	id_trilha integer,
	nome varchar(50) not NULL,
	descricao varchar(255),
	quant_disc integer,
	CONSTRAINT pk_modulo PRIMARY KEY (id_modulo),
	CONSTRAINT sk_modulo UNIQUE (nome),
	CONSTRAINT check_quant_disc check (quant_disc > 0),
	CONSTRAINT fk_trilha FOREIGN KEY (id_trilha) references trilha(id_trilha) ON DELETE CASCADE ON UPDATE CASCADE
);


CREATE TABLE disciplina (
	codigo varchar(7) not NULL,
	nome varchar(100),
	creditos_aula integer,
	creditos_trabalho integer,
	instituto varchar(50),
	CONSTRAINT pk_disciplina PRIMARY KEY (codigo),
	CONSTRAINT check_codigo check (char_length(codigo)=7 AND codigo ~ '^[A-Z]{3}[0-9]{4}$'),
	CONSTRAINT check_creditos check (creditos_aula >= 0 AND creditos_trabalho >= 0)
);


CREATE TABLE oferecimento (
	id_professor integer,
	id_aluno integer,
	codigo varchar(7),
	ano integer,
	duracao integer,
	instituto varchar(50),
	periodo integer,
	CONSTRAINT fk_professor FOREIGN KEY (id_professor) references professor(id_professor) ON DELETE CASCADE ON UPDATE CASCADE,
	CONSTRAINT fk_aluno FOREIGN KEY (id_aluno) references aluno(id_aluno) ON DELETE CASCADE ON UPDATE CASCADE,
	CONSTRAINT fk_disciplina FOREIGN KEY (codigo) references disciplina(codigo) ON DELETE CASCADE ON UPDATE CASCADE,
	CONSTRAINT check_ano check (ano > 0),
	CONSTRAINT check_duracao_periodo check (periodo>0 AND ((duracao=6 AND periodo<=2) OR (duracao=3 AND periodo<=4)))
);


CREATE TABLE rel_us_pf (
	id_usuario integer,
	login varchar(20),
	CONSTRAINT fk_usuario FOREIGN KEY (id_usuario) REFERENCES usuario(id_usuario) ON DELETE CASCADE ON UPDATE CASCADE,
	CONSTRAINT fk_login FOREIGN KEY (login) REFERENCES usuario(login) ON DELETE CASCADE ON UPDATE CASCADE
);


CREATE TABLE rel_pf_se (
	login varchar(20),
	id_servico integer,
	CONSTRAINT fk_usuario FOREIGN KEY (login) REFERENCES usuario(login) ON DELETE CASCADE ON UPDATE CASCADE,
	CONSTRAINT fk_servico FOREIGN KEY (id_servico) REFERENCES servico(id_servico) ON DELETE CASCADE ON UPDATE CASCADE
);


CREATE TABLE planeja (
	id_aluno integer,
	codigo varchar(7),
	semestre integer,
	CONSTRAINT fk_aluno FOREIGN KEY (id_aluno) REFERENCES aluno(id_aluno) ON DELETE CASCADE ON UPDATE CASCADE,
	CONSTRAINT fk_disciplina FOREIGN KEY (codigo) REFERENCES disciplina(codigo) ON DELETE CASCADE ON UPDATE CASCADE
);


CREATE TABLE rel_cur_tri (
	codigo integer,
	id_trilha integer,
	CONSTRAINT fk_curriculo FOREIGN KEY (codigo) REFERENCES curriculo(codigo) ON DELETE CASCADE ON UPDATE CASCADE,
	CONSTRAINT fk_trilha FOREIGN KEY (id_trilha) REFERENCES trilha(id_trilha) ON DELETE CASCADE ON UPDATE CASCADE
);


CREATE TABLE rel_mod_dis (
	id_modulo integer,
	codigo varchar(7),
	obrigatoria integer,
	CONSTRAINT fk_modulo FOREIGN KEY (id_modulo) REFERENCES modulo(id_modulo) ON DELETE CASCADE ON UPDATE CASCADE,
	CONSTRAINT fk_disciplina FOREIGN KEY (codigo) REFERENCES disciplina(codigo) ON DELETE CASCADE ON UPDATE CASCADE,
	CONSTRAINT check_obrigatoria check (obrigatoria=0 OR obrigatoria=1)
);