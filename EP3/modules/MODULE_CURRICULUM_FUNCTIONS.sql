DROP FUNCTION IF EXISTS cria_curriculo(INTEGER, VARCHAR(50));
DROP FUNCTION IF EXISTS seleciona_curriculo(INTEGER);
DROP FUNCTION IF EXISTS atualiza_curriculo(INTEGER, VARCHAR(50), INTEGER);
DROP FUNCTION IF EXISTS remove_curriculo(INTEGER);

DROP FUNCTION IF EXISTS cria_trilha(VARCHAR(50), VARCHAR(255), INTEGER);
DROP FUNCTION IF EXISTS seleciona_trilha(VARCHAR(50));
DROP FUNCTION IF EXISTS atualiza_descricao_trilha(VARCHAR(50), VARCHAR(255));
DROP FUNCTION IF EXISTS atualiza_disc_trilha(VARCHAR(50), INTEGER);
DROP FUNCTION IF EXISTS remove_trilha(VARCHAR(50));

DROP FUNCTION IF EXISTS cria_modulo(INTEGER, VARCHAR(50), VARCHAR(255), INTEGER);
DROP FUNCTION IF EXISTS seleciona_modulo(VARCHAR(50));
DROP FUNCTION IF EXISTS atualiza_descricao_modulo(VARCHAR(50), VARCHAR(255));
DROP FUNCTION IF EXISTS atualiza_disc_modulo(VARCHAR(50), INTEGER);
DROP FUNCTION IF EXISTS remove_modulo(VARCHAR(50));

DROP FUNCTION IF EXISTS cria_disciplina(VARCHAR(7), VARCHAR(100), INTEGER, INTEGER, VARCHAR(50));
DROP FUNCTION IF EXISTS seleciona_disciplina(VARCHAR(7));
DROP FUNCTION IF EXISTS atualiza_nome_disciplina(VARCHAR(7), VARCHAR(100));
DROP FUNCTION IF EXISTS atualiza_creds_aula_disciplina(VARCHAR(7), INTEGER);
DROP FUNCTION IF EXISTS atualiza_creds_trabalho_disciplina(VARCHAR(7), INTEGER);
DROP FUNCTION IF EXISTS atualiza_instituto_disciplina(VARCHAR(7), VARCHAR(50));
DROP FUNCTION IF EXISTS remove_disciplina(VARCHAR(7));

DROP FUNCTION IF EXISTS cria_requisito(VARCHAR(7), VARCHAR(7));
DROP FUNCTION IF EXISTS seleciona_requisito(VARCHAR(7), VARCHAR(7));
DROP FUNCTION IF EXISTS atualiza_requisito(VARCHAR(7), VARCHAR(7), VARCHAR(7));
DROP FUNCTION IF EXISTS remove_requisito(VARCHAR(7), VARCHAR(7));

DROP FUNCTION IF EXISTS cria_rel_cur_tri(INTEGER, INTEGER);
DROP FUNCTION IF EXISTS seleciona_rel_cur_tri(INTEGER, _id_trilha INTEGER);
DROP FUNCTION IF EXISTS atualiza_rel_cur_tri_trilha(INTEGER, INTEGER, INTEGER);
DROP FUNCTION IF EXISTS atualiza_rel_cur_tri_curso(INTEGER, INTEGER, INTEGER);
DROP FUNCTION IF EXISTS remove_rel_cur_tri(INTEGER, INTEGER);

DROP FUNCTION IF EXISTS cria_rel_mod_dis(INTEGER, VARCHAR(7), BIT);
DROP FUNCTION IF EXISTS seleciona_rel_mod_dis(INTEGER, VARCHAR(7));
DROP FUNCTION IF EXISTS atualiza_rel_mod_dis_modulo(INTEGER, VARCHAR(7));
DROP FUNCTION IF EXISTS atualiza_rel_mod_dis_disciplina(INTEGER, VARCHAR(7));
DROP FUNCTION IF EXISTS atualiza_obrigatoriedade_disciplina(INTEGER, VARCHAR(7), BIT);
DROP FUNCTION IF EXISTS remove_rel_mod_dis(INTEGER, VARCHAR(7));

-- CURRICULO

CREATE OR REPLACE FUNCTION cria_curriculo(INTEGER, VARCHAR(50)) RETURNS VOID
LANGUAGE plpgsql
AS $$
BEGIN
	INSERT INTO curriculo(codigo, nome) VALUES ($1, $2);
END
$$;

CREATE OR REPLACE FUNCTION seleciona_curriculo(INTEGER) RETURNS TABLE(cod INTEGER, nome VARCHAR(50), id_adm INTEGER)
LANGUAGE plpgsql
AS $$
BEGIN
	RETURN QUERY SELECT * FROM curriculo WHERE codigo=$1;
END;
$$;

CREATE OR REPLACE FUNCTION atualiza_curriculo(INTEGER, VARCHAR(50), INTEGER) RETURNS VOID
LANGUAGE plpgsql
AS $$
BEGIN
	UPDATE curriculo
	SET nome=$2, id_adm=$3
	WHERE codigo=$1;
END
$$;

CREATE OR REPLACE FUNCTION remove_curriculo(INTEGER) RETURNS VOID
LANGUAGE plpgsql
AS $$
BEGIN
	DELETE FROM curriculo WHERE codigo=$1;
END
$$;

-- TRILHA

CREATE OR REPLACE FUNCTION cria_trilha(VARCHAR(50), VARCHAR(255), INTEGER) RETURNS VOID
LANGUAGE plpgsql
AS $$
BEGIN
	INSERT INTO trilha(nome, descricao, quant_mod) VALUES ($1, $2, $3);
END
$$;

CREATE OR REPLACE FUNCTION seleciona_trilha(VARCHAR(50)) RETURNS TABLE(id INTEGER, nome_ VARCHAR(50), descricao VARCHAR(255), quant_mod INTEGER)
LANGUAGE plpgsql
AS $$
DECLARE _id INTEGER;
BEGIN
    _id := (SELECT id_trilha FROM trilha WHERE nome = $1);
	RETURN QUERY SELECT * FROM trilha WHERE id_trilha = _id;
END;
$$;

CREATE OR REPLACE FUNCTION atualiza_descricao_trilha(VARCHAR(50), VARCHAR(255)) RETURNS VOID
LANGUAGE plpgsql
AS $$
BEGIN
	UPDATE trilha
	SET descricao=$2
	WHERE nome=$1;
END
$$;

CREATE OR REPLACE FUNCTION atualiza_disc_trilha(VARCHAR(50), INTEGER) RETURNS VOID
LANGUAGE plpgsql
AS $$
BEGIN
	UPDATE trilha
	SET quant_mod=$2
	WHERE nome=$1;
END
$$;

CREATE OR REPLACE FUNCTION remove_trilha(VARCHAR(50)) RETURNS VOID
LANGUAGE plpgsql
AS $$
BEGIN
	DELETE FROM trilha WHERE nome=$1;
END
$$;

-- MODULO

CREATE OR REPLACE FUNCTION cria_modulo(INTEGER, VARCHAR(50), VARCHAR(255), INTEGER) RETURNS VOID 
LANGUAGE plpgsql
AS $$
BEGIN
	INSERT INTO modulo(id_trilha, nome, descricao, quant_disc) VALUES ($1, $2, $3, $4);
END
$$;

CREATE OR REPLACE FUNCTION seleciona_modulo(VARCHAR(50)) RETURNS TABLE(id_mod INTEGER, id_trilha INTEGER, nome_ VARCHAR(50), descricao VARCHAR(255), quant_disc INTEGER)
LANGUAGE plpgsql
AS $$
BEGIN
    RETURN QUERY SELECT * FROM modulo WHERE nome = $1;
END;
$$;

CREATE OR REPLACE FUNCTION atualiza_descricao_modulo(VARCHAR(50), VARCHAR(255)) RETURNS VOID
LANGUAGE plpgsql
AS $$
BEGIN
	UPDATE modulo
	SET descricao=$2
	WHERE nome=$1;
END
$$;

CREATE OR REPLACE FUNCTION atualiza_disc_modulo(VARCHAR(50), INTEGER) RETURNS VOID
LANGUAGE plpgsql
AS $$
BEGIN
	UPDATE modulo
	SET quant_disc=$2
	WHERE nome=$1;
END
$$;

CREATE OR REPLACE FUNCTION remove_modulo(VARCHAR(50)) RETURNS VOID 
LANGUAGE plpgsql
AS $$
BEGIN
	DELETE FROM modulo WHERE nome=$1;
END
$$;

-- DISCIPLINA

CREATE OR REPLACE FUNCTION cria_disciplina(VARCHAR(7), VARCHAR(100), INTEGER, INTEGER, VARCHAR(50)) RETURNS VOID
LANGUAGE plpgsql
AS $$
BEGIN
	INSERT INTO disciplina(codigo, nome, creditos_aula, creditos_trabalho, instituto) VALUES ($1, $2, $3, $4, $5);
END
$$;

CREATE OR REPLACE FUNCTION seleciona_disciplina(VARCHAR(7)) RETURNS TABLE(cod VARCHAR(7), nome VARCHAR(100), creditos_aula INTEGER, creditos_trabalho INTEGER, instituto VARCHAR(50))
LANGUAGE plpgsql
AS $$
BEGIN
    RETURN QUERY SELECT * FROM disciplina WHERE codigo = $1;
END;
$$;

CREATE OR REPLACE FUNCTION atualiza_nome_disciplina(VARCHAR(7), VARCHAR(100)) RETURNS VOID
LANGUAGE plpgsql
AS $$
BEGIN
	UPDATE disciplina
	SET nome=$2
	WHERE codigo=$1;
END
$$;

CREATE OR REPLACE FUNCTION atualiza_creds_aula_disciplina(VARCHAR(7), INTEGER) RETURNS VOID
LANGUAGE plpgsql
AS $$
BEGIN
	UPDATE disciplina
	SET creditos_aula=$2
	WHERE codigo=$1;
	END
$$;

CREATE OR REPLACE FUNCTION atualiza_creds_trabalho_disciplina(VARCHAR(7), INTEGER) RETURNS VOID
LANGUAGE plpgsql
AS $$
	BEGIN
	UPDATE disciplina
	SET creditos_trabalho = $2
	WHERE codigo=$1;
END
$$;

CREATE OR REPLACE FUNCTION atualiza_instituto_disciplina(VARCHAR(7), VARCHAR(50)) RETURNS VOID
LANGUAGE plpgsql
AS $$
BEGIN
	UPDATE disciplina
	SET instituto=$2
	WHERE codigo=$1;
END
$$;

CREATE OR REPLACE FUNCTION remove_disciplina(VARCHAR(7)) RETURNS VOID
LANGUAGE plpgsql
AS $$
BEGIN
	DELETE FROM disciplina WHERE codigo=$1;
END
$$;

-- REQUISITO

CREATE OR REPLACE FUNCTION cria_requisito(VARCHAR(7), VARCHAR(7)) RETURNS VOID
LANGUAGE plpgsql
AS $$
BEGIN
	INSERT INTO requisito(codigo_disc, codigo_req) VALUES ($1, $2);
END
$$;

CREATE OR REPLACE FUNCTION seleciona_requisito(VARCHAR(7), VARCHAR(7)) RETURNS TABLE(codigo_disc VARCHAR(7), codigo_req VARCHAR(7))
LANGUAGE plpgsql
AS $$
BEGIN
    RETURN QUERY SELECT * FROM requisito WHERE codigo_disc = $1 AND codigo_req = $2;
END;
$$;

CREATE OR REPLACE FUNCTION atualiza_requisito(VARCHAR(7), VARCHAR(7), VARCHAR(7)) RETURNS VOID
LANGUAGE plpgsql
AS $$
BEGIN
	UPDATE requisito
	SET codigo_req = $3
	WHERE codigo_disc = $1 AND codigo_req = $2;
END
$$;

CREATE OR REPLACE FUNCTION remove_requisito(VARCHAR(7), VARCHAR(7)) RETURNS VOID
LANGUAGE plpgsql
AS $$
BEGIN
	DELETE FROM requisito WHERE codigo_disc = $1 AND codigo_req = $2;
END
$$;

-- REL_CUR_TRI

CREATE OR REPLACE FUNCTION cria_rel_cur_tri(INTEGER, INTEGER) RETURNS VOID
LANGUAGE plpgsql
AS $$
BEGIN
	INSERT INTO rel_cur_tri(codigo, id_trilha) VALUES ($1, $2);
END
$$;

CREATE OR REPLACE FUNCTION seleciona_rel_cur_tri(INTEGER, _id_trilha INTEGER) RETURNS TABLE(codigo_ INTEGER, id_trilha_ INTEGER)
LANGUAGE plpgsql
AS $$
BEGIN
    RETURN QUERY SELECT * FROM rel_cur_tri WHERE codigo = $1 and id_trilha = $2;
END;
$$;

CREATE OR REPLACE FUNCTION atualiza_rel_cur_tri_trilha(INTEGER, INTEGER, INTEGER) RETURNS VOID
LANGUAGE plpgsql
AS $$
BEGIN
	UPDATE rel_cur_tri
	SET id_trilha = $3
	WHERE codigo = $1 AND id_trilha = $2;
END
$$;

CREATE OR REPLACE FUNCTION atualiza_rel_cur_tri_curso(INTEGER, INTEGER, INTEGER) RETURNS VOID
LANGUAGE plpgsql
AS $$
BEGIN
	UPDATE rel_cur_tri
	SET codigo = $3
	WHERE codigo = $1 AND id_trilha = $2;
END
$$;

CREATE OR REPLACE FUNCTION remove_rel_cur_tri(INTEGER, INTEGER) RETURNS VOID
LANGUAGE plpgsql
AS $$
BEGIN
	DELETE FROM rel_cur_tri WHERE codigo = $1 AND id_trilha = $2;
END
$$;

-- REL_MOD_DIS

CREATE OR REPLACE FUNCTION cria_rel_mod_dis(INTEGER, VARCHAR(7), BIT) RETURNS VOID
LANGUAGE plpgsql
AS $$
BEGIN
	INSERT INTO rel_mod_dis(id_modulo, codigo, obrigatoria) VALUES ($1, $2, $3);
END
$$;

CREATE OR REPLACE FUNCTION seleciona_rel_mod_dis(INTEGER, VARCHAR(7)) RETURNS TABLE(id_modulo_ INTEGER, codigo_ VARCHAR(7), obrigatoria_ BIT)
LANGUAGE plpgsql
AS $$
BEGIN
    RETURN QUERY SELECT * FROM rel_mod_dis WHERE id_modulo = $1 and codigo = $2;
END;
$$;

CREATE OR REPLACE FUNCTION atualiza_rel_mod_dis_modulo(INTEGER, VARCHAR(7)) RETURNS VOID
LANGUAGE plpgsql
AS $$
BEGIN
	UPDATE rel_mod_dis
	SET id_modulo = $2
	WHERE id_modulo = $1 AND codigo = $2;
END
$$;

CREATE OR REPLACE FUNCTION atualiza_rel_mod_dis_disciplina(INTEGER, VARCHAR(7)) RETURNS VOID
LANGUAGE plpgsql
AS $$
BEGIN
	UPDATE rel_mod_dis
	SET codigo = $2
	WHERE id_modulo = $1 AND codigo = $2;
END
$$;

CREATE OR REPLACE FUNCTION atualiza_obrigatoriedade_disciplina(INTEGER, VARCHAR(7), BIT) RETURNS VOID
LANGUAGE plpgsql
AS $$
BEGIN
	UPDATE rel_mod_dis
	SET obrigatoria = $3
	WHERE id_modulo = $1 AND codigo = $2;
END
$$;

CREATE OR REPLACE FUNCTION remove_rel_mod_dis(INTEGER, VARCHAR(7)) RETURNS VOID
LANGUAGE plpgsql
AS $$
BEGIN
	DELETE FROM rel_mod_dis WHERE id_modulo = $1 AND codigo = $2;
END
$$;