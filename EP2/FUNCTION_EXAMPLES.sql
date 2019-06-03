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

SELECT cria_usuario('teotonio', 'teo', 'teo@mailismagic.com', '123456');
SELECT * FROM seleciona_usuario('teotonio');
SELECT atualiza_login_usuario('teotonio', 'pteos');
SELECT atualiza_email_usuario('teotonio', 'pteos@email.com');
SELECT atualiza_senha_usuario('teotonio', '123456', 'novasenha');
SELECT * FROM seleciona_usuario('teotonio');

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

SELECT cria_perfil('adm', 'administra as parada');
SELECT * FROM seleciona_perfil('adm');
SELECT atualiza_perfil('adm', 'administra as paradas');
SELECT * FROM seleciona_perfil('adm');

SELECT cria_servico('visualizacao', 'vizualiza as parada');
SELECT * FROM seleciona_servico('visualizacao');
SELECT atualiza_servico('visualizacao', 'vizualiza as paradas');
SELECT * FROM seleciona_servico('visualizacao');

SELECT cria_trilha('teoria', 'so materia nabo', 8);
SELECT * FROM seleciona_trilha('teoria');
SELECT atualiza_descricao_trilha('teoria', 'so materia legal');
SELECT atualiza_disc_trilha('teoria', 6);
SELECT * FROM seleciona_trilha('teoria');

SELECT cria_modulo(1, 'mat dis', 'so materia nabo', 8);
SELECT * FROM seleciona_modulo('mat dis');
SELECT atualiza_descricao_modulo('mat dis', 'so materia legal');
SELECT atualiza_disc_modulo('mat dis', 6);
SELECT * FROM seleciona_modulo('mat dis');

SELECT cria_disciplina('MAC0666', 'topicos em satanas', 6, 6, 'dcc');
SELECT * FROM seleciona_disciplina('MAC0666');
SELECT atualiza_nome_disciplina('MAC0666', 'topicos no mochila de crinca');
SELECT atualiza_creds_aula_disciplina('MAC0666', 8);
SELECT atualiza_creds_trabalho_disciplina('MAC0666', 4);
SELECT atualiza_instituto_disciplina('MAC0666', 'depart comp');
SELECT * FROM seleciona_disciplina('MAC0666');
SELECT * FROM seleciona_disciplina('MAC0666');

SELECT cria_oferecimento(4, 'MAC0666', 2019, 6, 'IME', 2);
SELECT * FROM seleciona_oferecimento(4, 'MAC0666');
SELECT atualiza_ano_oferecimento(4, 'MAC0666', 2018);
SELECT atualiza_duracao_periodo_oferecimento(4, 'MAC0666', 3, 4);
SELECT atualiza_instituto_oferecimento(4, 'MAC0666', 'FEA');
SELECT * FROM seleciona_oferecimento(4, 'MAC0666');

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
