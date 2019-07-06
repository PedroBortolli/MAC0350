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
    id_pessoa SERIAL PRIMARY KEY,
	nome varchar(100)
)
SERVER pessoa_server
OPTIONS (table_name 'pessoa');