CREATE EXTENSION IF NOT EXISTS pgcrypto;

SELECT cria_oferecimento('79766797161', 'MAC0121', 2018, 6, 'POLI', 2);
SELECT cria_oferecimento('05749138151', 'MAC0350', 2019, 3, 'IME', 4);

SELECT cria_cursa('05749138151', 'MAC0350', 9999999, 'MA', 100, 2019, 4);
SELECT cria_cursa('05749138151', 'MAC0350', 9793648, 'RN', 49, 2019, 4);
SELECT cria_cursa('05749138151', 'MAC0350', 9999998, 'A', 51, 2019, 4);
SELECT cria_cursa('79766797161', 'MAC0121', 9999997, 'A', 70, 2018, 2);

SELECT cria_planeja(9999996, 'MAC0470', 8);
SELECT cria_planeja(9793648, 'MAC0350', 2);

SELECT cria_cursa_curriculo(9999997, 46);
SELECT cria_cursa_curriculo(9793648, 45);
SELECT cria_cursa_curriculo(9999996, 50);