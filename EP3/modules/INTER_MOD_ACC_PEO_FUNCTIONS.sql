DROP FUNCTION IF EXISTS cria_rel_pe_us(VARCHAR(11), varchar(50));
DROP FUNCTION IF EXISTS deleta_rel_pe_us(VARCHAR(11), varchar(50));
DROP FUNCTION IF EXISTS seleciona_rel_pe_us(VARCHAR(11), varchar(50));

CREATE OR REPLACE FUNCTION cria_rel_pe_us(_cpf VARCHAR(11), _login varchar(50)) RETURNS VOID AS $$
	BEGIN
	    IF (EXISTS (SELECT 1 FROM pessoa_foreign WHERE cpf = _cpf) AND EXISTS (SELECT 1 FROM usuario_foreign WHERE login = _login)) THEN
    		INSERT INTO rel_pe_us(cpf, login) VALUES (_cpf, _login);
    	END IF;
	END
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION deleta_rel_pe_us(_cpf VARCHAR(11), _login varchar(50)) RETURNS VOID AS $$
	BEGIN
	    DELETE FROM rel_pe_us WHERE cpf = _cpf and login = _login;
	END
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION seleciona_rel_pe_us(_cpf VARCHAR(11), _login varchar(50)) RETURNS TABLE(cpf_ VARCHAR(11), login_ varchar(50)) AS $$
	BEGIN
	    IF (EXISTS (SELECT 1 FROM pessoa_foreign WHERE cpf = _cpf) AND EXISTS (SELECT 1 FROM usuario_foreign WHERE login = _login)) THEN
    		RETURN QUERY SELECT * FROM rel_pe_us WHERE cpf = _cpf and login = _login;
    	END IF;
	END
$$ LANGUAGE plpgsql;