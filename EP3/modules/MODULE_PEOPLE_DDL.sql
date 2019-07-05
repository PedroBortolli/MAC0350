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
DECLARE _id integer;
BEGIN
	_id := (SELECT id_pessoa FROM pessoa WHERE nome = $1);
	INSERT INTO aluno (id_aluno, ano_ingresso) VALUES (_id, $2);
END;
$$;

CREATE OR REPLACE FUNCTION cria_professor(VARCHAR(100), VARCHAR(50)) RETURNS VOID
LANGUAGE plpgsql
AS $$
DECLARE _id integer;
BEGIN
	_id := (SELECT id_pessoa FROM pessoa WHERE nome = $1);
	INSERT INTO professor (id_professor, formacao_area) VALUES (_id, $2);
END;
$$;

CREATE OR REPLACE FUNCTION cria_administrador(_nome VARCHAR(100), _inicio DATE, _fim DATE) RETURNS VOID 
LANGUAGE plpgsql
AS $$
DECLARE _id integer;
BEGIN
	_id := (SELECT id_pessoa FROM pessoa WHERE nome = $1);
	INSERT INTO administrador(id_adm, inicio, fim) VALUES (_id, $2, $3);
END;
$$;

DROP FUNCTION IF EXISTS deleta_pessoa(varchar(100));
DROP FUNCTION IF EXISTS deleta_aluno(varchar(100));
DROP FUNCTION IF EXISTS deleta_professor(varchar(100));
DROP FUNCTION IF EXISTS deleta_administrador(varchar(100));

CREATE OR REPLACE FUNCTION deleta_pessoa(_nome varchar(100)) RETURNS VOID AS $$
	BEGIN
		DELETE FROM pessoa WHERE nome = _nome;
	END
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION deleta_aluno(_nome varchar(100)) RETURNS VOID AS $$
	DECLARE id integer;
	BEGIN
		id := (SELECT id_pessoa FROM pessoa WHERE nome = _nome);
		DELETE FROM aluno WHERE id_aluno = id;
	END
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION deleta_professor(_nome varchar(100)) RETURNS VOID AS $$
	DECLARE id integer;
	BEGIN
		id := (SELECT id_pessoa FROM pessoa WHERE nome = _nome);
		DELETE FROM professor WHERE id_professor = id;
	END
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION deleta_administrador(_nome varchar(100)) RETURNS VOID AS $$
	DECLARE _id integer;
	BEGIN
		_id := (SELECT id_pessoa FROM pessoa WHERE nome = _nome);
		DELETE FROM administrador WHERE id_adm = _id;
	END
$$ LANGUAGE plpgsql;

DROP FUNCTION IF EXISTS atualiza_pessoa(varchar(100), varchar(100));
DROP FUNCTION IF EXISTS atualiza_aluno(varchar(100), integer);
DROP FUNCTION IF EXISTS atualiza_professor(varchar(100), varchar(50));
DROP FUNCTION IF EXISTS atualiza_administrador(varchar(100), date, date);

CREATE OR REPLACE FUNCTION atualiza_pessoa(_nome varchar(100), _novo_nome varchar(100)) RETURNS VOID AS $$
	DECLARE _id integer;
	BEGIN
	    _id := (SELECT id_pessoa FROM pessoa WHERE nome = _nome);
		UPDATE pessoa
        SET nome=_novo_nome
        WHERE id_pessoa=_id;
	END
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION atualiza_aluno(_nome varchar(100), _ano_ingresso integer) RETURNS VOID AS $$
	DECLARE _id integer;
	BEGIN
		_id := (SELECT id_pessoa FROM pessoa WHERE nome = _nome);
		UPDATE aluno
        SET ano_ingresso=_ano_ingresso
        WHERE id_aluno=_id;
	END
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION atualiza_professor(_nome varchar(100), _formacao_area varchar(50)) RETURNS VOID AS $$
	DECLARE _id integer;
	BEGIN
		_id := (SELECT id_pessoa FROM pessoa WHERE nome = _nome);
		UPDATE professor
        SET formacao_area=_formacao_area
        WHERE id_professor=_id;
	END
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION atualiza_administrador(_nome varchar(100), _inicio date, _fim date) RETURNS VOID AS $$
	DECLARE _id integer;
	BEGIN
	    _id := (SELECT id_pessoa FROM pessoa WHERE nome = _nome);
		UPDATE administrador
        SET inicio=_inicio, fim=_fim
        WHERE id_adm=_id;
	END
$$ LANGUAGE plpgsql;

DROP FUNCTION IF EXISTS seleciona_pessoa(varchar(100));
DROP FUNCTION IF EXISTS seleciona_aluno(varchar(100));
DROP FUNCTION IF EXISTS seleciona_professor(varchar(100));
DROP FUNCTION IF EXISTS seleciona_administrador(varchar(100));

CREATE OR REPLACE FUNCTION seleciona_pessoa(_nome varchar(100)) RETURNS TABLE(id integer, nome_pessoa varchar(100)) AS $$
	BEGIN
		RETURN QUERY SELECT * FROM pessoa WHERE nome = _nome;
	END
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION seleciona_aluno(_nome varchar(100)) RETURNS TABLE(id integer, ano_ingresso integer) AS $$
	DECLARE id integer;
	BEGIN
		id := (SELECT id_pessoa FROM pessoa WHERE nome = _nome);
		RETURN QUERY SELECT * FROM aluno WHERE id_aluno = id;
	END
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION seleciona_professor(_nome varchar(100)) RETURNS TABLE(id integer, formacao_area varchar(50)) AS $$
	DECLARE id integer;
	BEGIN
		id := (SELECT id_pessoa FROM pessoa WHERE nome = _nome);
		RETURN QUERY SELECT * FROM professor WHERE id_professor = id;
	END
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION seleciona_administrador(_nome varchar(100)) RETURNS TABLE(id integer, inicio date, fim date) AS $$
	DECLARE _id integer;
	BEGIN
		_id := (SELECT id_pessoa FROM pessoa WHERE nome = _nome);
		RETURN QUERY SELECT * FROM administrador WHERE id_adm = _id;
	END
$$ LANGUAGE plpgsql;