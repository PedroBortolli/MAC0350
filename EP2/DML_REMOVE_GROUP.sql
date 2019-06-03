DROP FUNCTION IF EXISTS deleta_pessoa(varchar(100));
DROP FUNCTION IF EXISTS deleta_aluno(varchar(100));
DROP FUNCTION IF EXISTS deleta_professor(varchar(100));
DROP FUNCTION IF EXISTS deleta_usuario(varchar(100));
DROP FUNCTION IF EXISTS deleta_administrador(varchar(100));
DROP FUNCTION IF EXISTS deleta_curriculo(integer);
DROP FUNCTION IF EXISTS deleta_perfil(varchar(50));
DROP FUNCTION IF EXISTS deleta_servico(varchar(50));
DROP FUNCTION IF EXISTS deleta_trilha(varchar(50));
DROP FUNCTION IF EXISTS deleta_modulo(varchar(50));
DROP FUNCTION IF EXISTS deleta_disciplina(varchar(7));
DROP FUNCTION IF EXISTS deleta_oferecimento(integer, varchar(7));
DROP FUNCTION IF EXISTS deleta_rel_us_pf(integer, varchar(20));
DROP FUNCTION IF EXISTS deleta_rel_pf_se(integer, integer);
DROP FUNCTION IF EXISTS deleta_rel_cur_tri(integer, integer);
DROP FUNCTION IF EXISTS deleta_cursa(integer, varchar(7), integer);
DROP FUNCTION IF EXISTS deleta_rel_mod_dis(integer, varchar(7));
DROP FUNCTION IF EXISTS deleta_planeja(integer, varchar(7));

CREATE OR REPLACE FUNCTION deleta_pessoa(_nome varchar(100)) RETURNS VOID AS $$
	BEGIN
		DELETE FROM pessoa WHERE nome = _nome;
	END
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION deleta_aluno(_nome varchar(100)) RETURNS VOID AS $$
	DECLARE id integer;
	BEGIN
		id := (SELECT id_pessoa FROM pessoa WHERE nome = _nome);
		DELETE FROM aluno WHERE id_aluno = id;
	END
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION deleta_professor(_nome varchar(100)) RETURNS VOID AS $$
	DECLARE id integer;
	BEGIN
		id := (SELECT id_pessoa FROM pessoa WHERE nome = _nome);
		DELETE FROM professor WHERE id_professor = id;
	END
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION deleta_usuario(_nome varchar(100)) RETURNS VOID AS $$
	DECLARE id integer;
	BEGIN
		id := (SELECT id_pessoa FROM pessoa WHERE nome = _nome);
		DELETE FROM usuario WHERE id_usuario = id;
	END
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION deleta_administrador(_nome varchar(100)) RETURNS VOID AS $$
	DECLARE _id integer;
	BEGIN
		_id := (SELECT id_pessoa FROM pessoa WHERE nome = _nome);
		DELETE FROM administrador WHERE id_adm = _id;
	END
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION deleta_curriculo(_codigo integer) RETURNS VOID AS $$
	BEGIN
		DELETE FROM curriculo WHERE codigo=_codigo;
	END
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION deleta_perfil(_papel varchar(50)) RETURNS VOID AS $$
	DECLARE _id integer;
	BEGIN
	    _id := (SELECT id_perfil FROM perfil WHERE papel = _papel);
		DELETE FROM perfil WHERE id_perfil=_id;
	END
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION deleta_servico(_tipo varchar(50)) RETURNS VOID AS $$
	DECLARE _id integer;
	BEGIN
	    _id := (SELECT id_servico FROM servico WHERE tipo = _tipo);
		DELETE FROM servico WHERE id_servico=_id;
	END
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION deleta_trilha(_nome varchar(50)) RETURNS VOID AS $$
	BEGIN
	    DELETE FROM trilha WHERE nome=_nome;
	END
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION deleta_modulo(_nome varchar(50)) RETURNS VOID AS $$
	BEGIN
	    DELETE FROM modulo WHERE nome=_nome;
	END
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION deleta_disciplina(_codigo varchar(7)) RETURNS VOID AS $$
	BEGIN
	    DELETE FROM disciplina WHERE codigo=_codigo;
	END
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION deleta_oferecimento(_id_professor integer, _codigo varchar(7)) RETURNS VOID AS $$
	BEGIN
	    DELETE FROM oferecimento WHERE id_professor = _id_professor and codigo = _codigo;
	END
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION deleta_rel_us_pf(_id_perfil integer, _login varchar(20)) RETURNS VOID AS $$
	BEGIN
	    DELETE FROM rel_us_pf WHERE id_perfil = _id_perfil and login = _login;
	END
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION deleta_cursa(_id_professor integer, _codigo varchar(7), _id_aluno integer) RETURNS VOID AS $$
	BEGIN
	    DELETE FROM cursa WHERE id_professor = _id_professor and codigo = _codigo and id_aluno = _id_aluno;
	END
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION deleta_rel_pf_se(_id_perfil integer, _id_servico integer) RETURNS VOID AS $$
	BEGIN
	    DELETE FROM rel_pf_se WHERE id_perfil = _id_perfil and id_servico = _id_servico;
	END
$$ LANGUAGE plpgsql;


CREATE OR REPLACE FUNCTION deleta_rel_cur_tri(_codigo integer, _id_trilha integer) RETURNS VOID AS $$
	BEGIN
	    DELETE FROM rel_cur_tri WHERE codigo = _codigo and id_trilha = _id_trilha;
	END
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION deleta_rel_mod_dis(_id_modulo integer, _codigo varchar(7)) RETURNS VOID AS $$
	BEGIN
	    DELETE FROM rel_mod_dis WHERE id_modulo = _id_modulo and codigo = _codigo;
	END
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION deleta_planeja(_id_aluno integer, _codigo varchar(7)) RETURNS VOID AS $$
	BEGIN
	    DELETE FROM planeja WHERE id_aluno = _id_aluno and codigo = _codigo;
	END
$$ LANGUAGE plpgsql;
