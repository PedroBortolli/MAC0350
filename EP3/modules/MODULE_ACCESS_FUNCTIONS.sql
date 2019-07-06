DROP FUNCTION IF EXISTS cria_usuario(VARCHAR(50), VARCHAR(100), VARCHAR(50));
DROP FUNCTION IF EXISTS seleciona_usuario(VARCHAR(50));
DROP FUNCTION IF EXISTS atualiza_usuario_email(VARCHAR(50), VARCHAR(100));
DROP FUNCTION IF EXISTS remove_usuario(VARCHAR(50));

DROP FUNCTION IF EXISTS cria_perfil (VARCHAR(50));
DROP FUNCTION IF EXISTS seleciona_perfil (VARCHAR(50));

DROP FUNCTION IF EXISTS cria_servico (VARCHAR(50));

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

CREATE OR REPLACE FUNCTION cria_perfil (VARCHAR(50), text) RETURNS VOID
LANGUAGE plpgsql
AS $$
BEGIN
    INSERT INTO perfil (papel, descricao) VALUES ($1, $2);
END;
$$;

CREATE OR REPLACE FUNCTION seleciona_perfil (VARCHAR(50))
RETURNS TABLE(
    papel VARCHAR(50),
    descricao VARCHAR(100),
)
LANGUAGE plpgsql
AS $$
BEGIN
    RETURN QUERY SELECT * FROM perfil WHERE perfil.papel=$1;
END;
$$;

CREATE OR REPLACE FUNCTION cria_servico (VARCHAR(50), text) RETURNS VOID
LANGUAGE plpgsql
AS $$
BEGIN
    INSERT INTO servico (tipo, descricao) VALUES ($1, $2);
END;
$$;
