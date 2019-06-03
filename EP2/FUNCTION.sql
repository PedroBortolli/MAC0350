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

CREATE OR REPLACE FUNCTION cria_curriculo(_codigo integer, _nome varchar(50), _id_adm integer) RETURNS VOID AS $$
	BEGIN
		INSERT INTO curriculo(codigo, nome, id_adm) VALUES (_codigo, _nome, _id_adm);
	END
$$ LANGUAGE plpgsql;


CREATE OR REPLACE FUNCTION seleciona_curriculo(_codigo integer) RETURNS TABLE(cod integer, nome varchar(50), id_adm integer) AS $$
	BEGIN
		RETURN QUERY SELECT * FROM curriculo WHERE codigo=_codigo;
	END
$$ LANGUAGE plpgsql;


CREATE OR REPLACE FUNCTION deleta_curriculo(_codigo integer) RETURNS VOID AS $$
	BEGIN
		DELETE FROM curriculo WHERE codigo=_codigo;
	END
$$ LANGUAGE plpgsql;


CREATE OR REPLACE FUNCTION atualiza_curriculo(_codigo integer, _nome varchar(50), _id_adm integer) RETURNS VOID AS $$
	BEGIN
	    UPDATE curriculo
        SET nome=_nome, id_adm=_id_adm
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


CREATE OR REPLACE FUNCTION cria_trilha(_nome varchar(50), _descricao varchar(255), _quant_mod integer) RETURNS VOID AS $$
	BEGIN
		INSERT INTO trilha(nome, descricao, quant_mod) VALUES (_nome, _descricao, _quant_mod);
	END
$$ LANGUAGE plpgsql;


CREATE OR REPLACE FUNCTION seleciona_trilha(_nome varchar(50)) RETURNS TABLE(id integer, nome_ varchar(50), descricao varchar(255), quant_mod integer) AS $$
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


CREATE OR REPLACE FUNCTION atualiza_disc_trilha(_nome varchar(50), _quant_mod integer) RETURNS VOID AS $$
	BEGIN
	    UPDATE trilha
        SET quant_mod=_quant_mod
        WHERE nome=_nome;
	END
$$ LANGUAGE plpgsql;


CREATE OR REPLACE FUNCTION cria_modulo(_id_trilha integer, _nome varchar(50), _descricao varchar(255), _quant_disc integer) RETURNS VOID AS $$
	BEGIN
		INSERT INTO modulo(id_trilha, nome, descricao, quant_disc) VALUES (_id_trilha, _nome, _descricao, _quant_disc);
	END
$$ LANGUAGE plpgsql;


CREATE OR REPLACE FUNCTION seleciona_modulo(_nome varchar(50)) RETURNS TABLE(id_mod integer, id_trilha integer, nome_ varchar(50), descricao varchar(255), quant_disc integer) AS $$
	BEGIN
	    RETURN QUERY SELECT * FROM modulo WHERE nome = _nome;
	END
$$ LANGUAGE plpgsql;


CREATE OR REPLACE FUNCTION deleta_modulo(_nome varchar(50)) RETURNS VOID AS $$
	BEGIN
	    DELETE FROM modulo WHERE nome=_nome;
	END
$$ LANGUAGE plpgsql;


CREATE OR REPLACE FUNCTION atualiza_descricao_modulo(_nome varchar(50), _descricao varchar(255)) RETURNS VOID AS $$
	BEGIN
	    UPDATE modulo
        SET descricao=_descricao
        WHERE nome=_nome;
	END
$$ LANGUAGE plpgsql;


CREATE OR REPLACE FUNCTION atualiza_disc_modulo(_nome varchar(50), _quant_disc integer) RETURNS VOID AS $$
	BEGIN
	    UPDATE modulo
        SET quant_disc=_quant_disc
        WHERE nome=_nome;
	END
$$ LANGUAGE plpgsql;


CREATE OR REPLACE FUNCTION cria_disciplina(_codigo varchar(7), _nome varchar(100), _creditos_aula integer, _creditos_trabalho integer, _instituto varchar(50)) RETURNS VOID AS $$
	BEGIN
		INSERT INTO disciplina(codigo, nome, creditos_aula, creditos_trabalho, instituto) VALUES (_codigo, _nome, _creditos_aula, _creditos_trabalho, _instituto);
	END
$$ LANGUAGE plpgsql;


CREATE OR REPLACE FUNCTION seleciona_disciplina(_codigo varchar(7)) RETURNS TABLE(cod varchar(7), nome varchar(100), creditos_aula integer, creditos_trabalho integer, instituto varchar(50)) AS $$
	BEGIN
	    RETURN QUERY SELECT * FROM disciplina WHERE codigo = _codigo;
	END
$$ LANGUAGE plpgsql;


CREATE OR REPLACE FUNCTION deleta_disciplina(_codigo varchar(7)) RETURNS VOID AS $$
	BEGIN
	    DELETE FROM disciplina WHERE codigo=_codigo;
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


CREATE OR REPLACE FUNCTION cria_oferecimento(_id_professor integer, _codigo varchar(7), _ano integer, _duracao integer, _instituto varchar(50), _periodo integer) RETURNS VOID AS $$
	BEGIN
		INSERT INTO oferecimento(id_professor, codigo, ano, duracao, instituto, periodo) VALUES (_id_professor, _codigo, _ano, _duracao, _instituto, _periodo);
	END
$$ LANGUAGE plpgsql;


CREATE OR REPLACE FUNCTION seleciona_oferecimento(_id_professor integer, _codigo varchar(7)) RETURNS TABLE(id_professor_ integer, codigo_ varchar(7), ano integer, duracao integer, instituto varchar(50), periodo integer) AS $$
	BEGIN
	    RETURN QUERY SELECT * FROM oferecimento WHERE id_professor = _id_professor and codigo = _codigo;
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


CREATE OR REPLACE FUNCTION deleta_oferecimento(_id_professor integer, _codigo varchar(7)) RETURNS VOID AS $$
	BEGIN
	    DELETE FROM oferecimento WHERE id_professor = _id_professor and codigo = _codigo;
	END
$$ LANGUAGE plpgsql;


CREATE OR REPLACE FUNCTION cria_rel_us_pf(_id_perfil integer, _login varchar(20)) RETURNS VOID AS $$
	BEGIN
		INSERT INTO rel_us_pf(login, id_perfil) VALUES (_login, _id_perfil);
	END
$$ LANGUAGE plpgsql;


CREATE OR REPLACE FUNCTION seleciona_rel_us_pf(_id_perfil integer, _login varchar(20)) RETURNS TABLE(login_ varchar(20), id_usuario_ integer) AS $$
	BEGIN
	    RETURN QUERY SELECT * FROM rel_us_pf WHERE id_perfil = _id_perfil and login = _login;
	END
$$ LANGUAGE plpgsql;


CREATE OR REPLACE FUNCTION deleta_rel_us_pf(_id_perfil integer, _login varchar(20)) RETURNS VOID AS $$
	BEGIN
	    DELETE FROM rel_us_pf WHERE id_perfil = _id_perfil and login = _login;
	END
$$ LANGUAGE plpgsql;


CREATE OR REPLACE FUNCTION cria_cursa(_id_professor integer, _codigo varchar(7), _id_aluno integer, _status varchar(2), _media_final integer) RETURNS VOID AS $$
	BEGIN
		INSERT INTO cursa(id_professor, codigo, id_aluno, status, media_final) VALUES (_id_professor, _codigo, _id_aluno, _status, _media_final);
	END
$$ LANGUAGE plpgsql;


CREATE OR REPLACE FUNCTION seleciona_cursa(_id_professor integer, _codigo varchar(7), _id_aluno integer) RETURNS TABLE(id_professor_ integer, codigo_ varchar(7), id_aluno_ integer, status varchar(2), media_final integer) AS $$
	BEGIN
	    RETURN QUERY SELECT * FROM cursa WHERE id_professor = _id_professor and codigo = _codigo and id_aluno = _id_aluno;
	END
$$ LANGUAGE plpgsql;


CREATE OR REPLACE FUNCTION deleta_cursa(_id_professor integer, _codigo varchar(7), _id_aluno integer) RETURNS VOID AS $$
	BEGIN
	    DELETE FROM cursa WHERE id_professor = _id_professor and codigo = _codigo and id_aluno = _id_aluno;
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


CREATE OR REPLACE FUNCTION cria_rel_pf_se(_id_perfil integer, _id_servico integer) RETURNS VOID AS $$
	BEGIN
		INSERT INTO rel_pf_se(id_perfil, id_servico) VALUES (_id_perfil, _id_servico);
	END
$$ LANGUAGE plpgsql;


CREATE OR REPLACE FUNCTION seleciona_rel_pf_se(_id_perfil integer, _id_servico integer) RETURNS TABLE(id_perfil_ integer, id_servico_ integer) AS $$
	BEGIN
	    RETURN QUERY SELECT * FROM rel_pf_se WHERE id_perfil = _id_perfil and id_servico = _id_servico;
	END
$$ LANGUAGE plpgsql;


CREATE OR REPLACE FUNCTION deleta_rel_pf_se(_id_perfil integer, _id_servico integer) RETURNS VOID AS $$
	BEGIN
	    DELETE FROM rel_pf_se WHERE id_perfil = _id_perfil and id_servico = _id_servico;
	END
$$ LANGUAGE plpgsql;


CREATE OR REPLACE FUNCTION cria_rel_cur_tri(_codigo integer, _id_trilha integer) RETURNS VOID AS $$
	BEGIN
		INSERT INTO rel_cur_tri(codigo, id_trilha) VALUES (_codigo, _id_trilha);
	END
$$ LANGUAGE plpgsql;


CREATE OR REPLACE FUNCTION seleciona_rel_cur_tri(_codigo integer, _id_trilha integer) RETURNS TABLE(codigo_ integer, id_trilha_ integer) AS $$
	BEGIN
	    RETURN QUERY SELECT * FROM rel_cur_tri WHERE codigo = _codigo and id_trilha = _id_trilha;
	END
$$ LANGUAGE plpgsql;


CREATE OR REPLACE FUNCTION deleta_rel_cur_tri(_codigo integer, _id_trilha integer) RETURNS VOID AS $$
	BEGIN
	    DELETE FROM rel_cur_tri WHERE codigo = _codigo and id_trilha = _id_trilha;
	END
$$ LANGUAGE plpgsql;


CREATE OR REPLACE FUNCTION cria_rel_mod_dis(_id_modulo integer, _codigo varchar(7), _obrigatoria BIT) RETURNS VOID AS $$
	BEGIN
		INSERT INTO rel_mod_dis(id_modulo, codigo, obrigatoria) VALUES (_id_modulo, _codigo, _obrigatoria);
	END
$$ LANGUAGE plpgsql;


CREATE OR REPLACE FUNCTION seleciona_rel_mod_dis(_id_modulo integer, _codigo varchar(7)) RETURNS TABLE(id_modulo_ integer, codigo_ varchar(7), obrigatoria_ BIT) AS $$
	BEGIN
	    RETURN QUERY SELECT * FROM rel_mod_dis WHERE id_modulo = _id_modulo and codigo = _codigo;
	END
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION deleta_rel_mod_dis(_id_modulo integer, _codigo varchar(7)) RETURNS VOID AS $$
	BEGIN
	    DELETE FROM rel_mod_dis WHERE id_modulo = _id_modulo and codigo = _codigo;
	END
$$ LANGUAGE plpgsql;


CREATE OR REPLACE FUNCTION atualiza_rel_mod_dis(_id_modulo integer, _codigo varchar(7), _obrigatoria BIT) RETURNS VOID AS $$
	BEGIN
		UPDATE rel_mod_dis
		SET obrigatoria = _obrigatoria
		WHERE id_modulo = _id_modulo and codigo = _codigo;
	END
$$ LANGUAGE plpgsql;


CREATE OR REPLACE FUNCTION cria_planeja(_id_aluno integer, _codigo varchar(7), _semestre integer) RETURNS VOID AS $$
	BEGIN
		INSERT INTO planeja(id_aluno, codigo, semestre) VALUES (_id_aluno, _codigo, _semestre);
	END
$$ LANGUAGE plpgsql;


CREATE OR REPLACE FUNCTION seleciona_planeja(_id_aluno integer, _codigo varchar(7)) RETURNS TABLE(id_aluno_ integer, codigo_ varchar(7), semestre_ integer) AS $$
	BEGIN
	    RETURN QUERY SELECT * FROM planeja WHERE id_aluno = _id_aluno and codigo = _codigo;
	END
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION deleta_planeja(_id_aluno integer, _codigo varchar(7)) RETURNS VOID AS $$
	BEGIN
	    DELETE FROM planeja WHERE id_aluno = _id_aluno and codigo = _codigo;
	END
$$ LANGUAGE plpgsql;


CREATE OR REPLACE FUNCTION atualiza_planeja(_id_aluno integer, _codigo varchar(7), _semestre integer) RETURNS VOID AS $$
	BEGIN
		UPDATE planeja
		SET semestre = _semestre
		WHERE id_aluno = _id_aluno and codigo = _codigo;
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
--SELECT deleta_professor('cef');
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
SELECT cria_administrador('teotonio', '01-01-2019', '31-12-2019');

SELECT cria_curriculo(1, 'bcc', 2);
SELECT * FROM seleciona_curriculo(1);
SELECT atualiza_curriculo(1, 'bacharelado cc', 2);
SELECT * FROM seleciona_curriculo(1);
--SELECT deleta_curriculo(1);
--SELECT * FROM seleciona_curriculo(1);

SELECT cria_perfil('adm', 'administra as parada');
SELECT * FROM seleciona_perfil('adm');
SELECT atualiza_perfil('adm', 'administra as paradas');
SELECT * FROM seleciona_perfil('adm');
--SELECT deleta_perfil('adm');
--SELECT * FROM seleciona_perfil('adm');

SELECT cria_servico('visualizacao', 'vizualiza as parada');
SELECT * FROM seleciona_servico('visualizacao');
SELECT atualiza_servico('visualizacao', 'vizualiza as paradas');
SELECT * FROM seleciona_servico('visualizacao');
--SELECT deleta_servico('visualizacao');
--SELECT * FROM seleciona_servico('visualizacao');

SELECT cria_trilha('teoria', 'so materia nabo', 8);
SELECT * FROM seleciona_trilha('teoria');
SELECT atualiza_descricao_trilha('teoria', 'so materia legal');
SELECT atualiza_disc_trilha('teoria', 6);
SELECT * FROM seleciona_trilha('teoria');
--SELECT deleta_trilha('teoria');
--SELECT * FROM seleciona_trilha('teoria');

SELECT cria_modulo(1, 'mat dis', 'so materia nabo', 8);
SELECT * FROM seleciona_modulo('mat dis');
SELECT atualiza_descricao_modulo('mat dis', 'so materia legal');
SELECT atualiza_disc_modulo('mat dis', 6);
SELECT * FROM seleciona_modulo('mat dis');
--SELECT deleta_modulo('mat dis');
--SELECT * FROM seleciona_modulo('mat dis');

SELECT cria_disciplina('MAC0666', 'topicos em satanas', 6, 6, 'dcc');
SELECT * FROM seleciona_disciplina('MAC0666');
SELECT atualiza_nome_disciplina('MAC0666', 'topicos no mochila de crinca');
SELECT atualiza_creds_aula_disciplina('MAC0666', 8);
SELECT atualiza_creds_trabalho_disciplina('MAC0666', 4);
SELECT atualiza_instituto_disciplina('MAC0666', 'depart comp');
SELECT * FROM seleciona_disciplina('MAC0666');
--SELECT deleta_disciplina('MAC0666');
SELECT * FROM seleciona_disciplina('MAC0666');

SELECT cria_oferecimento(4, 'MAC0666', 2019, 6, 'IME', 2);
SELECT * FROM seleciona_oferecimento(4, 'MAC0666');
SELECT atualiza_ano_oferecimento(4, 'MAC0666', 2018);
SELECT atualiza_duracao_periodo_oferecimento(4, 'MAC0666', 3, 4);
SELECT atualiza_instituto_oferecimento(4, 'MAC0666', 'FEA');
SELECT * FROM seleciona_oferecimento(4, 'MAC0666');
--SELECT deleta_oferecimento(4, 'MAC0666');
--SELECT * FROM seleciona_oferecimento(4, 'MAC0666');

SELECT cria_rel_us_pf(1, 'pteos');
SELECT * FROM seleciona_rel_us_pf(1, 'pteos');
SELECT deleta_rel_us_pf(1, 'pteos');
SELECT * FROM seleciona_rel_us_pf(1, 'pteos');

SELECT cria_cursa(4, 'MAC0666', 2, 'MA', 49);
SELECT * FROM seleciona_cursa(4, 'MAC0666', 2);
SELECT atualiza_media_cursa(4, 'MAC0666', 2, 50);
SELECT atualiza_status_cursa(4, 'MAC0666', 2, 'A');
SELECT * FROM seleciona_cursa(4, 'MAC0666', 2);
SELECT deleta_cursa(4, 'MAC0666', 2);
SELECT * FROM seleciona_cursa(4, 'MAC0666', 2);

SELECT cria_rel_pf_se(1, 1);
SELECT * FROM seleciona_rel_pf_se(1, 1);
SELECT deleta_rel_pf_se(1, 1);
SELECT * FROM seleciona_rel_pf_se(1, 1);

SELECT cria_planeja(2, 'MAC0666', 5);
SELECT * FROM seleciona_planeja(2, 'MAC0666');
SELECT atualiza_planeja(2, 'MAC0666', 7);
SELECT * FROM seleciona_planeja(2, 'MAC0666');
SELECT deleta_planeja(2, 'MAC0666');
SELECT * FROM seleciona_planeja(2, 'MAC0666');

SELECT cria_rel_cur_tri(1, 1);
SELECT * FROM seleciona_rel_cur_tri(1, 1);
SELECT deleta_rel_cur_tri(1, 1);
SELECT * FROM seleciona_rel_cur_tri(1, 1);

SELECT cria_rel_mod_dis(1, 'MAC0666', '1');
SELECT * FROM seleciona_rel_mod_dis(1, 'MAC0666');
SELECT atualiza_rel_mod_dis(1, 'MAC0666', '0');
SELECT * FROM seleciona_rel_mod_dis(1, 'MAC0666');
SELECT deleta_rel_mod_dis(1, 'MAC0666');
SELECT * FROM seleciona_rel_mod_dis(1, 'MAC0666');
