DROP FUNCTION IF EXISTS seleciona_pessoa(varchar(100));
DROP FUNCTION IF EXISTS seleciona_aluno(varchar(100));
DROP FUNCTION IF EXISTS seleciona_professor(varchar(100));
DROP FUNCTION IF EXISTS seleciona_usuario(varchar(100));
DROP FUNCTION IF EXISTS seleciona_administrador(varchar(100));
DROP FUNCTION IF EXISTS seleciona_curriculo(integer);
DROP FUNCTION IF EXISTS seleciona_perfil(varchar(50));
DROP FUNCTION IF EXISTS seleciona_servico(varchar(50));
DROP FUNCTION IF EXISTS seleciona_trilha(varchar(50));

DROP FUNCTION IF EXISTS cria_pessoa(varchar(100));
DROP FUNCTION IF EXISTS cria_aluno(varchar(100), integer);
DROP FUNCTION IF EXISTS cria_professor(varchar(100), varchar(50));
DROP FUNCTION IF EXISTS cria_usuario(varchar(100), varchar(20), varchar(50), varchar(64));
DROP FUNCTION IF EXISTS cria_administrador(varchar(100), date, date);
DROP FUNCTION IF EXISTS cria_curriculo(integer, varchar(50));
DROP FUNCTION IF EXISTS cria_perfil(varchar(50), varchar(255));
DROP FUNCTION IF EXISTS cria_servico(varchar(50), varchar(255));
DROP FUNCTION IF EXISTS cria_trilha(varchar(50), varchar(255), integer);

DROP FUNCTION IF EXISTS deleta_pessoa(varchar(100));
DROP FUNCTION IF EXISTS deleta_aluno(varchar(100));
DROP FUNCTION IF EXISTS deleta_professor(varchar(100));
DROP FUNCTION IF EXISTS deleta_usuario(varchar(100));
DROP FUNCTION IF EXISTS deleta_administrador(varchar(100));
DROP FUNCTION IF EXISTS deleta_curriculo(integer);
DROP FUNCTION IF EXISTS deleta_perfil(varchar(50));
DROP FUNCTION IF EXISTS deleta_servico(varchar(50));
DROP FUNCTION IF EXISTS deleta_trilha(varchar(50));

DROP FUNCTION IF EXISTS atualiza_pessoa(varchar(100), varchar(100));
DROP FUNCTION IF EXISTS atualiza_aluno(varchar(100), integer);
DROP FUNCTION IF EXISTS atualiza_professor(varchar(100), varchar(50));
DROP FUNCTION IF EXISTS atualiza_login_usuario( varchar(100), varchar(20));
DROP FUNCTION IF EXISTS atualiza_email_usuario(varchar(100), varchar(50));
DROP FUNCTION IF EXISTS atualiza_senha_usuario(varchar(100), varchar(50), varchar(50));
DROP FUNCTION IF EXISTS atualiza_administrador(varchar(100), date, date);
DROP FUNCTION IF EXISTS atualiza_curriculo(integer, varchar(50));
DROP FUNCTION IF EXISTS atualiza_perfil(varchar(50), varchar(255));
DROP FUNCTION IF EXISTS atualiza_servico(varchar(50), varchar(255));
DROP FUNCTION IF EXISTS atualiza_disc_trilha(varchar(50), integer);
DROP FUNCTION IF EXISTS atualiza_descricao_trilha(varchar(50), varchar(255));

-------------------------------------------------------------------------



CREATE OR REPLACE FUNCTION cria_pessoa(_nome varchar(100)) RETURNS VOID AS $$
	BEGIN
		INSERT INTO pessoa(nome) VALUES (_nome);
	END
$$ LANGUAGE plpgsql;


CREATE OR REPLACE FUNCTION seleciona_pessoa(_nome varchar(100)) RETURNS TABLE(id integer, nome_pessoa varchar(100)) AS $$
	BEGIN
		RETURN QUERY SELECT * FROM pessoa WHERE nome = _nome;
	END
$$ LANGUAGE plpgsql;


CREATE OR REPLACE FUNCTION deleta_pessoa(_nome varchar(100)) RETURNS VOID AS $$
	BEGIN
		DELETE FROM pessoa WHERE nome = _nome;
	END
$$ LANGUAGE plpgsql;


CREATE OR REPLACE FUNCTION atualiza_pessoa(_nome varchar(100), _novo_nome varchar(100)) RETURNS VOID AS $$
	DECLARE _id integer;
	BEGIN
	    _id := (SELECT id_pessoa FROM pessoa WHERE nome = _nome);
		UPDATE pessoa
        SET nome=_novo_nome
        WHERE id_pessoa=_id;
	END
$$ LANGUAGE plpgsql;


CREATE OR REPLACE FUNCTION cria_aluno(_nome varchar(100), _ano_ingresso integer) RETURNS VOID AS $$
	DECLARE _id integer;
	BEGIN
		_id := (SELECT id_pessoa FROM pessoa WHERE nome = _nome);
		INSERT INTO aluno(id_aluno, ano_ingresso) VALUES (_id, _ano_ingresso);
	END
$$ LANGUAGE plpgsql;


CREATE OR REPLACE FUNCTION seleciona_aluno(_nome varchar(100)) RETURNS TABLE(id integer, ano_ingresso integer) AS $$
	DECLARE id integer;
	BEGIN
		id := (SELECT id_pessoa FROM pessoa WHERE nome = _nome);
		RETURN QUERY SELECT * FROM aluno WHERE id_aluno = id;
	END
$$ LANGUAGE plpgsql;


CREATE OR REPLACE FUNCTION deleta_aluno(_nome varchar(100)) RETURNS VOID AS $$
	DECLARE id integer;
	BEGIN
		id := (SELECT id_pessoa FROM pessoa WHERE nome = _nome);
		DELETE FROM aluno WHERE id_aluno = id;
	END
$$ LANGUAGE plpgsql;


CREATE OR REPLACE FUNCTION atualiza_aluno(_nome varchar(100), _ano_ingresso integer) RETURNS VOID AS $$
	DECLARE _id integer;
	BEGIN
		_id := (SELECT id_pessoa FROM pessoa WHERE nome = _nome);
		UPDATE aluno
        SET ano_ingresso=_ano_ingresso
        WHERE id_aluno=_id;
	END
$$ LANGUAGE plpgsql;


CREATE OR REPLACE FUNCTION cria_professor(_nome varchar(100), _formacao_area varchar(50)) RETURNS VOID AS $$
	DECLARE _id integer;
	BEGIN
		_id := (SELECT id_pessoa FROM pessoa WHERE nome = _nome);
		INSERT INTO professor(id_professor, formacao_area) VALUES (_id, _formacao_area);
	END
$$ LANGUAGE plpgsql;


CREATE OR REPLACE FUNCTION seleciona_professor(_nome varchar(100)) RETURNS TABLE(id integer, formacao_area varchar(50)) AS $$
	DECLARE id integer;
	BEGIN
		id := (SELECT id_pessoa FROM pessoa WHERE nome = _nome);
		RETURN QUERY SELECT * FROM professor WHERE id_professor = id;
	END
$$ LANGUAGE plpgsql;


CREATE OR REPLACE FUNCTION deleta_professor(_nome varchar(100)) RETURNS VOID AS $$
	DECLARE id integer;
	BEGIN
		id := (SELECT id_pessoa FROM pessoa WHERE nome = _nome);
		DELETE FROM professor WHERE id_professor = id;
	END
$$ LANGUAGE plpgsql;


CREATE OR REPLACE FUNCTION atualiza_professor(_nome varchar(100), _formacao_area varchar(50)) RETURNS VOID AS $$
	DECLARE _id integer;
	BEGIN
		_id := (SELECT id_pessoa FROM pessoa WHERE nome = _nome);
		UPDATE professor
        SET formacao_area=_formacao_area
        WHERE id_professor=_id;
	END
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION cria_usuario(_nome varchar(100), login varchar(20), email varchar(50), senha varchar(64)) RETURNS VOID AS $$
	DECLARE _id integer;
	BEGIN
		_id := (SELECT id_pessoa FROM pessoa WHERE nome = _nome);
		INSERT INTO usuario(id_usuario, login, email, senha) VALUES (_id, login, email, crypt(senha, gen_salt('bf')));
	END
$$ LANGUAGE plpgsql;


CREATE OR REPLACE FUNCTION seleciona_usuario(_nome varchar(100)) RETURNS TABLE(id integer, login varchar(20), email varchar(50), senha varchar(64)) AS $$
	DECLARE _id integer;
	BEGIN
		_id := (SELECT id_pessoa FROM pessoa WHERE nome = _nome);
		RETURN QUERY SELECT * FROM usuario WHERE id_usuario = _id;
	END
$$ LANGUAGE plpgsql;


CREATE OR REPLACE FUNCTION deleta_usuario(_nome varchar(100)) RETURNS VOID AS $$
	DECLARE id integer;
	BEGIN
		id := (SELECT id_pessoa FROM pessoa WHERE nome = _nome);
		DELETE FROM usuario WHERE id_usuario = id;
	END
$$ LANGUAGE plpgsql;


CREATE OR REPLACE FUNCTION atualiza_login_usuario(_nome varchar(100), _login varchar(20)) RETURNS VOID AS $$
	DECLARE _id integer;
	BEGIN
		_id := (SELECT id_pessoa FROM pessoa WHERE nome = _nome);
		UPDATE usuario
        SET login=_login
        WHERE id_usuario=_id;
	END
$$ LANGUAGE plpgsql;


CREATE OR REPLACE FUNCTION atualiza_email_usuario(_nome varchar(100), _email varchar(50)) RETURNS VOID AS $$
	DECLARE _id integer;
	BEGIN
		_id := (SELECT id_pessoa FROM pessoa WHERE nome = _nome);
		UPDATE usuario
        SET email=_email
        WHERE id_usuario=_id;
	END
$$ LANGUAGE plpgsql;


CREATE OR REPLACE FUNCTION atualiza_senha_usuario(_nome varchar(100), _senha_antiga varchar(50), _senha_nova varchar(50)) RETURNS VOID AS $$
	DECLARE _id integer;
	BEGIN
		_id := (SELECT id_pessoa FROM pessoa WHERE nome = _nome);
		UPDATE usuario
        SET senha=crypt(_senha_nova, gen_salt('bf'))
        WHERE id_usuario=_id and senha=crypt(_senha_antiga, senha);
	END
$$ LANGUAGE plpgsql;


CREATE OR REPLACE FUNCTION cria_administrador(_nome varchar(100), _inicio date, _fim date) RETURNS VOID AS $$
	DECLARE _id integer;
	BEGIN
		_id := (SELECT id_pessoa FROM pessoa WHERE nome = _nome);
		INSERT INTO administrador(id_adm, inicio, fim) VALUES (_id, _inicio, _fim);
	END
$$ LANGUAGE plpgsql;


CREATE OR REPLACE FUNCTION seleciona_administrador(_nome varchar(100)) RETURNS TABLE(id integer, inicio date, fim date) AS $$
	DECLARE _id integer;
	BEGIN
		_id := (SELECT id_pessoa FROM pessoa WHERE nome = _nome);
		RETURN QUERY SELECT * FROM administrador WHERE id_adm = _id;
	END
$$ LANGUAGE plpgsql;


CREATE OR REPLACE FUNCTION deleta_administrador(_nome varchar(100)) RETURNS VOID AS $$
	DECLARE _id integer;
	BEGIN
		_id := (SELECT id_pessoa FROM pessoa WHERE nome = _nome);
		DELETE FROM administrador WHERE id_adm = _id;
	END
$$ LANGUAGE plpgsql;


CREATE OR REPLACE FUNCTION atualiza_administrador(_nome varchar(100), _inicio date, _fim date) RETURNS VOID AS $$
	DECLARE _id integer;
	BEGIN
	    _id := (SELECT id_pessoa FROM pessoa WHERE nome = _nome);
		UPDATE administrador
        SET inicio=_inicio, fim=_fim
        WHERE id_adm=_id;
	END
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION cria_curriculo(_codigo integer, _nome varchar(50)) RETURNS VOID AS $$
	BEGIN
		INSERT INTO curriculo(codigo, nome) VALUES (_codigo, _nome);
	END
$$ LANGUAGE plpgsql;


CREATE OR REPLACE FUNCTION seleciona_curriculo(_codigo integer) RETURNS TABLE(cod integer, nome varchar(50)) AS $$
	BEGIN
		RETURN QUERY SELECT * FROM curriculo WHERE codigo=_codigo;
	END
$$ LANGUAGE plpgsql;


CREATE OR REPLACE FUNCTION deleta_curriculo(_codigo integer) RETURNS VOID AS $$
	BEGIN
		DELETE FROM curriculo WHERE codigo=_codigo;
	END
$$ LANGUAGE plpgsql;


CREATE OR REPLACE FUNCTION atualiza_curriculo(_codigo integer, _nome varchar(50)) RETURNS VOID AS $$
	BEGIN
	    UPDATE curriculo
        SET nome=_nome
        WHERE codigo=_codigo;
	END
$$ LANGUAGE plpgsql;


CREATE OR REPLACE FUNCTION cria_perfil(_papel varchar(50), _descricao varchar(255)) RETURNS VOID AS $$
	BEGIN
		INSERT INTO perfil(papel, descricao) VALUES (_papel, _descricao);
	END
$$ LANGUAGE plpgsql;


CREATE OR REPLACE FUNCTION seleciona_perfil(_papel varchar(50)) RETURNS TABLE(id integer, papel_ varchar(50), descricao varchar(255)) AS $$
	DECLARE _id integer;
	BEGIN
	    _id := (SELECT id_perfil FROM perfil WHERE papel = _papel);
		RETURN QUERY SELECT * FROM perfil WHERE id_perfil=_id;
	END
$$ LANGUAGE plpgsql;


CREATE OR REPLACE FUNCTION deleta_perfil(_papel varchar(50)) RETURNS VOID AS $$
	DECLARE _id integer;
	BEGIN
	    _id := (SELECT id_perfil FROM perfil WHERE papel = _papel);
		DELETE FROM perfil WHERE id_perfil=_id;
	END
$$ LANGUAGE plpgsql;


CREATE OR REPLACE FUNCTION atualiza_perfil(_papel varchar(50), _descricao varchar(255)) RETURNS VOID AS $$
	DECLARE _id integer;
	BEGIN
	    _id := (SELECT id_perfil FROM perfil WHERE papel = _papel);
	    UPDATE perfil
        SET descricao=_descricao
        WHERE id_perfil=_id;
	END
$$ LANGUAGE plpgsql;


CREATE OR REPLACE FUNCTION cria_servico(_tipo varchar(50), _descricao varchar(255)) RETURNS VOID AS $$
	BEGIN
		INSERT INTO servico(tipo, descricao) VALUES (_tipo, _descricao);
	END
$$ LANGUAGE plpgsql;


CREATE OR REPLACE FUNCTION seleciona_servico(_tipo varchar(50)) RETURNS TABLE(id integer, tipo_ varchar(50), descricao varchar(255)) AS $$
	DECLARE _id integer;
	BEGIN
	    _id := (SELECT id_servico FROM servico WHERE tipo = _tipo);
		RETURN QUERY SELECT * FROM servico WHERE id_servico = _id;
	END
$$ LANGUAGE plpgsql;


CREATE OR REPLACE FUNCTION deleta_servico(_tipo varchar(50)) RETURNS VOID AS $$
	DECLARE _id integer;
	BEGIN
	    _id := (SELECT id_servico FROM servico WHERE tipo = _tipo);
		DELETE FROM servico WHERE id_servico=_id;
	END
$$ LANGUAGE plpgsql;


CREATE OR REPLACE FUNCTION atualiza_servico(_tipo varchar(50), _descricao varchar(255)) RETURNS VOID AS $$
	DECLARE _id integer;
	BEGIN
	    _id := (SELECT id_servico FROM servico WHERE tipo = _tipo);
	    UPDATE servico
        SET descricao=_descricao
        WHERE id_servico=_id;
	END
$$ LANGUAGE plpgsql;


CREATE OR REPLACE FUNCTION cria_trilha(_nome varchar(50), _descricao varchar(255), _quant_disc integer) RETURNS VOID AS $$
	BEGIN
		INSERT INTO trilha(nome, descricao, quant_disc) VALUES (_nome, _descricao, _quant_disc);
	END
$$ LANGUAGE plpgsql;


CREATE OR REPLACE FUNCTION seleciona_trilha(_nome varchar(50)) RETURNS TABLE(id integer, nome_ varchar(50), descricao varchar(255), quant_disc integer) AS $$
	DECLARE _id integer;
	BEGIN
	    _id := (SELECT id_trilha FROM trilha WHERE nome = _nome);
		RETURN QUERY SELECT * FROM trilha WHERE id_trilha = _id;
	END
$$ LANGUAGE plpgsql;


CREATE OR REPLACE FUNCTION deleta_trilha(_nome varchar(50)) RETURNS VOID AS $$
	BEGIN
	    DELETE FROM trilha WHERE nome=_nome;
	END
$$ LANGUAGE plpgsql;


CREATE OR REPLACE FUNCTION atualiza_descricao_trilha(_nome varchar(50), _descricao varchar(255)) RETURNS VOID AS $$
	BEGIN
	    UPDATE trilha
        SET descricao=_descricao
        WHERE nome=_nome;
	END
$$ LANGUAGE plpgsql;


CREATE OR REPLACE FUNCTION atualiza_disc_trilha(_nome varchar(50), _quant_disc integer) RETURNS VOID AS $$
	BEGIN
	    UPDATE trilha
        SET quant_disc=_quant_disc
        WHERE nome=_nome;
	END
$$ LANGUAGE plpgsql;

-------------------------------------------------------------------------



-- example of how to call funcions:
-- (yes, it uses SELECT for some reason even for creations => https://www.postgresql.org/docs/9.1/sql-syntax-calling-funcs.html)

SELECT cria_pessoa('bortolli');
SELECT cria_pessoa('teotonio');
SELECT cria_pessoa('daher');
SELECT * FROM seleciona_pessoa('bortolli');
SELECT * FROM seleciona_pessoa('teotonio');
SELECT * FROM seleciona_pessoa('daher');
SELECT cria_aluno('bortolli', 2016);
SELECT cria_aluno('teotonio', 2016);
SELECT cria_aluno('daher', 2015);
SELECT * FROM seleciona_aluno('bortolli');
SELECT * FROM seleciona_aluno('teotonio');
SELECT * FROM seleciona_aluno('daher');

SELECT atualiza_pessoa('daher', 'lucas daher');
SELECT * FROM seleciona_pessoa('daher');
SELECT * FROM seleciona_pessoa('lucas daher');

SELECT atualiza_aluno('lucas daher', 2019);
SELECT * FROM seleciona_aluno('lucas daher');

SELECT deleta_aluno('lucas daher');
SELECT * FROM seleciona_aluno('lucas daher');

SELECT * FROM deleta_pessoa('lucas daher');
SELECT * FROM seleciona_pessoa('lucas daher');

SELECT cria_pessoa('cef');
SELECT cria_professor('cef', 'teoria');
SELECT atualiza_professor('cef', 'A e EDs');
SELECT * FROM seleciona_professor('cef');
SELECT deleta_professor('cef');
SELECT * FROM seleciona_professor('cef');

SELECT cria_usuario('teotonio', 'teo', 'teo@mailismagic.com', '123456');
SELECT * FROM seleciona_usuario('teotonio');
SELECT atualiza_login_usuario('teotonio', 'pteos');
SELECT atualiza_email_usuario('teotonio', 'pteos@email.com');
SELECT atualiza_senha_usuario('teotonio', '123456', 'novasenha');
SELECT * FROM seleciona_usuario('teotonio');
--SELECT deleta_usuario('teotonio');
--SELECT * FROM seleciona_usuario('teotonio');

SELECT cria_administrador('teotonio', '01-01-2019', '31-12-2019');
SELECT * FROM seleciona_administrador('teotonio');
SELECT atualiza_administrador('teotonio', '02-02-2019', '20-10-2020');
SELECT * FROM seleciona_administrador('teotonio');
SELECT deleta_administrador('teotonio');
SELECT * FROM seleciona_administrador('teotonio');

SELECT cria_curriculo(01, 'bcc');
SELECT * FROM seleciona_curriculo(1);
SELECT atualiza_curriculo(1, 'bacharelado cc');
SELECT * FROM seleciona_curriculo(1);
SELECT deleta_curriculo(1);
SELECT * FROM seleciona_curriculo(1);

SELECT cria_perfil('adm', 'administra as parada');
SELECT * FROM seleciona_perfil('adm');
SELECT atualiza_perfil('adm', 'administra as paradas');
SELECT * FROM seleciona_perfil('adm');
SELECT deleta_perfil('adm');
SELECT * FROM seleciona_perfil('adm');

SELECT cria_servico('visualizacao', 'vizualiza as parada');
SELECT * FROM seleciona_servico('visualizacao');
SELECT atualiza_servico('visualizacao', 'vizualiza as paradas');
SELECT * FROM seleciona_servico('visualizacao');
SELECT deleta_servico('visualizacao');
SELECT * FROM seleciona_servico('visualizacao');

SELECT cria_trilha('teoria', 'so materia nabo', 8);
SELECT * FROM seleciona_trilha('teoria');
SELECT atualiza_descricao_trilha('teoria', 'so materia legal');
SELECT atualiza_disc_trilha('teoria', 6);
SELECT * FROM seleciona_trilha('teoria');
SELECT deleta_trilha('teoria');
SELECT * FROM seleciona_trilha('teoria');
