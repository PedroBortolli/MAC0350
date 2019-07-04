DROP TABLE IF EXISTS planeja;
DROP TABLE IF EXISTS cursa;
DROP TABLE IF EXISTS oferecimento;

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

CREATE TABLE planeja (
	id_aluno integer,
	codigo varchar(7),
	semestre integer,
	PRIMARY KEY (id_aluno, codigo),
	CONSTRAINT fk_aluno FOREIGN KEY (id_aluno) REFERENCES aluno(id_aluno) ON DELETE CASCADE ON UPDATE CASCADE,
	CONSTRAINT fk_disciplina FOREIGN KEY (codigo) REFERENCES disciplina(codigo) ON DELETE CASCADE ON UPDATE CASCADE
);