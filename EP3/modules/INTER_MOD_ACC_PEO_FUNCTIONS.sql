DROP FUNCTION IF EXISTS cria_rel_us_pf(integer, varchar(20));
DROP FUNCTION IF EXISTS deleta_rel_us_pf(integer, varchar(20));
DROP FUNCTION IF EXISTS seleciona_rel_us_pf(integer, varchar(20));

CREATE OR REPLACE FUNCTION cria_rel_us_pf(_id_perfil integer, _login varchar(20)) RETURNS VOID AS $$
	BEGIN
		INSERT INTO rel_us_pf(login, id_perfil) VALUES (_login, _id_perfil);
	END
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION deleta_rel_us_pf(_id_perfil integer, _login varchar(20)) RETURNS VOID AS $$
	BEGIN
	    DELETE FROM rel_us_pf WHERE id_perfil = _id_perfil and login = _login;
	END
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION seleciona_rel_us_pf(_id_perfil integer, _login varchar(20)) RETURNS TABLE(login_ varchar(20), id_usuario_ integer) AS $$
	BEGIN
	    RETURN QUERY SELECT * FROM rel_us_pf WHERE id_perfil = _id_perfil and login = _login;
	END
$$ LANGUAGE plpgsql;