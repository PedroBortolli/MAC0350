DROP FUNCTION IF EXISTS seleciona_pessoa(varchar(100));
DROP FUNCTION IF EXISTS seleciona_aluno(varchar(100));



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


-- TODO: "atualiza_pessoa", "deleta_pessoa"


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


-- TODO: "atualiza_aluno", "deleta_aluno"



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