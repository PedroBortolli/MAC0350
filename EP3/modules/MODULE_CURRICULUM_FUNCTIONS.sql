DROP FUNCTION IF EXISTS cria_curriculo(INTEGER, VARCHAR(50));
DROP FUNCTION IF EXISTS cria_trilha(VARCHAR(50), VARCHAR(255), INTEGER);
DROP FUNCTION IF EXISTS cria_modulo(INTEGER, VARCHAR(50), VARCHAR(255), INTEGER);
DROP FUNCTION IF EXISTS cria_disciplina(VARCHAR(7), VARCHAR(100), INTEGER, INTEGER, VARCHAR(50));

CREATE OR REPLACE FUNCTION cria_curriculo(INTEGER, VARCHAR(50)) RETURNS VOID
LANGUAGE plpgsql
AS $$
	BEGIN
		INSERT INTO curriculo(codigo, nome) VALUES ($1, $2);
	END
$$;

CREATE OR REPLACE FUNCTION cria_trilha(VARCHAR(50), VARCHAR(255), INTEGER) RETURNS VOID
LANGUAGE plpgsql
AS $$
	BEGIN
		INSERT INTO trilha(nome, descricao, quant_mod) VALUES ($1, $2, $3);
	END
$$;

CREATE OR REPLACE FUNCTION cria_modulo(INTEGER, VARCHAR(50), VARCHAR(255), INTEGER) RETURNS VOID 
LANGUAGE plpgsql
AS $$
	BEGIN
		INSERT INTO modulo(id_trilha, nome, descricao, quant_disc) VALUES ($1, $2, $3);
	END
$$;

CREATE OR REPLACE FUNCTION cria_disciplina(VARCHAR(7), VARCHAR(100), INTEGER, INTEGER, VARCHAR(50)) RETURNS VOID
LANGUAGE plpgsql
AS $$
	BEGIN
		INSERT INTO disciplina(codigo, nome, creditos_aula, creditos_trabalho, instituto) VALUES ($1, $2, $3, $4, $5);
	END
$$;