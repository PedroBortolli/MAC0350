DROP FUNCTION IF EXISTS cria_oferecimento(integer, varchar(7), integer, integer, varchar(50), integer);
DROP FUNCTION IF EXISTS cria_cursa(integer, varchar(7), integer, varchar(2), integer);
DROP FUNCTION IF EXISTS cria_planeja(integer, varchar(7), integer);
DROP FUNCTION IF EXISTS deleta_oferecimento(integer, varchar(7));
DROP FUNCTION IF EXISTS deleta_cursa(integer, varchar(7), integer);
DROP FUNCTION IF EXISTS deleta_planeja(integer, varchar(7));
DROP FUNCTION IF EXISTS seleciona_oferecimento(integer, varchar(7));
DROP FUNCTION IF EXISTS seleciona_cursa(integer, varchar(7), integer);
DROP FUNCTION IF EXISTS seleciona_planeja(integer, varchar(7));
DROP FUNCTION IF EXISTS atualiza_ano_oferecimento(integer, varchar(7), integer);
DROP FUNCTION IF EXISTS atualiza_duracao_periodo_oferecimento(integer, varchar(7), integer, integer);
DROP FUNCTION IF EXISTS atualiza_instituto_oferecimento(integer, varchar(7), varchar(50));
DROP FUNCTION IF EXISTS atualiza_status_cursa(integer, varchar(7), integer, varchar(2));
DROP FUNCTION IF EXISTS atualiza_media_cursa(integer, varchar(7), integer, integer);
DROP FUNCTION IF EXISTS atualiza_planeja(integer, varchar(7), integer);

CREATE OR REPLACE FUNCTION cria_oferecimento(_id_professor integer, _codigo varchar(7), _ano integer, _duracao integer, _instituto varchar(50), _periodo integer) RETURNS VOID AS $$
	BEGIN
		IF (EXISTS (SELECT 1 FROM professor_foreign WHERE id_professor = _id_professor) AND EXISTS (SELECT 1 FROM disciplina_foreign WHERE codigo = _codigo)) THEN
    		INSERT INTO oferecimento(id_professor, codigo, ano, duracao, instituto, periodo) VALUES (_id_professor, _codigo, _ano, _duracao, _instituto, _periodo);
    	END IF;
	END
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION cria_cursa(_id_professor integer, _codigo varchar(7), _id_aluno integer, _status varchar(2), _media_final integer) RETURNS VOID AS $$
	BEGIN
		IF EXISTS (SELECT 1 FROM professor_foreign WHERE id_professor = _id_professor) AND EXISTS (SELECT 1 FROM disciplina_foreign WHERE codigo = _codigo)
	    AND EXISTS (SELECT 1 FROM aluno_foreign WHERE id_aluno = _id_aluno) THEN
	        INSERT INTO cursa(id_professor, codigo, id_aluno, status, media_final) VALUES (_id_professor, _codigo, _id_aluno, _status, _media_final);
	    END IF;
	END
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION cria_planeja(_id_aluno integer, _codigo varchar(7), _semestre integer) RETURNS VOID AS $$
	BEGIN
		IF EXISTS (SELECT 1 FROM disciplina_foreign WHERE codigo = _codigo) AND EXISTS (SELECT 1 FROM aluno_foreign WHERE id_aluno = _id_aluno) THEN
	        INSERT INTO planeja(id_aluno, codigo, semestre) VALUES (_id_aluno, _codigo, _semestre);
	    END IF;
	END
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION deleta_oferecimento(_id_professor integer, _codigo varchar(7)) RETURNS VOID AS $$
	BEGIN
	    DELETE FROM oferecimento WHERE id_professor = _id_professor and codigo = _codigo;
	END
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION deleta_cursa(_id_professor integer, _codigo varchar(7), _id_aluno integer) RETURNS VOID AS $$
	BEGIN
	    DELETE FROM cursa WHERE id_professor = _id_professor and codigo = _codigo and id_aluno = _id_aluno;
	END
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION deleta_planeja(_id_aluno integer, _codigo varchar(7)) RETURNS VOID AS $$
	BEGIN
	    DELETE FROM planeja WHERE id_aluno = _id_aluno and codigo = _codigo;
	END
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION seleciona_oferecimento(_id_professor integer, _codigo varchar(7)) RETURNS TABLE(id_professor_ integer, codigo_ varchar(7), ano integer, duracao integer, instituto varchar(50), periodo integer) AS $$
	BEGIN
	    IF EXISTS (SELECT 1 FROM professor_foreign WHERE id_professor = _id_professor) AND EXISTS (SELECT 1 FROM disciplina_foreign WHERE codigo = _codigo) THEN
	        RETURN QUERY SELECT * FROM oferecimento WHERE id_professor = _id_professor and codigo = _codigo;
	    END IF;
	END
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION seleciona_cursa(_id_professor integer, _codigo varchar(7), _id_aluno integer) RETURNS TABLE(id_professor_ integer, codigo_ varchar(7), id_aluno_ integer, status varchar(2), media_final integer) AS $$
	BEGIN
	    IF EXISTS (SELECT 1 FROM professor_foreign WHERE id_professor = _id_professor) AND EXISTS (SELECT 1 FROM disciplina_foreign WHERE codigo = _codigo)
	    AND EXISTS (SELECT 1 FROM aluno_foreign WHERE id_aluno = _id_aluno) THEN
	        RETURN QUERY SELECT * FROM cursa WHERE id_professor = _id_professor and codigo = _codigo and id_aluno = _id_aluno;
	    END IF;
	END
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION seleciona_planeja(_id_aluno integer, _codigo varchar(7)) RETURNS TABLE(id_aluno_ integer, codigo_ varchar(7), semestre_ integer) AS $$
	BEGIN
	    IF EXISTS (SELECT 1 FROM disciplina_foreign WHERE codigo = _codigo) AND EXISTS (SELECT 1 FROM aluno_foreign WHERE id_aluno = _id_aluno) THEN
	        RETURN QUERY SELECT * FROM planeja WHERE id_aluno = _id_aluno and codigo = _codigo;
	    END IF;
	END
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION atualiza_ano_oferecimento(_id_professor integer, _codigo varchar(7), _ano integer) RETURNS VOID AS $$
	BEGIN
	    IF EXISTS (SELECT 1 FROM professor_foreign WHERE id_professor = _id_professor) AND EXISTS (SELECT 1 FROM disciplina_foreign WHERE codigo = _codigo) THEN
	        UPDATE oferecimento
            SET ano = _ano
            WHERE id_professor = _id_professor and codigo = _codigo;
	    END IF;
	END
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION atualiza_duracao_periodo_oferecimento(_id_professor integer, _codigo varchar(7), _duracao integer, _periodo integer) RETURNS VOID AS $$
	BEGIN
	    IF EXISTS (SELECT 1 FROM professor_foreign WHERE id_professor = _id_professor) AND EXISTS (SELECT 1 FROM disciplina_foreign WHERE codigo = _codigo) THEN
    	    UPDATE oferecimento
            SET duracao = _duracao, periodo = _periodo
            WHERE id_professor = _id_professor and codigo = _codigo;
	    END IF;
	END
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION atualiza_instituto_oferecimento(_id_professor integer, _codigo varchar(7), _instituto varchar(50)) RETURNS VOID AS $$
	BEGIN
	    IF EXISTS (SELECT 1 FROM professor_foreign WHERE id_professor = _id_professor) AND EXISTS (SELECT 1 FROM disciplina_foreign WHERE codigo = _codigo) THEN
	        UPDATE oferecimento
            SET instituto = _instituto
            WHERE id_professor = _id_professor and codigo = _codigo;
	    END IF;
	END
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION atualiza_media_cursa(_id_professor integer, _codigo varchar(7), _id_aluno integer, _media integer) RETURNS VOID AS $$
	BEGIN
	    IF EXISTS (SELECT 1 FROM professor_foreign WHERE id_professor = _id_professor) AND EXISTS (SELECT 1 FROM disciplina_foreign WHERE codigo = _codigo)
	    AND EXISTS (SELECT 1 FROM aluno_foreign WHERE id_aluno = _id_aluno) THEN
	        UPDATE cursa
	        SET media_final=_media
	        WHERE id_professor = _id_professor and codigo = _codigo and id_aluno = _id_aluno;
	    END IF;
	END
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION atualiza_status_cursa(_id_professor integer, _codigo varchar(7), _id_aluno integer, _status varchar(2)) RETURNS VOID AS $$
	BEGIN
	    IF EXISTS (SELECT 1 FROM professor_foreign WHERE id_professor = _id_professor) AND EXISTS (SELECT 1 FROM disciplina_foreign WHERE codigo = _codigo)
	    AND EXISTS (SELECT 1 FROM aluno_foreign WHERE id_aluno = _id_aluno) THEN
	        UPDATE cursa
    	    SET status=_status
	        WHERE id_professor = _id_professor and codigo = _codigo and id_aluno = _id_aluno;
	    END IF;
	END
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION atualiza_planeja(_id_aluno integer, _codigo varchar(7), _semestre integer) RETURNS VOID AS $$
	BEGIN
		IF EXISTS (SELECT 1 FROM disciplina_foreign WHERE codigo = _codigo) AND EXISTS (SELECT 1 FROM aluno_foreign WHERE id_aluno = _id_aluno) THEN
	        UPDATE planeja
		    SET semestre = _semestre
		    WHERE id_aluno = _id_aluno and codigo = _codigo;
	    END IF;
	END
$$ LANGUAGE plpgsql;