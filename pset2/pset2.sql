
-- 1
SELECT AVG(f.salario) AS media_salarial, d.nome_departamento
FROM funcionarios f
INNER JOIN departamento d
ON(d.numero_departamento=f.numero_departamento)
GROUP BY d.nome_departamento;

-- 2

SELECT AVG(f.salario) AS media_salarial, f.sexo
FROM funcionarios f
GROUP BY f.sexo;

-- 3

SELECT d.nome_departamento, CONCAT (f.primeiro_nome, ' ', f.nome_meio, ' ', f.ultimo_nome) AS nome_completo, f.data_nascimento,
TIMESTAMPDIFF (YEAR, f.data_nascimento, CURDATE()) AS idade,
f.salario
FROM departamento d
INNER JOIN funcionarios f
ON f.numero_departamento = d.numero_departamento;

-- 4


SELECT CONCAT (f.primeiro_nome, ' ', f.nome_meio, ' ', f.ultimo_nome) AS nome_completo,
TIMESTAMPDIFF (YEAR, f.data_nascimento, CURDATE()) AS idade,
f.salario AS antes_reajuste, 
(CASE
  WHEN f.salario >= 35 then f.salario * 1.15
  ELSE f.salario * 1.2
END) AS depois_reajuste
FROM funcionarios f;


-- 5 

WITH gerente AS 
(SELECT CONCAT (f.primeiro_nome, ' ', f.nome_meio, ' ', f.ultimo_nome) AS nome_gerente,
f.cpf
FROM funcionarios f)
SELECT d.nome_departamento, g.nome_gerente, 
CONCAT (f.primeiro_nome, ' ', f.nome_meio, ' ', f.ultimo_nome) AS nome,
TIMESTAMPDIFF (YEAR, f.data_nascimento, CURDATE()) AS idade,
f.salario
FROM funcionarios f
INNER JOIN departamento d
ON f.numero_departamento = d.numero_departamento
INNER JOIN gerente g ON g.cpf = f.cpf_supervisor
ORDER BY d.nome_departamento ASC, f.salario DESC;


-- 6

SELECT d.nome_departamento, CONCAT(f.primeiro_nome, ' ', f.nome_meio, ' ', f.ultimo_nome) AS nome_funcionario,
CONCAT (dn.nome_dependente, ' ', f.nome_meio, ' ', f.ultimo_nome) AS nome_dependente,
TIMESTAMPDIFF (YEAR, dn.data_nascimento, CURDATE()) AS idade_dependente,
(CASE
    WHEN dn.sexo = 'M' 
    THEN 'Masculino'
    ELSE 'Feminino'
END) AS sexo_dependente
FROM funcionarios f 
INNER JOIN departamento d
ON f.numero_departamento = d.numero_departamento
INNER JOIN dependente dn
ON f.cpf = dn.cpf_funcionario;

-- 7

SELECT d.nome_departamento, CONCAT(f.primeiro_nome, ' ', f.nome_meio, ' ', f.ultimo_nome) AS nome_funcionario,
f.salario
FROM funcionarios f 
INNER JOIN departamento d
ON f.numero_departamento = d.numero_departamento
LEFT JOIN dependente dn
ON f.cpf = dn.cpf_funcionario
WHERE dn.cpf_funcionario IS NULL;

-- 8


SELECT d.nome_departamento, 
p.nome_projeto,
CONCAT(f.primeiro_nome, ' ', f.nome_meio, '. ', f.ultimo_nome) AS nome_funcionario,
CONCAT(t.horas, 'h') AS horas
FROM funcionarios f 
INNER JOIN departamento d
ON f.numero_departamento = d.numero_departamento 
INNER JOIN projeto p 
INNER JOIN trabalha_em t
ON p.numero_projeto = t.numero_projeto 
AND f.cpf = t.cpf_funcionario 
ORDER BY d.nome_departamento ASC;


-- 9

SELECT d.nome_departamento, p.nome_projeto, SUM(distinct(t.horas)) AS total_horas
FROM projeto p
INNER JOIN departamento d
ON d.numero_departamento = p.numero_departamento
INNER JOIN trabalha_em t 
ON t.numero_projeto = p.numero_projeto
GROUP BY p.nome_projeto;

-- 10

SELECT AVG(f.salario) AS media_salarial, d.nome_departamento
FROM funcionarios f
INNER JOIN departamento d
ON(d.numero_departamento=f.numero_departamento)
GROUP BY d.nome_departamento;

-- 11

SELECT CONCAT(f.primeiro_nome, ' ', f.nome_meio, '. ', f.ultimo_nome) AS nome_funcionario,
t.horas * 50 AS a_receber, p.nome_projeto
FROM funcionarios f 
INNER JOIN trabalha_em t 
ON t.cpf_funcionario = f.cpf
INNER JOIN projeto p 
ON p.numero_projeto = t.numero_projeto;

-- 12

SELECT f.primeiro_nome AS nome, d.nome_departamento, p.nome_projeto, t.horas
FROM funcionarios f 
INNER JOIN departamento d
ON f.numero_departamento = d.numero_departamento
INNER JOIN projeto p
ON p.numero_departamento = d.numero_departamento
INNER JOIN trabalha_em t 
ON t.cpf_funcionario = f.cpf 
WHERE t.horas = 0 OR t.horas = NULL;


-- 13

SELECT CONCAT(f.primeiro_nome, ' ', f.nome_meio, '. ', f.ultimo_nome) AS nome,
TIMESTAMPDIFF (YEAR, f.data_nascimento, CURDATE()) AS idade
FROM funcionarios f
UNION 
SELECT CONCAT (dn.nome_dependente, ' ', f.nome_meio, ' ', f.ultimo_nome) AS nome,
TIMESTAMPDIFF (YEAR, dn.data_nascimento, CURDATE()) AS idade
FROM dependente dn
INNER JOIN funcionarios f
ON f.cpf = dn.cpf_funcionario
ORDER BY idade DESC;


-- 14

SELECT f.numero_departamento, d.nome_departamento, COUNT(*) AS quantidade_funcionarios
FROM funcionarios f 
INNER JOIN departamento d
ON d.numero_departamento = f.numero_departamento
GROUP BY f.numero_departamento;

-- 15

SELECT CONCAT (f.primeiro_nome, ' ', f.nome_meio, '. ', f.ultimo_nome, ' ') AS nome_funcionario,
d.nome_departamento, p.nome_projeto
FROM funcionarios f
INNER JOIN departamento d 
ON(f.numero_departamento = d.numero_departamento)
INNER JOIN projeto p 
ON (d.numero_departamento = p.numero_departamento);


