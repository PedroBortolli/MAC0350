DROP FUNCTION IF EXISTS cria_rel_pe_us(VARCHAR(11), varchar(50));
DROP FUNCTION IF EXISTS deleta_rel_pe_us(VARCHAR(11), varchar(50));
DROP FUNCTION IF EXISTS seleciona_rel_pe_us(VARCHAR(11), varchar(50));

DROP FUNCTION IF EXISTS seleciona_pessoa(VARCHAR(50));

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

CREATE OR REPLACE FUNCTION seleciona_pessoa(VARCHAR(50))
RETURNS TABLE(
	cpf VARCHAR(11),
	nome VARCHAR(100)
) AS $$
	BEGIN
	    RETURN QUERY SELECT pessoa_foreign.cpf, pessoa_foreign.nome FROM pessoa_foreign
		INNER JOIN rel_pe_us ON pessoa_foreign.cpf = rel_pe_us.cpf
		WHERE rel_pe_us.login = $1;
	END
$$ LANGUAGE plpgsql;
