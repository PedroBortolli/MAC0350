CREATE EXTENSION IF NOT EXISTS pgcrypto;

SELECT cria_curriculo(45, 'Bacharelado em Ciência da Computação');
SELECT cria_curriculo(46, 'Bacharelado em Ciência da Computação 2');
SELECT cria_curriculo(50, 'Matemática Pura');
SELECT cria_curriculo(60, 'Matemática Aplicada');
SELECT cria_curriculo(61, 'Matemática Aplicada e Computacional');
SELECT cria_curriculo(70, 'Estatística');
SELECT cria_curriculo(80, 'Licenciatura em Matemática');
SELECT cria_curriculo(81, 'Licenciatura em Matemática 2');
SELECT cria_curriculo(82, 'Licenciatura em Matemática 3');
SELECT cria_curriculo(83, 'Licenciatura em Matemática 4');

SELECT cria_trilha('teoria', 'Teoria da computação, matemática discreta, algoritmos, etc.', 12);
SELECT cria_trilha('sistemas', 'Sistemas de software, banco de dados, programação paralela, etc.', 16);
SELECT cria_trilha('ia', 'Inteligência artificial, machine learning, etc.', 6);
SELECT cria_trilha('cdbioinformatica', 'Ciência de dados, bioinformática', 8);
SELECT cria_trilha('cdeconomia', 'Ciência de dados, economia', 8);
SELECT cria_trilha('cdadministracao', 'Ciência de dados, administração', 8);
SELECT cria_trilha('cdmecatronica', 'Ciência de dados, mecatrônica', 8);
SELECT cria_trilha('cdastronomia', 'Ciência de dados, astronomia', 8);
SELECT cria_trilha('cdmusica', 'Ciência de dados, música', 8);
SELECT cria_trilha('cdengenharia', 'Ciência de dados, engenharia', 8);

SELECT cria_modulo(1, 'matematica discreta', 'Matérias de matemática discreta', 6);
SELECT cria_modulo(1, 'algoritmos', 'Matérias de algoritmos e estruturas de dados', 5);
SELECT cria_modulo(2, 'banco de dados', 'Matérias relacionadas a banco de dados', 3);
SELECT cria_modulo(2, 'sistemas paralelos e distribuidos', 'Matérias de sistemas paralelos e distribuidos', 3);
SELECT cria_modulo(3, 'machine learning', 'Matérias de machine learning', 3);
SELECT cria_modulo(3, 'introducao a ia', 'Matérias de introdução à IA', 4);
SELECT cria_modulo(3, 'teoria associada a ia', 'Matérias de teoria associada à IA', 4);
SELECT cria_modulo(4, 'nucleo 1', 'Matérias do núcleo 1 relacionadas a introdução a ciencia de dados', 3);
SELECT cria_modulo(4, 'nucleo 2', 'Matérias do núcleo 2 relacionadas a estatística', 3);
SELECT cria_modulo(4, 'nucleo 3', 'Matérias do núcleo 3 relacionadas a otimização', 3);

SELECT cria_disciplina('MAC0350', 'Introdução ao Desenvolvimento de Sistemas de Software', 4, 2, 'IME');
SELECT cria_disciplina('MAC0470', 'Desenvolvimento de Software Livre', 4, 2, 'IME');
SELECT cria_disciplina('MAC0105', 'Fundamentos de Matemática para a Computação', 4, 0, 'IME');
SELECT cria_disciplina('MAC0110', 'Introdução à Computação', 4, 0, 'IME');
SELECT cria_disciplina('MAC0121', 'Algoritmo e Estruturas de Dados I', 4, 0, 'IME');
SELECT cria_disciplina('MAC0323', 'Algoritmo e Estruturas de Dados II', 4, 0, 'IME');
SELECT cria_disciplina('MAT0122', 'Álgebra Linear I', 4, 0, 'IME');
SELECT cria_disciplina('MAT2453', 'Cálculo Diferencial e Integral I', 6, 0, 'IME');
SELECT cria_disciplina('MAT2454', 'Cálculo Diferencial e Integral II', 4, 0, 'IME');
SELECT cria_disciplina('MAT0236', 'Funções Diferenciáveis e Séries', 4, 0, 'IME');

SELECT cria_requisito('MAC0323', 'MAC0121');
SELECT cria_requisito('MAT2454', 'MAT2453');
SELECT cria_requisito('MAT0236', 'MAT2454');
SELECT cria_requisito('MAC0350', 'MAC0323');
SELECT cria_requisito('MAC0470', 'MAC0121');
SELECT cria_requisito('MAC0470', 'MAC0350');
SELECT cria_requisito('MAT0236', 'MAT0122');
SELECT cria_requisito('MAC0121', 'MAC0110');
SELECT cria_requisito('MAC0323', 'MAC0105');
SELECT cria_requisito('MAT0236', 'MAC0105');

SELECT cria_rel_cur_tri(45, 1);
SELECT cria_rel_cur_tri(45, 2);
SELECT cria_rel_cur_tri(45, 3);
SELECT cria_rel_cur_tri(45, 4);
SELECT cria_rel_cur_tri(45, 5);
SELECT cria_rel_cur_tri(46, 6);
SELECT cria_rel_cur_tri(46, 7);
SELECT cria_rel_cur_tri(46, 8);
SELECT cria_rel_cur_tri(46, 9);
SELECT cria_rel_cur_tri(46, 10);

SELECT cria_rel_mod_dis(1, 'MAC0350', '1');
SELECT cria_rel_mod_dis(2, 'MAC0470', '1');
SELECT cria_rel_mod_dis(3, 'MAC0105', '0');
SELECT cria_rel_mod_dis(4, 'MAC0110', '0');
SELECT cria_rel_mod_dis(5, 'MAC0121', '0');
SELECT cria_rel_mod_dis(6, 'MAC0323', '1');
SELECT cria_rel_mod_dis(7, 'MAT0122', '1');
SELECT cria_rel_mod_dis(8, 'MAT2453', '0');
SELECT cria_rel_mod_dis(9, 'MAT2454', '0');
SELECT cria_rel_mod_dis(10, 'MAT0236', '1');