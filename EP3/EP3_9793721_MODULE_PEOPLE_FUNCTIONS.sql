DROP FUNCTION IF EXISTS cria_pessoa(VARCHAR(11), VARCHAR(100));
DROP FUNCTION IF EXISTS cria_aluno(INTEGER, VARCHAR(11), INTEGER);
DROP FUNCTION IF EXISTS cria_professor(VARCHAR(11), VARCHAR(50));
DROP FUNCTION IF EXISTS cria_administrador(VARCHAR(11), DATE, DATE);

DROP FUNCTION IF EXISTS remove_pessoa(VARCHAR(11));
DROP FUNCTION IF EXISTS remove_aluno(INTEGER);
DROP FUNCTION IF EXISTS remove_professor(VARCHAR(11));
DROP FUNCTION IF EXISTS remove_administrador(VARCHAR(11));

DROP FUNCTION IF EXISTS atualiza_pessoa_nome(VARCHAR(11), VARCHAR(100));
DROP FUNCTION IF EXISTS atualiza_aluno_ano_ingresso(INTEGER, INTEGER);
DROP FUNCTION IF EXISTS atualiza_professor_area_formacao(VARCHAR(11), VARCHAR(50));
DROP FUNCTION IF EXISTS atualiza_administrador_inicio(VARCHAR(11), DATE);
DROP FUNCTION IF EXISTS atualiza_administrador_fim(VARCHAR(11), DATE);

DROP FUNCTION IF EXISTS seleciona_pessoa(VARCHAR(11));
DROP FUNCTION IF EXISTS seleciona_aluno(INTEGER);
DROP FUNCTION IF EXISTS seleciona_aluno_cpf(VARCHAR(11));
DROP FUNCTION IF EXISTS seleciona_professor(VARCHAR(11));
DROP FUNCTION IF EXISTS seleciona_administrador(VARCHAR(11));

-- CRIA

CREATE OR REPLACE FUNCTION cria_pessoa(VARCHAR(11), VARCHAR(100)) RETURNS VOID
LANGUAGE plpgsql
AS $$
BEGIN
	INSERT INTO pessoa (cpf, nome) VALUES ($1, $2);
END;
$$;

CREATE OR REPLACE FUNCTION cria_aluno(INTEGER, VARCHAR(11), INTEGER) RETURNS VOID
LANGUAGE plpgsql
AS $$
BEGIN
	INSERT INTO aluno (nusp, cpf, ano_ingresso) VALUES ($1, $2, $3);
END;
$$;

CREATE OR REPLACE FUNCTION cria_professor(VARCHAR(11), VARCHAR(50)) RETURNS VOID
LANGUAGE plpgsql
AS $$
BEGIN
	INSERT INTO professor (cpf, area_formacao) VALUES ($1, $2);
END;
$$;

CREATE OR REPLACE FUNCTION cria_administrador(VARCHAR(11), DATE, DATE) RETURNS VOID 
LANGUAGE plpgsql
AS $$
BEGIN
	INSERT INTO administrador(cpf, inicio, fim) VALUES ($1, $2, $3);
END;
$$;

-- REMOVE

CREATE OR REPLACE FUNCTION remove_pessoa(VARCHAR(11)) RETURNS VOID
LANGUAGE plpgsql
AS $$
BEGIN
	DELETE FROM pessoa WHERE cpf = $1;
END;
$$;

CREATE OR REPLACE FUNCTION remove_aluno(INTEGER) RETURNS VOID
LANGUAGE plpgsql
AS $$
BEGIN
	DELETE FROM aluno WHERE nusp = $1;
END;
$$;

CREATE OR REPLACE FUNCTION remove_professor(VARCHAR(11)) RETURNS VOID
LANGUAGE plpgsql
AS $$
BEGIN
	DELETE FROM professor WHERE cpf = $1;
END;
$$;

CREATE OR REPLACE FUNCTION remove_administrador(VARCHAR(11)) RETURNS VOID
LANGUAGE plpgsql
AS $$
BEGIN
	DELETE FROM administrador WHERE cpf = $1;
END;
$$;

-- ATUALIZA

CREATE OR REPLACE FUNCTION atualiza_pessoa_nome(VARCHAR(11), VARCHAR(100)) RETURNS VOID
LANGUAGE plpgsql
AS $$
BEGIN
	UPDATE pessoa
	SET nome = $2
	WHERE cpf = $1;
END;
$$;

CREATE OR REPLACE FUNCTION atualiza_aluno_ano_ingresso(INTEGER, INTEGER) RETURNS VOID
LANGUAGE plpgsql
AS $$
DECLARE _id INTEGER;
BEGIN
	UPDATE aluno
	SET ano_ingresso = $2
	WHERE nusp = $1;
END;
$$;

CREATE OR REPLACE FUNCTION atualiza_professor_area_formacao(VARCHAR(11), VARCHAR(50)) RETURNS VOID
LANGUAGE plpgsql
AS $$
BEGIN
	UPDATE professor
	SET area_formacao = $2
	WHERE cpf = $1;
END;
$$;

CREATE OR REPLACE FUNCTION atualiza_administrador_inicio(VARCHAR(11), DATE) RETURNS VOID
LANGUAGE plpgsql
AS $$
BEGIN
	UPDATE administrador
	SET inicio = $2
	WHERE cpf = $1;
END;
$$;

CREATE OR REPLACE FUNCTION atualiza_administrador_fim(VARCHAR(11), DATE) RETURNS VOID
LANGUAGE plpgsql
AS $$
BEGIN
	UPDATE administrador
	SET fim = $2
	WHERE cpf = $1;
END;
$$;

-- SELECIONA

CREATE OR REPLACE FUNCTION seleciona_pessoa(VARCHAR(11))
RETURNS TABLE(
	cpf VARCHAR(11),
	nome VARCHAR(100)
)
LANGUAGE plpgsql
AS $$
BEGIN
	RETURN QUERY SELECT * FROM pessoa WHERE pessoa.cpf = $1;
END;
$$;

CREATE OR REPLACE FUNCTION seleciona_aluno(INTEGER)
RETURNS TABLE(
	nusp INTEGER,
	cpf VARCHAR(11),
	ano_ingresso INTEGER
)
LANGUAGE plpgsql
AS $$
BEGIN
	RETURN QUERY SELECT * FROM aluno WHERE aluno.nusp = $1;
END;
$$;

CREATE OR REPLACE FUNCTION seleciona_aluno_cpf(VARCHAR(11))
RETURNS TABLE(
	nusp INTEGER,
	cpf VARCHAR(11),
	ano_ingresso INTEGER
)
LANGUAGE plpgsql
AS $$
BEGIN
	RETURN QUERY SELECT * FROM aluno WHERE aluno.cpf = $1;
END;
$$;

CREATE OR REPLACE FUNCTION seleciona_professor(VARCHAR(11))
RETURNS TABLE(
	cpf VARCHAR(11),
	area_formacao VARCHAR(50)
)
LANGUAGE plpgsql
AS $$
BEGIN
	RETURN QUERY SELECT * FROM professor WHERE professor.cpf = $1;
END;
$$;

CREATE OR REPLACE FUNCTION seleciona_administrador(VARCHAR(11))
RETURNS TABLE(
	cpf VARCHAR(11),
	inicio DATE,
	fim DATE
)
LANGUAGE plpgsql
AS $$
BEGIN
	RETURN QUERY SELECT * FROM administrador WHERE administrador.cpf = $1;
END;
$$;
