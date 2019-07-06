DROP FUNCTION IF EXISTS cria_usuario (VARCHAR(50), VARCHAR(100), VARCHAR(50));
DROP FUNCTION IF EXISTS seleciona_usuario (VARCHAR(50));
DROP FUNCTION IF EXISTS atualiza_usuario_email (VARCHAR(50), VARCHAR(100));
DROP FUNCTION IF EXISTS remove_usuario (VARCHAR(50));

DROP FUNCTION IF EXISTS cria_perfil (VARCHAR(50), TEXT);
DROP FUNCTION IF EXISTS seleciona_perfil (VARCHAR(50));
DROP FUNCTION IF EXISTS atualiza_perfil_descricao (VARCHAR(50), TEXT);
DROP FUNCTION IF EXISTS remove_perfil (VARCHAR(50));

DROP FUNCTION IF EXISTS cria_servico (VARCHAR(50), TEXT);
DROP FUNCTION IF EXISTS seleciona_servico (VARCHAR(50));
DROP FUNCTION IF EXISTS atualiza_servico_descricao (VARCHAR(50), TEXT);
DROP FUNCTION IF EXISTS remove_servico (VARCHAR(50));

DROP FUNCTION IF EXISTS associa_perfil (VARCHAR(50), VARCHAR(50));
DROP FUNCTION IF EXISTS seleciona_perfis (VARCHAR(50));

DROP FUNCTION IF EXISTS associa_servicos (VARCHAR(50), VARCHAR(50));
DROP FUNCTION IF EXISTS seleciona_servicos (VARCHAR(50));

-- USUARIO

CREATE OR REPLACE FUNCTION cria_usuario (VARCHAR(50), VARCHAR(100), VARCHAR(50)) RETURNS VOID
LANGUAGE plpgsql
AS $$
BEGIN
    INSERT INTO usuario (login, email, senha) VALUES ($1, $2, $3);
END;
$$;

CREATE OR REPLACE FUNCTION seleciona_usuario (VARCHAR(50))
RETURNS TABLE(
    login VARCHAR(50),
    email VARCHAR(100),
    senha VARCHAR(50)
)
LANGUAGE plpgsql
AS $$
BEGIN
    RETURN QUERY SELECT * FROM usuario WHERE usuario.login=$1;
END;
$$;

CREATE OR REPLACE FUNCTION atualiza_usuario_email (VARCHAR(50), VARCHAR(100)) RETURNS VOID
LANGUAGE plpgsql
AS $$
BEGIN
    UPDATE usuario
    SET email = $2
    WHERE login = $1;
END;
$$;

CREATE OR REPLACE FUNCTION remove_usuario (VARCHAR(50)) RETURNS VOID
LANGUAGE plpgsql
AS $$
BEGIN
    DELETE FROM usuario WHERE login = $1; 
END;
$$;

-- PERFIL

CREATE OR REPLACE FUNCTION cria_perfil (VARCHAR(50), TEXT) RETURNS VOID
LANGUAGE plpgsql
AS $$
BEGIN
    INSERT INTO perfil (papel, descricao) VALUES ($1, $2);
END;
$$;

CREATE OR REPLACE FUNCTION seleciona_perfil (VARCHAR(50))
RETURNS TABLE(
    papel VARCHAR(50),
    descricao TEXT
)
LANGUAGE plpgsql
AS $$
BEGIN
    RETURN QUERY SELECT * FROM perfil WHERE perfil.papel=$1;
END;
$$;

CREATE OR REPLACE FUNCTION atualiza_perfil_descricao (VARCHAR(50), TEXT) RETURNS VOID
LANGUAGE plpgsql
AS $$
BEGIN
    UPDATE perfil
    SET descricao = $2
    WHERE papel = $1;
END;
$$;

CREATE OR REPLACE FUNCTION remove_perfil (VARCHAR(50)) RETURNS VOID
LANGUAGE plpgsql
AS $$
BEGIN
    DELETE FROM perfil WHERE papel = $1;
END;
$$;

-- SERVICO

CREATE OR REPLACE FUNCTION cria_servico (VARCHAR(50), TEXT) RETURNS VOID
LANGUAGE plpgsql
AS $$
BEGIN
    INSERT INTO servico (tipo, descricao) VALUES ($1, $2);
END;
$$;



CREATE OR REPLACE FUNCTION seleciona_servico (VARCHAR(50))
RETURNS TABLE(
    tipo VARCHAR(50),
    descricao TEXT
)
LANGUAGE plpgsql
AS $$
BEGIN
    RETURN QUERY SELECT * FROM servico WHERE servico.tipo = $1;
END;
$$;

CREATE OR REPLACE FUNCTION atualiza_servico_descricao (VARCHAR(50), TEXT) RETURNS VOID
LANGUAGE plpgsql
AS $$
BEGIN
    UPDATE servico
    SET descricao = $2
    WHERE tipo = $1;
END;
$$;

CREATE OR REPLACE FUNCTION remove_servico (VARCHAR(50)) RETURNS VOID
LANGUAGE plpgsql
AS $$
BEGIN
    DELETE FROM servico WHERE tipo = $1;
END;
$$;

-- REL_US_PF

CREATE OR REPLACE FUNCTION associa_perfil (VARCHAR(50), VARCHAR(50)) RETURNS VOID
LANGUAGE plpgsql
AS $$
BEGIN
    INSERT INTO rel_us_pf (usuario_id, perfil_id) VALUES ($1, $2);
END;
$$;

CREATE OR REPLACE FUNCTION seleciona_perfis (VARCHAR(50))
RETURNS TABLE (
    papel VARCHAR(50),
    descricao TEXT
)
LANGUAGE plpgsql
AS $$
BEGIN
    RETURN QUERY SELECT perfil.papel, perfil.descricao FROM perfil
    INNER JOIN rel_us_pf ON perfil.papel = rel_us_pf.perfil_id
    WHERE rel_us_pf.usuario_id = $1;
END;
$$;

-- REL_PF_SE

CREATE OR REPLACE FUNCTION associa_servicos (VARCHAR(50), VARCHAR(50)) RETURNS VOID
LANGUAGE plpgsql
AS $$
BEGIN
    INSERT INTO rel_pf_se (perfil_id, servico_id) VALUES ($1, $2);
END;
$$;

CREATE OR REPLACE FUNCTION seleciona_servicos (VARCHAR(50))
RETURNS TABLE (
    tipo VARCHAR(50),
    descricao TEXT
)
LANGUAGE plpgsql
AS $$
BEGIN
    RETURN QUERY SELECT servico.tipo, servico.descricao FROM servico
    INNER JOIN rel_pf_se ON servico.tipo = rel_pf_se.servico_id
    WHERE rel_pf_se.perfil_id = $1;
END;
$$;

-- N EXISTE, MAS REL_US_SE

CREATE OR REPLACE FUNCTION seleciona_servicos_usuario (VARCHAR(50))
RETURNS TABLE (
    tipo VARCHAR(50),
    descricao TEXT
)
LANGUAGE plpgsql
AS $$
BEGIN
    RETURN QUERY SELECT servico.tipo, servico.descricao FROM servico
    INNER JOIN rel_pf_se ON servico.tipo = rel_pf_se.servico_id
    INNER JOIN rel_us_pf ON rel_pf_se.perfil_id = rel_us_pf.perfil_id
    WHERE rel_us_pf.usuario_id = $1;
END;
$$;
