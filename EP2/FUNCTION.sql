DROP FUNCTION IF EXISTS seleciona_pessoa(varchar(100));
DROP FUNCTION IF EXISTS seleciona_aluno(varchar(100));
DROP FUNCTION IF EXISTS seleciona_professor(varchar(100));
DROP FUNCTION IF EXISTS seleciona_usuario(varchar(100));
DROP FUNCTION IF EXISTS cria_pessoa(varchar(100));
DROP FUNCTION IF EXISTS cria_aluno(varchar(100), integer);
DROP FUNCTION IF EXISTS cria_professor(varchar(100), varchar(50));
DROP FUNCTION IF EXISTS cria_usuario(varchar(100), varchar(20), varchar(50), varchar(64));
DROP FUNCTION IF EXISTS deleta_pessoa(varchar(100));
DROP FUNCTION IF EXISTS deleta_aluno(varchar(100));
DROP FUNCTION IF EXISTS deleta_professor(varchar(100));
DROP FUNCTION IF EXISTS deleta_usuario(varchar(100));
DROP FUNCTION IF EXISTS atualiza_pessoa(varchar(100), varchar(100));
DROP FUNCTION IF EXISTS atualiza_aluno(varchar(100), integer);
DROP FUNCTION IF EXISTS atualiza_professor(varchar(100), varchar(50));
DROP FUNCTION IF EXISTS atualiza_login_usuario( varchar(100), varchar(20));

-------------------------------------------------------------------------



CREATE OR REPLACE FUNCTION cria_pessoa(_nome varchar(100)) RETURNS VOID AS $$
	BEGIN
		INSERT INTO pessoa(nome) VALUES (_nome);
	END
$$ LANGUAGE plpgsql;


CREATE OR REPLACE FUNCTION seleciona_pessoa(_nome varchar(100)) RETURNS TABLE(id integer, nome_pessoa varchar(100)) AS $$
	BEGIN
		RETURN QUERY SELECT * FROM pessoa WHERE nome = _nome;
	END
$$ LANGUAGE plpgsql;


CREATE OR REPLACE FUNCTION deleta_pessoa(_nome varchar(100)) RETURNS VOID AS $$
	BEGIN
		DELETE FROM pessoa WHERE nome = _nome;
	END
$$ LANGUAGE plpgsql;


CREATE OR REPLACE FUNCTION atualiza_pessoa(_nome varchar(100), _novo_nome varchar(100)) RETURNS VOID AS $$
	DECLARE _id integer;
	BEGIN
	    _id := (SELECT id_pessoa FROM pessoa WHERE nome = _nome);
		UPDATE pessoa
        SET nome=_novo_nome
        WHERE id_pessoa=_id;
	END
$$ LANGUAGE plpgsql;


CREATE OR REPLACE FUNCTION cria_aluno(_nome varchar(100), _ano_ingresso integer) RETURNS VOID AS $$
	DECLARE _id integer;
	BEGIN
		_id := (SELECT id_pessoa FROM pessoa WHERE nome = _nome);
		INSERT INTO aluno(id_aluno, ano_ingresso) VALUES (_id, _ano_ingresso);
	END
$$ LANGUAGE plpgsql;


CREATE OR REPLACE FUNCTION seleciona_aluno(_nome varchar(100)) RETURNS TABLE(id integer, ano_ingresso integer) AS $$
	DECLARE id integer;
	BEGIN
		id := (SELECT id_pessoa FROM pessoa WHERE nome = _nome);
		RETURN QUERY SELECT * FROM aluno WHERE id_aluno = id;
	END
$$ LANGUAGE plpgsql;


CREATE OR REPLACE FUNCTION deleta_aluno(_nome varchar(100)) RETURNS VOID AS $$
	DECLARE id integer;
	BEGIN
		id := (SELECT id_pessoa FROM pessoa WHERE nome = _nome);
		DELETE FROM aluno WHERE id_aluno = id;
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


CREATE OR REPLACE FUNCTION cria_professor(_nome varchar(100), _formacao_area varchar(50)) RETURNS VOID AS $$
	DECLARE _id integer;
	BEGIN
		_id := (SELECT id_pessoa FROM pessoa WHERE nome = _nome);
		INSERT INTO professor(id_professor, formacao_area) VALUES (_id, _formacao_area);
	END
$$ LANGUAGE plpgsql;


CREATE OR REPLACE FUNCTION seleciona_professor(_nome varchar(100)) RETURNS TABLE(id integer, formacao_area varchar(50)) AS $$
	DECLARE id integer;
	BEGIN
		id := (SELECT id_pessoa FROM pessoa WHERE nome = _nome);
		RETURN QUERY SELECT * FROM professor WHERE id_professor = id;
	END
$$ LANGUAGE plpgsql;


CREATE OR REPLACE FUNCTION deleta_professor(_nome varchar(100)) RETURNS VOID AS $$
	DECLARE id integer;
	BEGIN
		id := (SELECT id_pessoa FROM pessoa WHERE nome = _nome);
		DELETE FROM professor WHERE id_professor = id;
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

CREATE OR REPLACE FUNCTION cria_usuario(_nome varchar(100), login varchar(20), email varchar(50), senha varchar(64)) RETURNS VOID AS $$
	DECLARE _id integer;
	BEGIN
		_id := (SELECT id_pessoa FROM pessoa WHERE nome = _nome);
		INSERT INTO usuario(id_usuario, login, email, senha) VALUES (_id, login, email, crypt(senha, gen_salt('bf')));
	END
$$ LANGUAGE plpgsql;


CREATE OR REPLACE FUNCTION seleciona_usuario(_nome varchar(100)) RETURNS TABLE(id integer, login varchar(20), email varchar(50), senha varchar(64)) AS $$
	DECLARE _id integer;
	BEGIN
		_id := (SELECT id_pessoa FROM pessoa WHERE nome = _nome);
		RETURN QUERY SELECT * FROM usuario WHERE id_usuario = _id;
	END
$$ LANGUAGE plpgsql;


CREATE OR REPLACE FUNCTION deleta_usuario(_nome varchar(100)) RETURNS VOID AS $$
	DECLARE id integer;
	BEGIN
		id := (SELECT id_pessoa FROM pessoa WHERE nome = _nome);
		DELETE FROM usuario WHERE id_usuario = id;
	END
$$ LANGUAGE plpgsql;


CREATE OR REPLACE FUNCTION atualiza_login_usuario(_nome varchar(100), _login varchar(20)) RETURNS VOID AS $$
	DECLARE _id integer;
	BEGIN
		_id := (SELECT id_pessoa FROM pessoa WHERE nome = _nome);
		UPDATE usuario
        SET login=_login
        WHERE id_usuario=_id;
	END
$$ LANGUAGE plpgsql;

-------------------------------------------------------------------------



-- example of how to call funcions:
-- (yes, it uses SELECT for some reason even for creations => https://www.postgresql.org/docs/9.1/sql-syntax-calling-funcs.html)

SELECT cria_pessoa('bortolli');
SELECT cria_pessoa('teotonio');
SELECT cria_pessoa('daher');
SELECT * FROM seleciona_pessoa('bortolli');
SELECT * FROM seleciona_pessoa('teotonio');
SELECT * FROM seleciona_pessoa('daher');
SELECT cria_aluno('bortolli', 2016);
SELECT cria_aluno('teotonio', 2016);
SELECT cria_aluno('daher', 2015);
SELECT * FROM seleciona_aluno('bortolli');
SELECT * FROM seleciona_aluno('teotonio');
SELECT * FROM seleciona_aluno('daher');

SELECT atualiza_pessoa('daher', 'lucas daher');
SELECT * FROM seleciona_pessoa('daher');
SELECT * FROM seleciona_pessoa('lucas daher');

SELECT atualiza_aluno('lucas daher', 2019);
SELECT * FROM seleciona_aluno('lucas daher');

SELECT deleta_aluno('lucas daher');
SELECT * FROM seleciona_aluno('lucas daher');

SELECT * FROM deleta_pessoa('lucas daher');
SELECT * FROM seleciona_pessoa('lucas daher');

SELECT cria_pessoa('cef');
SELECT cria_professor('cef', 'teoria');
SELECT atualiza_professor('cef', 'A e EDs');
SELECT * FROM seleciona_professor('cef');
SELECT deleta_professor('cef');
SELECT * FROM seleciona_professor('cef');

SELECT cria_usuario('teotonio', 'teo', 'teo@mailismagic.com', '123456');
SELECT atualiza_login_usuario('teotonio', 'pteos');
SELECT * FROM seleciona_usuario('teotonio');
SELECT deleta_usuario('teotonio');
SELECT * FROM seleciona_usuario('teotonio');
