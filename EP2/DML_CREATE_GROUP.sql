DROP FUNCTION IF EXISTS cria_pessoa(varchar(100));
DROP FUNCTION IF EXISTS cria_aluno(varchar(100), integer);
DROP FUNCTION IF EXISTS cria_professor(varchar(100), varchar(50));
DROP FUNCTION IF EXISTS cria_usuario(varchar(100), varchar(20), varchar(50), varchar(64));
DROP FUNCTION IF EXISTS cria_administrador(varchar(100), date, date);
DROP FUNCTION IF EXISTS cria_curriculo(integer, varchar(50), integer);
DROP FUNCTION IF EXISTS cria_perfil(varchar(50), varchar(255));
DROP FUNCTION IF EXISTS cria_servico(varchar(50), varchar(255));
DROP FUNCTION IF EXISTS cria_trilha(varchar(50), varchar(255), integer);
DROP FUNCTION IF EXISTS cria_modulo(integer, varchar(50), varchar(255), integer);
DROP FUNCTION IF EXISTS cria_disciplina(varchar(7), varchar(100), integer, integer, varchar(50));
DROP FUNCTION IF EXISTS cria_oferecimento(integer, varchar(7), integer, integer, varchar(50), integer);
DROP FUNCTION IF EXISTS cria_rel_us_pf(integer, varchar(20));
DROP FUNCTION IF EXISTS cria_rel_pf_se(integer, integer);
DROP FUNCTION IF EXISTS cria_rel_cur_tri(integer, integer);
DROP FUNCTION IF EXISTS cria_cursa(integer, varchar(7), integer, varchar(2), integer);
DROP FUNCTION IF EXISTS cria_rel_mod_dis(integer, varchar(7), BIT);
DROP FUNCTION IF EXISTS cria_planeja(integer, varchar(7), integer);

CREATE OR REPLACE FUNCTION cria_pessoa(_nome varchar(100)) RETURNS VOID AS $$
	BEGIN
		INSERT INTO pessoa(nome) VALUES (_nome);
	END
$$ LANGUAGE plpgsql;


CREATE OR REPLACE FUNCTION cria_aluno(_nome varchar(100), _ano_ingresso integer) RETURNS VOID AS $$
	DECLARE _id integer;
	BEGIN
		_id := (SELECT id_pessoa FROM pessoa WHERE nome = _nome);
		INSERT INTO aluno(id_aluno, ano_ingresso) VALUES (_id, _ano_ingresso);
	END
$$ LANGUAGE plpgsql;


CREATE OR REPLACE FUNCTION cria_professor(_nome varchar(100), _formacao_area varchar(50)) RETURNS VOID AS $$
	DECLARE _id integer;
	BEGIN
		_id := (SELECT id_pessoa FROM pessoa WHERE nome = _nome);
		INSERT INTO professor(id_professor, formacao_area) VALUES (_id, _formacao_area);
	END
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION cria_usuario(_nome varchar(100), login varchar(20), email varchar(50), senha varchar(64)) RETURNS VOID AS $$
	DECLARE _id integer;
	BEGIN
		_id := (SELECT id_pessoa FROM pessoa WHERE nome = _nome);
		INSERT INTO usuario(id_usuario, login, email, senha) VALUES (_id, login, email, crypt(senha, gen_salt('bf')));
	END
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION cria_administrador(_nome varchar(100), _inicio date, _fim date) RETURNS VOID AS $$
	DECLARE _id integer;
	BEGIN
		_id := (SELECT id_pessoa FROM pessoa WHERE nome = _nome);
		INSERT INTO administrador(id_adm, inicio, fim) VALUES (_id, _inicio, _fim);
	END
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION cria_curriculo(_codigo integer, _nome varchar(50), _id_adm integer) RETURNS VOID AS $$
	BEGIN
		INSERT INTO curriculo(codigo, nome, id_adm) VALUES (_codigo, _nome, _id_adm);
	END
$$ LANGUAGE plpgsql;


CREATE OR REPLACE FUNCTION cria_perfil(_papel varchar(50), _descricao varchar(255)) RETURNS VOID AS $$
	BEGIN
		INSERT INTO perfil(papel, descricao) VALUES (_papel, _descricao);
	END
$$ LANGUAGE plpgsql;


CREATE OR REPLACE FUNCTION cria_servico(_tipo varchar(50), _descricao varchar(255)) RETURNS VOID AS $$
	BEGIN
		INSERT INTO servico(tipo, descricao) VALUES (_tipo, _descricao);
	END
$$ LANGUAGE plpgsql;


CREATE OR REPLACE FUNCTION cria_trilha(_nome varchar(50), _descricao varchar(255), _quant_mod integer) RETURNS VOID AS $$
	BEGIN
		INSERT INTO trilha(nome, descricao, quant_mod) VALUES (_nome, _descricao, _quant_mod);
	END
$$ LANGUAGE plpgsql;


CREATE OR REPLACE FUNCTION cria_modulo(_id_trilha integer, _nome varchar(50), _descricao varchar(255), _quant_disc integer) RETURNS VOID AS $$
	BEGIN
		INSERT INTO modulo(id_trilha, nome, descricao, quant_disc) VALUES (_id_trilha, _nome, _descricao, _quant_disc);
	END
$$ LANGUAGE plpgsql;


CREATE OR REPLACE FUNCTION cria_disciplina(_codigo varchar(7), _nome varchar(100), _creditos_aula integer, _creditos_trabalho integer, _instituto varchar(50)) RETURNS VOID AS $$
	BEGIN
		INSERT INTO disciplina(codigo, nome, creditos_aula, creditos_trabalho, instituto) VALUES (_codigo, _nome, _creditos_aula, _creditos_trabalho, _instituto);
	END
$$ LANGUAGE plpgsql;


CREATE OR REPLACE FUNCTION cria_oferecimento(_id_professor integer, _codigo varchar(7), _ano integer, _duracao integer, _instituto varchar(50), _periodo integer) RETURNS VOID AS $$
	BEGIN
		INSERT INTO oferecimento(id_professor, codigo, ano, duracao, instituto, periodo) VALUES (_id_professor, _codigo, _ano, _duracao, _instituto, _periodo);
	END
$$ LANGUAGE plpgsql;


CREATE OR REPLACE FUNCTION cria_rel_us_pf(_id_perfil integer, _login varchar(20)) RETURNS VOID AS $$
	BEGIN
		INSERT INTO rel_us_pf(login, id_perfil) VALUES (_login, _id_perfil);
	END
$$ LANGUAGE plpgsql;


CREATE OR REPLACE FUNCTION cria_cursa(_id_professor integer, _codigo varchar(7), _id_aluno integer, _status varchar(2), _media_final integer) RETURNS VOID AS $$
	BEGIN
		INSERT INTO cursa(id_professor, codigo, id_aluno, status, media_final) VALUES (_id_professor, _codigo, _id_aluno, _status, _media_final);
	END
$$ LANGUAGE plpgsql;


CREATE OR REPLACE FUNCTION cria_rel_pf_se(_id_perfil integer, _id_servico integer) RETURNS VOID AS $$
	BEGIN
		INSERT INTO rel_pf_se(id_perfil, id_servico) VALUES (_id_perfil, _id_servico);
	END
$$ LANGUAGE plpgsql;


CREATE OR REPLACE FUNCTION cria_rel_cur_tri(_codigo integer, _id_trilha integer) RETURNS VOID AS $$
	BEGIN
		INSERT INTO rel_cur_tri(codigo, id_trilha) VALUES (_codigo, _id_trilha);
	END
$$ LANGUAGE plpgsql;


CREATE OR REPLACE FUNCTION cria_rel_mod_dis(_id_modulo integer, _codigo varchar(7), _obrigatoria BIT) RETURNS VOID AS $$
	BEGIN
		INSERT INTO rel_mod_dis(id_modulo, codigo, obrigatoria) VALUES (_id_modulo, _codigo, _obrigatoria);
	END
$$ LANGUAGE plpgsql;


CREATE OR REPLACE FUNCTION cria_planeja(_id_aluno integer, _codigo varchar(7), _semestre integer) RETURNS VOID AS $$
	BEGIN
		INSERT INTO planeja(id_aluno, codigo, semestre) VALUES (_id_aluno, _codigo, _semestre);
	END
$$ LANGUAGE plpgsql;
