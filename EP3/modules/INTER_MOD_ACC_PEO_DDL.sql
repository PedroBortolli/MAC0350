CREATE EXTENSION IF NOT EXISTS postgres_fdw;

CREATE SERVER acc_server
FOREIGN DATA WRAPPER postgres_fdw
OPTIONS (host 'localhost', port '5432', dbname 'mod_acc');

CREATE SERVER pe_server
FOREIGN DATA WRAPPER postgres_fdw
OPTIONS (host 'localhost', port '5432', dbname 'mod_peo');

CREATE USER MAPPING FOR postgres
SERVER acc_server
OPTIONS (user 'postgres', password 'postgres');

CREATE USER MAPPING FOR postgres
SERVER pe_server
OPTIONS (user 'postgres', password 'postgres');

CREATE FOREIGN TABLE pessoa_foreign (
    cpf VARCHAR(11),
	nome varchar(100)
)
SERVER pe_server
OPTIONS (table_name 'pessoa');

CREATE FOREIGN TABLE usuario_foreign (
    login VARCHAR(50),
    email VARCHAR(100),
    senha VARCHAR(50)
)
SERVER acc_server
OPTIONS (table_name 'usuario');

CREATE TABLE rel_pe_us (
    cpf VARCHAR(11) UNIQUE,
    login VARCHAR(50) UNIQUE
);