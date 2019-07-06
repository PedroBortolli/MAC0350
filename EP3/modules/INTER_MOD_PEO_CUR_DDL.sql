DROP DATABASE IF EXISTS mod_acc_peo;
CREATE DATABASE mod_acc_peo;
\c mod_acc_peo;

CREATE EXTENSION postgres_fdw;

CREATE SERVER cur_server
FOREIGN DATA WRAPPER postgres_fdw
OPTIONS (host 'localhost', port '5432', dbname 'mod_cur');

CREATE SERVER peo_server
FOREIGN DATA WRAPPER postgres_fdw
OPTIONS (host 'localhost', port '5432', dbname 'mod_peo');

CREATE FOREIGN TABLE disciplina_foreign (
	codigo varchar(7),
	nome varchar(100),
	creditos_aula integer,
	creditos_trabalho integer,
	instituto varchar(50)
)
SERVER cur_server
OPTIONS (table_name 'disciplina');

CREATE FOREIGN TABLE aluno_foreign (
	id_aluno integer,
	ano_ingresso integer
)
SERVER peo_server
OPTIONS (table_name 'aluno');

CREATE FOREIGN TABLE professor_foreign (
	id_professor integer,
	formacao_area varchar(50)
)
SERVER peo_server
OPTIONS (table_name 'professor');

CREATE TABLE oferecimento (
	id_professor integer,
	codigo varchar(7),
	ano integer,
	duracao integer,
	instituto varchar(50),
	periodo integer,
	PRIMARY KEY (id_professor, codigo),
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
	CONSTRAINT check_media check (media_final >= 0 AND media_final <= 100),
	CONSTRAINT check_status check (status='A' OR status='RN' OR status='MA' OR status='T')
);

CREATE TABLE planeja (
	id_aluno integer,
	codigo varchar(7),
	semestre integer,
	PRIMARY KEY (id_aluno, codigo)
);