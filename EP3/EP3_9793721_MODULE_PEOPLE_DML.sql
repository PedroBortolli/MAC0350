CREATE EXTENSION IF NOT EXISTS pgcrypto;

SELECT cria_pessoa('92605465080', 'Pedro Bortolli');
SELECT cria_pessoa('75369995001', 'Pedro Teotonio');
SELECT cria_pessoa('66201660240', 'Lucas Daher');
SELECT cria_pessoa('15270391961', 'Rubens Douglas');
SELECT cria_pessoa('39257362205', 'Lucas Moretto');
SELECT cria_pessoa('79766797161', 'Carlos Eduardo Ferreira');
SELECT cria_pessoa('05749138151', 'João Eduardo Ferreira');

SELECT cria_aluno(9999999, '92605465080', 2016);
SELECT cria_aluno(9793648, '75369995001', 2016);
SELECT cria_aluno(9999998, '66201660240', 2015);
SELECT cria_aluno(9999997, '15270391961', 2016);
SELECT cria_aluno(9999996, '39257362205', 2016);

SELECT cria_professor('79766797161', 'Teoria');
SELECT cria_professor('05749138151', 'Banco de dados');

SELECT cria_administrador('79766797161', '2010-01-01', '2040-01-01');
SELECT cria_administrador('05749138151', '2019-05-20', '2020-05-20');
