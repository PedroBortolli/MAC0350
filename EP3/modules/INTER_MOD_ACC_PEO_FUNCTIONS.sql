DROP FUNCTION IF EXISTS cria_rel_pe_us(integer, varchar(50));
DROP FUNCTION IF EXISTS deleta_rel_pe_us(integer, varchar(50));
DROP FUNCTION IF EXISTS seleciona_rel_pe_us(integer, varchar(50));

CREATE OR REPLACE FUNCTION cria_rel_pe_us(_id_pessoa integer, _login varchar(50)) RETURNS VOID AS $$
	BEGIN
	    IF (EXISTS (SELECT 1 FROM pessoa_foreign WHERE id_pessoa = _id_pessoa) AND EXISTS (SELECT 1 FROM usuario_foreign WHERE login = _login)) THEN
    		INSERT INTO rel_pe_us(id_pessoa, login) VALUES (_id_pessoa, _login);
    	END IF;
	END
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION deleta_rel_pe_us(_id_pessoa integer, _login varchar(50)) RETURNS VOID AS $$
	BEGIN
	    DELETE FROM rel_us_pf WHERE id_pessoa = _id_pessoa and login = _login;
	END
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION seleciona_rel_pe_us(_id_pessoa integer, _login varchar(50)) RETURNS TABLE(id_pessoa_ integer, login_ varchar(50)) AS $$
	BEGIN
	    IF (EXISTS (SELECT 1 FROM pessoa_foreign WHERE id_pessoa = _id_pessoa) AND EXISTS (SELECT 1 FROM usuario_foreign WHERE login = _login)) THEN
    		RETURN QUERY SELECT * FROM rel_us_pf WHERE id_pessoa = _id_pessoa and login = _login;
    	END IF;
	END
$$ LANGUAGE plpgsql;