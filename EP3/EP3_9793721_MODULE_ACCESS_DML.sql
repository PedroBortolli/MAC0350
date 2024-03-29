SELECT cria_usuario ('admin', 'admin@admin.com', 'password');
SELECT cria_usuario ('cef', 'cef@ime.usp.br', 'euamoamaratona');
SELECT cria_usuario ('pedroteosousa', 'pedro.teotonio.sousa@usp.br', 'senhasenhasenha');

SELECT cria_perfil ('aluno', 'tem acesso a comandos de selecionar');
SELECT cria_perfil ('professor', 'tem acesso a comandos de selecionar e criar e atualizar');
SELECT cria_perfil ('administrador', 'tem acesso a comandos de selecionar, criar, atualizar e remover');

SELECT cria_servico ('visualização', 'permite visualizar campos no db');
SELECT cria_servico ('atualização', 'permite atualizar campos no db');
SELECT cria_servico ('criação', 'permite criar campos no db');
SELECT cria_servico ('remoção', 'permite remover campos no db');

SELECT associa_perfil ('pedroteosousa', 'aluno');
SELECT associa_perfil ('cef', 'professor');
SELECT associa_perfil ('admin', 'administrador');

SELECT associa_servico ('aluno', 'visualização');
SELECT associa_servico ('administrador', 'visualização');
SELECT associa_servico ('administrador', 'atualização');
SELECT associa_servico ('administrador', 'criação');
SELECT associa_servico ('administrador', 'remoção');
SELECT associa_servico ('professor', 'visualização');
SELECT associa_servico ('professor', 'atualização');
SELECT associa_servico ('professor', 'criação');
