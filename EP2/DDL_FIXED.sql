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

CREATE TABLE usuario (
	id_usuario integer,
	login varchar(20) PRIMARY KEY,
	email varchar(50) not NULL,
	senha varchar(64),
	CONSTRAINT fk_usuario FOREIGN KEY (id_usuario) REFERENCES pessoa(id_pessoa) ON DELETE CASCADE ON UPDATE CASCADE,
	CONSTRAINT check_email check (email ~ '^.+\@.+\..+$'),
	CONSTRAINT sec_key UNIQUE (email),
	CONSTRAINT cand_key UNIQUE (id_usuario)
);

CREATE TABLE administrador (
	id_adm integer PRIMARY KEY,
	inicio date,
	fim date,
	CONSTRAINT fk_adm FOREIGN KEY (id_adm) REFERENCES pessoa(id_pessoa) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE curriculo (
	codigo integer PRIMARY KEY,
	nome varchar(50),
	id_adm integer,
	CONSTRAINT fk_curriculo FOREIGN KEY (id_adm) REFERENCES administrador(id_adm) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE perfil (
	id_perfil SERIAL PRIMARY KEY,
	papel varchar(50) not NULL UNIQUE,
	descricao varchar(255)
);

CREATE TABLE servico (
	id_servico SERIAL PRIMARY KEY,
	tipo varchar(50) not NULL UNIQUE,
	descricao varchar(255),
	CONSTRAINT check_tipo check (tipo='visualizacao' OR tipo='remocao' OR tipo='alteracao')
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

CREATE TABLE oferecimento (
	id_professor integer,
	codigo varchar(7),
	ano integer,
	duracao integer,
	instituto varchar(50),
	periodo integer,
	PRIMARY KEY (id_professor, codigo),
	CONSTRAINT fk_professor FOREIGN KEY (id_professor) references professor(id_professor) ON DELETE CASCADE ON UPDATE CASCADE,
	CONSTRAINT fk_disciplina FOREIGN KEY (codigo) references disciplina(codigo) ON DELETE CASCADE ON UPDATE CASCADE,
	CONSTRAINT check_ano check (ano > 0),
	CONSTRAINT check_duracao_periodo check (periodo>0 AND ((duracao=6 AND periodo<=2) OR (duracao=3 AND periodo<=4)))
);

CREATE TABLE cursa (
	id_professor integer,
	codigo varchar(7),
	id_aluno integer,
	status varchar(2) NOT NULL,
	media_final integer,
	PRIMARY KEY (id_aluno, id_professor, codigo),
	CONSTRAINT fk_oferecimento FOREIGN KEY (id_professor, codigo) REFERENCES oferecimento(id_professor, codigo) ON DELETE CASCADE ON UPDATE CASCADE,
	CONSTRAINT fk_aluno FOREIGN KEY (id_aluno) REFERENCES aluno(id_aluno) ON DELETE CASCADE ON UPDATE CASCADE,
	CONSTRAINT check_media check (media_final >= 0 AND media_final <= 100),
	CONSTRAINT check_status check (status='A' OR status='RN' OR status='MA' OR status='T')
);

CREATE TABLE rel_us_pf (
	login varchar(20),
	id_perfil integer,
	PRIMARY KEY (login, id_perfil),
	CONSTRAINT fk_usuario FOREIGN KEY (login) REFERENCES usuario(login) ON DELETE CASCADE ON UPDATE CASCADE,
	CONSTRAINT fk_perfil FOREIGN KEY (id_perfil) REFERENCES perfil(id_perfil) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE rel_pf_se (
	id_perfil integer,
	id_servico integer,
	PRIMARY KEY (id_perfil, id_servico),
	CONSTRAINT fk_perfil FOREIGN KEY (id_perfil) REFERENCES perfil(id_perfil) ON DELETE CASCADE ON UPDATE CASCADE,
	CONSTRAINT fk_servico FOREIGN KEY (id_servico) REFERENCES servico(id_servico) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE planeja (
	id_aluno integer,
	codigo varchar(7),
	semestre integer,
	PRIMARY KEY (id_aluno, codigo),
	CONSTRAINT fk_aluno FOREIGN KEY (id_aluno) REFERENCES aluno(id_aluno) ON DELETE CASCADE ON UPDATE CASCADE,
	CONSTRAINT fk_disciplina FOREIGN KEY (codigo) REFERENCES disciplina(codigo) ON DELETE CASCADE ON UPDATE CASCADE
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
