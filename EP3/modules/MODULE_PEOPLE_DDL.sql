DROP TABLE IF EXISTS aluno;
DROP TABLE IF EXISTS professor;
DROP TABLE IF EXISTS administrador;
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

CREATE TABLE administrador (
	id_adm integer PRIMARY KEY,
	inicio date,
	fim date,
	CONSTRAINT fk_adm FOREIGN KEY (id_adm) REFERENCES pessoa(id_pessoa) ON DELETE CASCADE ON UPDATE CASCADE
);

DROP FUNCTION IF EXISTS cria_pessoa(VARCHAR(100));
DROP FUNCTION IF EXISTS cria_aluno(VARCHAR(100), INTEGER);
DROP FUNCTION IF EXISTS cria_professor(VARCHAR(100), VARCHAR(50));
DROP FUNCTION IF EXISTS cria_administrador(VARCHAR(100), DATE, DATE);

CREATE OR REPLACE FUNCTION cria_pessoa(VARCHAR(100)) RETURNS VOID
LANGUAGE plpgsql
AS $$
BEGIN
	INSERT INTO pessoa (nome) VALUES ($1);
END;
$$;

CREATE OR REPLACE FUNCTION cria_aluno(VARCHAR(100), INTEGER) RETURNS VOID
LANGUAGE plpgsql
AS $$
DECLARE _id INTEGER;
BEGIN
	_id := (SELECT id_pessoa FROM pessoa WHERE nome = $1);
	INSERT INTO aluno (id_aluno, ano_ingresso) VALUES (_id, $2);
END;
$$;

CREATE OR REPLACE FUNCTION cria_professor(VARCHAR(100), VARCHAR(50)) RETURNS VOID
LANGUAGE plpgsql
AS $$
DECLARE _id INTEGER;
BEGIN
	_id := (SELECT id_pessoa FROM pessoa WHERE nome = $1);
	INSERT INTO professor (id_professor, formacao_area) VALUES (_id, $2);
END;
$$;

CREATE OR REPLACE FUNCTION cria_administrador(VARCHAR(100), DATE, DATE) RETURNS VOID 
LANGUAGE plpgsql
AS $$
DECLARE _id integer;
BEGIN
	_id := (SELECT id_pessoa FROM pessoa WHERE nome = $1);
	INSERT INTO administrador(id_adm, inicio, fim) VALUES (_id, $2, $3);
END;
$$;

DROP FUNCTION IF EXISTS deleta_pessoa(VARCHAR(100));
DROP FUNCTION IF EXISTS deleta_aluno(VARCHAR(100));
DROP FUNCTION IF EXISTS deleta_professor(VARCHAR(100));
DROP FUNCTION IF EXISTS deleta_administrador(VARCHAR(100));

CREATE OR REPLACE FUNCTION deleta_pessoa(VARCHAR(100)) RETURNS VOID
LANGUAGE plpgsql
AS $$
BEGIN
	DELETE FROM pessoa WHERE nome = $1;
END;
$$;

CREATE OR REPLACE FUNCTION deleta_aluno(VARCHAR(100)) RETURNS VOID
LANGUAGE plpgsql
AS $$
DECLARE id INTEGER;
BEGIN
	id := (SELECT id_pessoa FROM pessoa WHERE nome = $1);
	DELETE FROM aluno WHERE id_aluno = id;
END;
$$;

CREATE OR REPLACE FUNCTION deleta_professor(VARCHAR(100)) RETURNS VOID
LANGUAGE plpgsql
AS $$
DECLARE id INTEGER;
BEGIN
	id := (SELECT id_pessoa FROM pessoa WHERE nome = $1);
	DELETE FROM professor WHERE id_professor = id;
END;
$$;

CREATE OR REPLACE FUNCTION deleta_administrador(VARCHAR(100)) RETURNS VOID
LANGUAGE plpgsql
AS $$
DECLARE _id INTEGER;
BEGIN
	_id := (SELECT id_pessoa FROM pessoa WHERE nome = $1);
	DELETE FROM administrador WHERE id_adm = _id;
END;
$$;

DROP FUNCTION IF EXISTS atualiza_pessoa(VARCHAR(100), VARCHAR(100));
DROP FUNCTION IF EXISTS atualiza_aluno(VARCHAR(100), INTEGER);
DROP FUNCTION IF EXISTS atualiza_professor(VARCHAR(100), VARCHAR(50));
DROP FUNCTION IF EXISTS atualiza_administrador(VARCHAR(100), DATE, DATE);

CREATE OR REPLACE FUNCTION atualiza_pessoa(VARCHAR(100), VARCHAR(100)) RETURNS VOID
LANGUAGE plpgsql
AS $$
DECLARE _id integer;
BEGIN
	_id := (SELECT id_pessoa FROM pessoa WHERE nome = $1);
	UPDATE pessoa
	SET nome=$2
	WHERE id_pessoa=_id;
END;
$$;

CREATE OR REPLACE FUNCTION atualiza_aluno(VARCHAR(100), INTEGER) RETURNS VOID
LANGUAGE plpgsql
AS $$
DECLARE _id INTEGER;
BEGIN
	_id := (SELECT id_pessoa FROM pessoa WHERE nome = $1);
	UPDATE aluno
	SET ano_ingresso=$2
	WHERE id_aluno=_id;
END;
$$;

CREATE OR REPLACE FUNCTION atualiza_professor(VARCHAR(100), VARCHAR(50)) RETURNS VOID
LANGUAGE plpgsql
AS $$
DECLARE _id INTEGER;
BEGIN
	_id := (SELECT id_pessoa FROM pessoa WHERE nome = $1);
	UPDATE professor
	SET formacao_area=$2
	WHERE id_professor=_id;
END;
$$;

CREATE OR REPLACE FUNCTION atualiza_administrador(VARCHAR(100), DATE, DATE) RETURNS VOID
LANGUAGE plpgsql
AS $$
DECLARE _id INTEGER;
BEGIN
    _id := (SELECT id_pessoa FROM pessoa WHERE nome = $1);
	UPDATE administrador
	SET inicio=$2, fim=$3
	WHERE id_adm=_id;
END;
$$;

DROP FUNCTION IF EXISTS seleciona_pessoa(VARCHAR(100));
DROP FUNCTION IF EXISTS seleciona_aluno(VARCHAR(100));
DROP FUNCTION IF EXISTS seleciona_professor(VARCHAR(100));
DROP FUNCTION IF EXISTS seleciona_administrador(VARCHAR(100));

CREATE OR REPLACE FUNCTION seleciona_pessoa(VARCHAR(100)) RETURNS TABLE(id INTEGER, nome_pessoa VARCHAR(100))
LANGUAGE plpgsql
AS $$
BEGIN
	RETURN QUERY SELECT * FROM pessoa WHERE nome = $1;
END;
$$;

CREATE OR REPLACE FUNCTION seleciona_aluno(VARCHAR(100)) RETURNS TABLE(id INTEGER, ano_ingresso INTEGER)
LANGUAGE plpgsql
AS $$
DECLARE id INTEGER;
BEGIN
	id := (SELECT id_pessoa FROM pessoa WHERE nome = $1);
	RETURN QUERY SELECT * FROM aluno WHERE id_aluno = id;
END;
$$;

CREATE OR REPLACE FUNCTION seleciona_professor(VARCHAR(100)) RETURNS TABLE(id INTEGER, formacao_area VARCHAR(50))
LANGUAGE plpgsql
AS $$
DECLARE id INTEGER;
BEGIN
	id := (SELECT id_pessoa FROM pessoa WHERE nome = $1);
	RETURN QUERY SELECT * FROM professor WHERE id_professor = id;
END;
$$;

CREATE OR REPLACE FUNCTION seleciona_administrador(VARCHAR(100)) RETURNS TABLE(id INTEGER, inicio DATE, fim DATE)
LANGUAGE plpgsql
AS $$
DECLARE _id INTEGER;
BEGIN
	_id := (SELECT id_pessoa FROM pessoa WHERE nome = $1);
	RETURN QUERY SELECT * FROM administrador WHERE id_adm = _id;
END;
$$;