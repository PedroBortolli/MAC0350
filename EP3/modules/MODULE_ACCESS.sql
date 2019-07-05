DROP TABLE rel_us_pf;
DROP TABLE rel_pf_se;
DROP TABLE usuario;
DROP TABLE perfil;
DROP TABLE servico;

-- o 'IF NOT EXISTS' n faz nada por enquanto, mas eventualmente vai ser util

CREATE TABLE IF NOT EXISTS usuario (
    -- aqui precisa da chave de pessoa eventualmente, mas tem que pegar de outra db
    login VARCHAR(50) PRIMARY KEY,
    email VARCHAR(100) UNIQUE NOT NULL CHECK (email ~* '^.+\@.+\..+$'),
    senha VARCHAR(50) CHECK (char_length(senha) >= 8)
);

CREATE TABLE IF NOT EXISTS perfil (
    papel varchar(50) PRIMARY KEY,
    descricao text NOT NULL
);

CREATE TABLE IF NOT EXISTS servico (
    tipo VARCHAR(50) PRIMARY KEY,
    descricao TEXT NOT NULL
);

CREATE TABLE IF NOT EXISTS rel_us_pf (
    usuario_id VARCHAR(50) REFERENCES usuario(login) ON UPDATE CASCADE ON DELETE CASCADE,
    perfil_id VARCHAR(50) REFERENCES perfil(papel) ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS rel_pf_se (
    perfil_id VARCHAR(50) REFERENCES perfil(papel) ON UPDATE CASCADE ON DELETE CASCADE,
    servico_id VARCHAR(50) REFERENCES servico(tipo) ON UPDATE CASCADE ON DELETE CASCADE
);

-- FUNCTIONS

DROP FUNCTION IF EXISTS cria_usuario(VARCHAR(50), VARCHAR(100), VARCHAR(50));
DROP FUNCTION IF EXISTS seleciona_usuario(VARCHAR(50));
DROP FUNCTION IF EXISTS atualiza_usuario_email(VARCHAR(50), VARCHAR(100));

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

-- POPULAR O BANCO (isso n fica nesse arquivo, mas né... foda-se)

SELECT cria_usuario ('admin', 'admin@admin.com', 'password');
SELECT cria_usuario ('cef', 'cef@ime.usp.br', 'euamoacris');

SELECT atualiza_usuario_email ('admin', 'newadmin@admin.com');
