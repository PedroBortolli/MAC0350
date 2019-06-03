DROP FUNCTION IF EXISTS atualiza_pessoa(varchar(100), varchar(100));
DROP FUNCTION IF EXISTS atualiza_aluno(varchar(100), integer);
DROP FUNCTION IF EXISTS atualiza_professor(varchar(100), varchar(50));
DROP FUNCTION IF EXISTS atualiza_login_usuario( varchar(100), varchar(20));
DROP FUNCTION IF EXISTS atualiza_email_usuario(varchar(100), varchar(50));
DROP FUNCTION IF EXISTS atualiza_senha_usuario(varchar(100), varchar(50), varchar(50));
DROP FUNCTION IF EXISTS atualiza_administrador(varchar(100), date, date);
DROP FUNCTION IF EXISTS atualiza_curriculo(integer, varchar(50), int);
DROP FUNCTION IF EXISTS atualiza_perfil(varchar(50), varchar(255));
DROP FUNCTION IF EXISTS atualiza_servico(varchar(50), varchar(255));
DROP FUNCTION IF EXISTS atualiza_disc_trilha(varchar(50), integer);
DROP FUNCTION IF EXISTS atualiza_descricao_trilha(varchar(50), varchar(255));
DROP FUNCTION IF EXISTS atualiza_disc_modulo(varchar(50), integer);
DROP FUNCTION IF EXISTS atualiza_descricao_modulo(varchar(50), varchar(255));
DROP FUNCTION IF EXISTS atualiza_instituto_disciplina(varchar(7), varchar(50));
DROP FUNCTION IF EXISTS atualiza_creds_trabalho_disciplina(varchar(7), integer);
DROP FUNCTION IF EXISTS atualiza_creds_aula_disciplina(varchar(7), integer);
DROP FUNCTION IF EXISTS atualiza_nome_disciplina(varchar(7), varchar(100));
DROP FUNCTION IF EXISTS atualiza_ano_oferecimento(integer, varchar(7), integer);
DROP FUNCTION IF EXISTS atualiza_duracao_periodo_oferecimento(integer, varchar(7), integer, integer);
DROP FUNCTION IF EXISTS atualiza_instituto_oferecimento(integer, varchar(7), varchar(50));
DROP FUNCTION IF EXISTS atualiza_status_cursa(integer, varchar(7), integer, varchar(2));
DROP FUNCTION IF EXISTS atualiza_media_cursa(integer, varchar(7), integer, integer);
DROP FUNCTION IF EXISTS atualiza_rel_mod_dis(integer, varchar(7), BIT);
DROP FUNCTION IF EXISTS atualiza_planeja(integer, varchar(7), integer);

CREATE OR REPLACE FUNCTION atualiza_pessoa(_nome varchar(100), _novo_nome varchar(100)) RETURNS VOID AS $$
	DECLARE _id integer;
	BEGIN
	    _id := (SELECT id_pessoa FROM pessoa WHERE nome = _nome);
		UPDATE pessoa
        SET nome=_novo_nome
        WHERE id_pessoa=_id;
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

CREATE OR REPLACE FUNCTION atualiza_professor(_nome varchar(100), _formacao_area varchar(50)) RETURNS VOID AS $$
	DECLARE _id integer;
	BEGIN
		_id := (SELECT id_pessoa FROM pessoa WHERE nome = _nome);
		UPDATE professor
        SET formacao_area=_formacao_area
        WHERE id_professor=_id;
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

CREATE OR REPLACE FUNCTION atualiza_administrador(_nome varchar(100), _inicio date, _fim date) RETURNS VOID AS $$
	DECLARE _id integer;
	BEGIN
	    _id := (SELECT id_pessoa FROM pessoa WHERE nome = _nome);
		UPDATE administrador
        SET inicio=_inicio, fim=_fim
        WHERE id_adm=_id;
	END
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION atualiza_curriculo(_codigo integer, _nome varchar(50), _id_adm integer) RETURNS VOID AS $$
	BEGIN
	    UPDATE curriculo
        SET nome=_nome, id_adm=_id_adm
        WHERE codigo=_codigo;
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

CREATE OR REPLACE FUNCTION atualiza_servico(_tipo varchar(50), _descricao varchar(255)) RETURNS VOID AS $$
	DECLARE _id integer;
	BEGIN
	    _id := (SELECT id_servico FROM servico WHERE tipo = _tipo);
	    UPDATE servico
        SET descricao=_descricao
        WHERE id_servico=_id;
	END
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION atualiza_descricao_trilha(_nome varchar(50), _descricao varchar(255)) RETURNS VOID AS $$
	BEGIN
	    UPDATE trilha
        SET descricao=_descricao
        WHERE nome=_nome;
	END
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION atualiza_disc_trilha(_nome varchar(50), _quant_mod integer) RETURNS VOID AS $$
	BEGIN
	    UPDATE trilha
        SET quant_mod=_quant_mod
        WHERE nome=_nome;
	END
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION atualiza_descricao_modulo(_nome varchar(50), _descricao varchar(255)) RETURNS VOID AS $$
	BEGIN
	    UPDATE modulo
        SET descricao=_descricao
        WHERE nome=_nome;
	END
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION atualiza_nome_disciplina(_codigo varchar(7), _nome varchar(100)) RETURNS VOID AS $$
	BEGIN
	    UPDATE disciplina
        SET nome=_nome
        WHERE codigo=_codigo;
	END
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION atualiza_creds_aula_disciplina(_codigo varchar(7), _creditos_aula integer) RETURNS VOID AS $$
	BEGIN
	    UPDATE disciplina
        SET creditos_aula=_creditos_aula
        WHERE codigo=_codigo;
	END
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION atualiza_creds_trabalho_disciplina(_codigo varchar(7), _creditos_trabalho integer) RETURNS VOID AS $$
	BEGIN
	    UPDATE disciplina
        SET creditos_trabalho = _creditos_trabalho
        WHERE codigo=_codigo;
	END
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION atualiza_instituto_disciplina(_codigo varchar(7), _instituto varchar(50)) RETURNS VOID AS $$
	BEGIN
	    UPDATE disciplina
        SET instituto=_instituto
        WHERE codigo=_codigo;
	END
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION atualiza_ano_oferecimento(_id_professor integer, _codigo varchar(7), _ano integer) RETURNS VOID AS $$
	BEGIN
	    UPDATE oferecimento
        SET ano = _ano
        WHERE id_professor = _id_professor and codigo = _codigo;
	END
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION atualiza_duracao_periodo_oferecimento(_id_professor integer, _codigo varchar(7), _duracao integer, _periodo integer) RETURNS VOID AS $$
	BEGIN
	    UPDATE oferecimento
        SET duracao = _duracao, periodo = _periodo
        WHERE id_professor = _id_professor and codigo = _codigo;
	END
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION atualiza_instituto_oferecimento(_id_professor integer, _codigo varchar(7), _instituto varchar(50)) RETURNS VOID AS $$
	BEGIN
	    UPDATE oferecimento
        SET instituto = _instituto
        WHERE id_professor = _id_professor and codigo = _codigo;
	END
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION atualiza_media_cursa(_id_professor integer, _codigo varchar(7), _id_aluno integer, _media integer) RETURNS VOID AS $$
	BEGIN
	    UPDATE cursa
	    SET media_final=_media
	    WHERE id_professor = _id_professor and codigo = _codigo and id_aluno = _id_aluno;
	END
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION atualiza_status_cursa(_id_professor integer, _codigo varchar(7), _id_aluno integer, _status varchar(2)) RETURNS VOID AS $$
	BEGIN
	    UPDATE cursa
	    SET status=_status
	    WHERE id_professor = _id_professor and codigo = _codigo and id_aluno = _id_aluno;
	END
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION atualiza_rel_mod_dis(_id_modulo integer, _codigo varchar(7), _obrigatoria BIT) RETURNS VOID AS $$
	BEGIN
		UPDATE rel_mod_dis
		SET obrigatoria = _obrigatoria
		WHERE id_modulo = _id_modulo and codigo = _codigo;
	END
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION atualiza_planeja(_id_aluno integer, _codigo varchar(7), _semestre integer) RETURNS VOID AS $$
	BEGIN
		UPDATE planeja
		SET semestre = _semestre
		WHERE id_aluno = _id_aluno and codigo = _codigo;
	END
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION atualiza_disc_modulo(_nome varchar(50), _quant_disc integer) RETURNS VOID AS $$
	BEGIN
	    UPDATE modulo
        SET quant_disc=_quant_disc
        WHERE nome=_nome;
	END
$$ LANGUAGE plpgsql;
