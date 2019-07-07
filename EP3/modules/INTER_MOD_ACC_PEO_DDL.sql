DROP DATABASE IF EXISTS mod_acc_peo;
CREATE DATABASE mod_acc_peo;
\c mod_acc_peo;

CREATE EXTENSION postgres_fdw;

CREATE SERVER acc_server
FOREIGN DATA WRAPPER postgres_fdw
OPTIONS (host 'localhost', port '5432', dbname 'mod_acc');

CREATE SERVER peo_server
FOREIGN DATA WRAPPER postgres_fdw
OPTIONS (host 'localhost', port '5432', dbname 'mod_peo');

CREATE FOREIGN TABLE pessoa_foreign (
    id_pessoa SERIAL,
	nome varchar(100)
)
SERVER peo_server
OPTIONS (table_name 'pessoa');

CREATE FOREIGN TABLE usuario_foreign (
    login VARCHAR(50),
    email VARCHAR(100),
    senha VARCHAR(50)
)
SERVER acc_server
OPTIONS (table_name 'usuario');

CREATE TABLE rel_pe_us (
    id_pessoa SERIAL UNIQUE,
    login VARCHAR(50) UNIQUE
);