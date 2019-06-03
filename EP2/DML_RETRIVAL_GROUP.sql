DROP FUNCTION IF EXISTS seleciona_pessoa(varchar(100));
DROP FUNCTION IF EXISTS seleciona_aluno(varchar(100));
DROP FUNCTION IF EXISTS seleciona_professor(varchar(100));
DROP FUNCTION IF EXISTS seleciona_usuario(varchar(100));
DROP FUNCTION IF EXISTS seleciona_administrador(varchar(100));
DROP FUNCTION IF EXISTS seleciona_curriculo(integer);
DROP FUNCTION IF EXISTS seleciona_perfil(varchar(50));
DROP FUNCTION IF EXISTS seleciona_servico(varchar(50));
DROP FUNCTION IF EXISTS seleciona_trilha(varchar(50));
DROP FUNCTION IF EXISTS seleciona_modulo(varchar(50));
DROP FUNCTION IF EXISTS seleciona_disciplina(varchar(7));
DROP FUNCTION IF EXISTS seleciona_oferecimento(integer, varchar(7));
DROP FUNCTION IF EXISTS seleciona_rel_us_pf(integer, varchar(20));
DROP FUNCTION IF EXISTS seleciona_rel_pf_se(integer, integer);
DROP FUNCTION IF EXISTS seleciona_rel_cur_tri(integer, integer);
DROP FUNCTION IF EXISTS seleciona_cursa(integer, varchar(7), integer);
DROP FUNCTION IF EXISTS seleciona_rel_mod_dis(integer, varchar(7));
DROP FUNCTION IF EXISTS seleciona_planeja(integer, varchar(7));

CREATE OR REPLACE FUNCTION seleciona_pessoa(_nome varchar(100)) RETURNS TABLE(id integer, nome_pessoa varchar(100)) AS $$
	BEGIN
		RETURN QUERY SELECT * FROM pessoa WHERE nome = _nome;
	END
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION seleciona_aluno(_nome varchar(100)) RETURNS TABLE(id integer, ano_ingresso integer) AS $$
	DECLARE id integer;
	BEGIN
		id := (SELECT id_pessoa FROM pessoa WHERE nome = _nome);
		RETURN QUERY SELECT * FROM aluno WHERE id_aluno = id;
	END
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION seleciona_professor(_nome varchar(100)) RETURNS TABLE(id integer, formacao_area varchar(50)) AS $$
	DECLARE id integer;
	BEGIN
		id := (SELECT id_pessoa FROM pessoa WHERE nome = _nome);
		RETURN QUERY SELECT * FROM professor WHERE id_professor = id;
	END
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION seleciona_usuario(_nome varchar(100)) RETURNS TABLE(id integer, login varchar(20), email varchar(50), senha varchar(64)) AS $$
	DECLARE _id integer;
	BEGIN
		_id := (SELECT id_pessoa FROM pessoa WHERE nome = _nome);
		RETURN QUERY SELECT * FROM usuario WHERE id_usuario = _id;
	END
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION seleciona_administrador(_nome varchar(100)) RETURNS TABLE(id integer, inicio date, fim date) AS $$
	DECLARE _id integer;
	BEGIN
		_id := (SELECT id_pessoa FROM pessoa WHERE nome = _nome);
		RETURN QUERY SELECT * FROM administrador WHERE id_adm = _id;
	END
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION seleciona_curriculo(_codigo integer) RETURNS TABLE(cod integer, nome varchar(50), id_adm integer) AS $$
	BEGIN
		RETURN QUERY SELECT * FROM curriculo WHERE codigo=_codigo;
	END
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION seleciona_perfil(_papel varchar(50)) RETURNS TABLE(id integer, papel_ varchar(50), descricao varchar(255)) AS $$
	DECLARE _id integer;
	BEGIN
	    _id := (SELECT id_perfil FROM perfil WHERE papel = _papel);
		RETURN QUERY SELECT * FROM perfil WHERE id_perfil=_id;
	END
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION seleciona_servico(_tipo varchar(50)) RETURNS TABLE(id integer, tipo_ varchar(50), descricao varchar(255)) AS $$
	DECLARE _id integer;
	BEGIN
	    _id := (SELECT id_servico FROM servico WHERE tipo = _tipo);
		RETURN QUERY SELECT * FROM servico WHERE id_servico = _id;
	END
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION seleciona_trilha(_nome varchar(50)) RETURNS TABLE(id integer, nome_ varchar(50), descricao varchar(255), quant_mod integer) AS $$
	DECLARE _id integer;
	BEGIN
	    _id := (SELECT id_trilha FROM trilha WHERE nome = _nome);
		RETURN QUERY SELECT * FROM trilha WHERE id_trilha = _id;
	END
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION seleciona_modulo(_nome varchar(50)) RETURNS TABLE(id_mod integer, id_trilha integer, nome_ varchar(50), descricao varchar(255), quant_disc integer) AS $$
	BEGIN
	    RETURN QUERY SELECT * FROM modulo WHERE nome = _nome;
	END
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION seleciona_disciplina(_codigo varchar(7)) RETURNS TABLE(cod varchar(7), nome varchar(100), creditos_aula integer, creditos_trabalho integer, instituto varchar(50)) AS $$
	BEGIN
	    RETURN QUERY SELECT * FROM disciplina WHERE codigo = _codigo;
	END
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION seleciona_oferecimento(_id_professor integer, _codigo varchar(7)) RETURNS TABLE(id_professor_ integer, codigo_ varchar(7), ano integer, duracao integer, instituto varchar(50), periodo integer) AS $$
	BEGIN
	    RETURN QUERY SELECT * FROM oferecimento WHERE id_professor = _id_professor and codigo = _codigo;
	END
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION seleciona_rel_us_pf(_id_perfil integer, _login varchar(20)) RETURNS TABLE(login_ varchar(20), id_usuario_ integer) AS $$
	BEGIN
	    RETURN QUERY SELECT * FROM rel_us_pf WHERE id_perfil = _id_perfil and login = _login;
	END
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION seleciona_cursa(_id_professor integer, _codigo varchar(7), _id_aluno integer) RETURNS TABLE(id_professor_ integer, codigo_ varchar(7), id_aluno_ integer, status varchar(2), media_final integer) AS $$
	BEGIN
	    RETURN QUERY SELECT * FROM cursa WHERE id_professor = _id_professor and codigo = _codigo and id_aluno = _id_aluno;
	END
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION seleciona_rel_pf_se(_id_perfil integer, _id_servico integer) RETURNS TABLE(id_perfil_ integer, id_servico_ integer) AS $$
	BEGIN
	    RETURN QUERY SELECT * FROM rel_pf_se WHERE id_perfil = _id_perfil and id_servico = _id_servico;
	END
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION seleciona_rel_cur_tri(_codigo integer, _id_trilha integer) RETURNS TABLE(codigo_ integer, id_trilha_ integer) AS $$
	BEGIN
	    RETURN QUERY SELECT * FROM rel_cur_tri WHERE codigo = _codigo and id_trilha = _id_trilha;
	END
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION seleciona_rel_mod_dis(_id_modulo integer, _codigo varchar(7)) RETURNS TABLE(id_modulo_ integer, codigo_ varchar(7), obrigatoria_ BIT) AS $$
	BEGIN
	    RETURN QUERY SELECT * FROM rel_mod_dis WHERE id_modulo = _id_modulo and codigo = _codigo;
	END
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION seleciona_planeja(_id_aluno integer, _codigo varchar(7)) RETURNS TABLE(id_aluno_ integer, codigo_ varchar(7), semestre_ integer) AS $$
	BEGIN
	    RETURN QUERY SELECT * FROM planeja WHERE id_aluno = _id_aluno and codigo = _codigo;
	END
$$ LANGUAGE plpgsql;
