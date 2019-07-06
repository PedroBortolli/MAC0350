SELECT cria_usuario ('admin', 'admin@admin.com', 'password');
SELECT cria_usuario ('cef', 'cef@ime.usp.br', 'euamoacris');
SELECT cria_usuario ('pedroteosousa', 'pedro.teotonio.sousa@usp.br', 'senhasenhasenha')

SELECT cria_perfil ('aluno', 'tem acesso a comandos de selecionar e mudar coisas relacionadas ao seu usuário');

SELECT cria_servico ('remoção', 'permite remover campos no db');
SELECT cria_servico ('criação', 'permite criar campos no db');
SELECT cria_servico ('atualização', 'permite atualizar campos no db');
