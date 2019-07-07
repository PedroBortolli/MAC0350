CREATE EXTENSION postgres_fdw;

CREATE SERVER cur_server
FOREIGN DATA WRAPPER postgres_fdw
OPTIONS (host 'localhost', port '5432', dbname 'mod_cur');

CREATE SERVER peo_server
FOREIGN DATA WRAPPER postgres_fdw
OPTIONS (host 'localhost', port '5432', dbname 'mod_peo');

CREATE USER MAPPING FOR postgres
SERVER cur_server
OPTIONS (user 'postgres', password 'postgres');

CREATE USER MAPPING FOR postgres
SERVER peo_server
OPTIONS (user 'postgres', password 'postgres');

CREATE FOREIGN TABLE disciplina_foreign (
	codigo varchar(7),
	nome varchar(100),
	creditos_aula integer,
	creditos_trabalho integer,
	instituto varchar(50)
)
SERVER cur_server
OPTIONS (table_name 'disciplina');

CREATE FOREIGN TABLE curriculo_foreign (
	codigo INTEGER,
	nome VARCHAR(50)
)
SERVER cur_server
OPTIONS (table_name 'curriculo');

CREATE FOREIGN TABLE aluno_foreign (
	nusp integer,
	cpf VARCHAR(11),
	ano_ingresso integer
)
SERVER peo_server
OPTIONS (table_name 'aluno');

CREATE FOREIGN TABLE professor_foreign (
	cpf VARCHAR(11),
	area_formacao varchar(50)
)
SERVER peo_server
OPTIONS (table_name 'professor');

CREATE TABLE oferecimento (
	cpf_professor VARCHAR(11),
	codigo varchar(7),
	ano integer,
	duracao integer,
	instituto varchar(50),
	periodo integer,
	PRIMARY KEY (cpf_professor, codigo),
	CONSTRAINT check_ano check (ano > 0),
	CONSTRAINT check_duracao_periodo check (periodo>0 AND ((duracao=6 AND periodo<=2) OR (duracao=3 AND periodo<=4)))
);

CREATE TABLE cursa (
	cpf_professor VARCHAR(11),
	codigo varchar(7),
	nusp_aluno integer,
	status varchar(2) NOT NULL,
	media_final integer,
	PRIMARY KEY (nusp_aluno, cpf_professor, codigo),
	CONSTRAINT fk_oferecimento FOREIGN KEY (cpf_professor, codigo) REFERENCES oferecimento(cpf_professor, codigo) ON DELETE CASCADE ON UPDATE CASCADE,
	CONSTRAINT check_media check (media_final >= 0 AND media_final <= 100),
	CONSTRAINT check_status check (status='A' OR status='RN' OR status='MA' OR status='T'),
	CONSTRAINT check_aprov check (not status='A' or media_final >= 50),
	CONSTRAINT check_repr check (not status='RN' or media_final < 50)
);

CREATE TABLE planeja (
	nusp_aluno integer,
	codigo varchar(7),
	semestre integer,
	PRIMARY KEY (nusp_aluno, codigo)
);

CREATE TABLE cursa_curriculo (
    codigo INTEGER NOT NULL,
    nusp INTEGER,
    PRIMARY KEY (nusp)
);