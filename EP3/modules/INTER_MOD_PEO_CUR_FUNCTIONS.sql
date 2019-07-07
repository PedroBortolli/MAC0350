DROP FUNCTION IF EXISTS cria_oferecimento(VARCHAR(11), varchar(7), integer, integer, varchar(50), integer);
DROP FUNCTION IF EXISTS cria_cursa(VARCHAR(11), varchar(7), integer, varchar(2), integer);
DROP FUNCTION IF EXISTS cria_planeja(integer, varchar(7), integer);
DROP FUNCTION IF EXISTS cria_cursa_curriculo(integer, integer);
DROP FUNCTION IF EXISTS deleta_oferecimento(VARCHAR(11), varchar(7));
DROP FUNCTION IF EXISTS deleta_cursa(VARCHAR(11), varchar(7), integer);
DROP FUNCTION IF EXISTS deleta_planeja(integer, varchar(7));
DROP FUNCTION IF EXISTS deleta_cursa_curriculo(integer);
DROP FUNCTION IF EXISTS seleciona_oferecimento(VARCHAR(11), varchar(7));
DROP FUNCTION IF EXISTS seleciona_cursa(VARCHAR(11), varchar(7), integer);
DROP FUNCTION IF EXISTS seleciona_planeja(integer, varchar(7));
DROP FUNCTION IF EXISTS seleciona_cursa_curriculo(integer);
DROP FUNCTION IF EXISTS atualiza_ano_oferecimento(VARCHAR(11), varchar(7), integer);
DROP FUNCTION IF EXISTS atualiza_duracao_periodo_oferecimento(VARCHAR(11), varchar(7), integer, integer);
DROP FUNCTION IF EXISTS atualiza_instituto_oferecimento(VARCHAR(11), varchar(7), varchar(50));
DROP FUNCTION IF EXISTS atualiza_status_cursa(VARCHAR(11), varchar(7), integer, varchar(2));
DROP FUNCTION IF EXISTS atualiza_media_cursa(VARCHAR(11), varchar(7), integer, integer);
DROP FUNCTION IF EXISTS atualiza_planeja(integer, varchar(7), integer);
DROP FUNCTION IF EXISTS atualiza_cursa_curriculo(integer, integer);

CREATE OR REPLACE FUNCTION cria_oferecimento(_cpf_professor VARCHAR(11), _codigo varchar(7), _ano integer, _duracao integer, _instituto varchar(50), _periodo integer) RETURNS VOID AS $$
	BEGIN
		IF (EXISTS (SELECT 1 FROM professor_foreign WHERE cpf = _cpf_professor) AND EXISTS (SELECT 1 FROM disciplina_foreign WHERE codigo = _codigo)) THEN
    		INSERT INTO oferecimento(cpf_professor, codigo, ano, duracao, instituto, periodo) VALUES (_cpf_professor, _codigo, _ano, _duracao, _instituto, _periodo);
    	END IF;
	END
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION cria_cursa(_cpf_professor VARCHAR(11), _codigo varchar(7), _nusp_aluno integer, _status varchar(2), _media_final integer) RETURNS VOID AS $$
	BEGIN
		IF EXISTS (SELECT 1 FROM professor_foreign WHERE cpf = _cpf_professor) AND EXISTS (SELECT 1 FROM disciplina_foreign WHERE codigo = _codigo)
	    AND EXISTS (SELECT 1 FROM aluno_foreign WHERE nusp = _nusp_aluno) THEN
	        INSERT INTO cursa(cpf_professor, codigo, nusp_aluno, status, media_final) VALUES (_cpf_professor, _codigo, _nusp_aluno, _status, _media_final);
	    END IF;
	END
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION cria_planeja(_nusp_aluno integer, _codigo varchar(7), _semestre integer) RETURNS VOID AS $$
	BEGIN
		IF EXISTS (SELECT 1 FROM disciplina_foreign WHERE codigo = _codigo) AND EXISTS (SELECT 1 FROM aluno_foreign WHERE nusp = _nusp_aluno) THEN
	        INSERT INTO planeja(nusp_aluno, codigo, semestre) VALUES (_nusp_aluno, _codigo, _semestre);
	    END IF;
	END
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION cria_cursa_curriculo(_nusp_aluno integer, _codigo integer) RETURNS VOID AS $$
	BEGIN
		IF EXISTS (SELECT 1 FROM curriculo_foreign WHERE codigo = _codigo) AND EXISTS (SELECT 1 FROM aluno_foreign WHERE nusp = _nusp_aluno) THEN
	        INSERT INTO cursa_curriculo(codigo, nusp) VALUES (_codigo, _nusp_aluno);
	    END IF;
	END
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION deleta_oferecimento(_cpf_professor VARCHAR(11), _codigo varchar(7)) RETURNS VOID AS $$
	BEGIN
	    DELETE FROM oferecimento WHERE cpf_professor = _cpf_professor and codigo = _codigo;
	END
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION deleta_cursa(_cpf_professor VARCHAR(11), _codigo varchar(7), _nusp_aluno integer) RETURNS VOID AS $$
	BEGIN
	    DELETE FROM cursa WHERE cpf_professor = _cpf_professor and codigo = _codigo and nusp_aluno = _nusp_aluno;
	END
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION deleta_planeja(_nusp_aluno integer, _codigo varchar(7)) RETURNS VOID AS $$
	BEGIN
	    DELETE FROM planeja WHERE nusp_aluno = _nusp_aluno and codigo = _codigo;
	END
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION deleta_cursa_curriculo(_nusp_aluno integer) RETURNS VOID AS $$
	BEGIN
		DELETE FROM cursa_curriculo WHERE nusp = _nusp_aluno;
	END
$$ LANGUAGE plpgsql;


CREATE OR REPLACE FUNCTION seleciona_oferecimento(_cpf_professor VARCHAR(11), _codigo varchar(7)) RETURNS TABLE(cpf_professor_ VARCHAR(11), codigo_ varchar(7), ano integer, duracao integer, instituto varchar(50), periodo integer) AS $$
	BEGIN
	    IF EXISTS (SELECT 1 FROM professor_foreign WHERE cpf = _cpf_professor) AND EXISTS (SELECT 1 FROM disciplina_foreign WHERE codigo = _codigo) THEN
	        RETURN QUERY SELECT * FROM oferecimento WHERE cpf_professor = _cpf_professor and codigo = _codigo;
	    END IF;
	END
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION seleciona_cursa(_cpf_professor VARCHAR(11), _codigo varchar(7), _nusp_aluno integer) RETURNS TABLE(cpf_professor_ VARCHAR(11), codigo_ varchar(7), nusp_aluno_ integer, status varchar(2), media_final integer) AS $$
	BEGIN
	    IF EXISTS (SELECT 1 FROM professor_foreign WHERE cpf = _cpf_professor) AND EXISTS (SELECT 1 FROM disciplina_foreign WHERE codigo = _codigo)
	    AND EXISTS (SELECT 1 FROM aluno_foreign WHERE nusp = _nusp_aluno) THEN
	        RETURN QUERY SELECT * FROM cursa WHERE cpf_professor = _cpf_professor and codigo = _codigo and nusp_aluno = _nusp_aluno;
	    END IF;
	END
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION seleciona_planeja(_nusp_aluno integer, _codigo varchar(7)) RETURNS TABLE(nusp_aluno_ integer, codigo_ varchar(7), semestre_ integer) AS $$
	BEGIN
	    IF EXISTS (SELECT 1 FROM disciplina_foreign WHERE codigo = _codigo) AND EXISTS (SELECT 1 FROM aluno_foreign WHERE nusp = _nusp_aluno) THEN
	        RETURN QUERY SELECT * FROM planeja WHERE nusp_aluno = _nusp_aluno and codigo = _codigo;
	    END IF;
	END
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION seleciona_cursa_curriculo(_nusp_aluno integer)
RETURNS TABLE (
	codigo integer,
	nusp integer
) AS $$
	BEGIN
	    IF EXISTS (SELECT 1 FROM aluno_foreign WHERE aluno_foreign.nusp = _nusp_aluno) THEN
	        RETURN QUERY SELECT * FROM cursa_curriculo WHERE cursa_curriculo.nusp = _nusp_aluno;
	    END IF;
	END
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION atualiza_ano_oferecimento(_cpf_professor VARCHAR(11), _codigo varchar(7), _ano integer) RETURNS VOID AS $$
	BEGIN
	    IF EXISTS (SELECT 1 FROM professor_foreign WHERE cpf = _cpf_professor) AND EXISTS (SELECT 1 FROM disciplina_foreign WHERE codigo = _codigo) THEN
	        UPDATE oferecimento
            SET ano = _ano
            WHERE cpf_professor = _cpf_professor and codigo = _codigo;
	    END IF;
	END
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION atualiza_duracao_periodo_oferecimento(_cpf_professor VARCHAR(11), _codigo varchar(7), _duracao integer, _periodo integer) RETURNS VOID AS $$
	BEGIN
	    IF EXISTS (SELECT 1 FROM professor_foreign WHERE cpf = _cpf_professor) AND EXISTS (SELECT 1 FROM disciplina_foreign WHERE codigo = _codigo) THEN
    	    UPDATE oferecimento
            SET duracao = _duracao, periodo = _periodo
            WHERE cpf_professor = _cpf_professor and codigo = _codigo;
	    END IF;
	END
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION atualiza_instituto_oferecimento(_cpf_professor VARCHAR(11), _codigo varchar(7), _instituto varchar(50)) RETURNS VOID AS $$
	BEGIN
	    IF EXISTS (SELECT 1 FROM professor_foreign WHERE cpf = _cpf_professor) AND EXISTS (SELECT 1 FROM disciplina_foreign WHERE codigo = _codigo) THEN
	        UPDATE oferecimento
            SET instituto = _instituto
            WHERE cpf_professor = _cpf_professor and codigo = _codigo;
	    END IF;
	END
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION atualiza_media_cursa(_cpf_professor VARCHAR(11), _codigo varchar(7), _nusp_aluno integer, _media integer) RETURNS VOID AS $$
	BEGIN
	    IF EXISTS (SELECT 1 FROM professor_foreign WHERE cpf = _cpf_professor) AND EXISTS (SELECT 1 FROM disciplina_foreign WHERE codigo = _codigo)
	    AND EXISTS (SELECT 1 FROM aluno_foreign WHERE nusp = _nusp_aluno) THEN
	        UPDATE cursa
	        SET media_final=_media
	        WHERE cpf_professor = _cpf_professor and codigo = _codigo and nusp_aluno = _nusp_aluno;
	    END IF;
	END
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION atualiza_status_cursa(_cpf_professor VARCHAR(11), _codigo varchar(7), _nusp_aluno integer, _status varchar(2)) RETURNS VOID AS $$
	BEGIN
	    IF EXISTS (SELECT 1 FROM professor_foreign WHERE cpf = _cpf_professor) AND EXISTS (SELECT 1 FROM disciplina_foreign WHERE codigo = _codigo)
	    AND EXISTS (SELECT 1 FROM aluno_foreign WHERE nusp = _nusp_aluno) THEN
	        UPDATE cursa
    	    SET status=_status
	        WHERE cpf_professor = _cpf_professor and codigo = _codigo and nusp_aluno = _nusp_aluno;
	    END IF;
	END
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION atualiza_planeja(_nusp_aluno integer, _codigo varchar(7), _semestre integer) RETURNS VOID AS $$
	BEGIN
		IF EXISTS (SELECT 1 FROM disciplina_foreign WHERE codigo = _codigo) AND EXISTS (SELECT 1 FROM aluno_foreign WHERE nusp = _nusp_aluno) THEN
	        UPDATE planeja
		    SET semestre = _semestre
		    WHERE nusp_aluno = _nusp_aluno and codigo = _codigo;
	    END IF;
	END
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION atualiza_cursa_curriculo(_nusp_aluno integer, _codigo integer) RETURNS VOID AS $$
	BEGIN
		IF EXISTS (SELECT 1 FROM curriculo_foreign WHERE codigo = _codigo) AND EXISTS (SELECT 1 FROM aluno_foreign WHERE nusp = _nusp_aluno) THEN
	        UPDATE cursa_curricculo
	        SET codigo = _codigo
	        WHERE nusp = _nusp_aluno;
	    END IF;
	END
$$ LANGUAGE plpgsql;
