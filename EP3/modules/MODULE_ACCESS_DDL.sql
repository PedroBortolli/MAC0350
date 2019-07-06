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
