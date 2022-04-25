CREATE DATABASE `uvv` /*!40100 DEFAULT CHARACTER SET latin1 */;

-- CRIAÇÃO TABELA FUNCIONÁRIOS
CREATE TABLE `funcionarios` (
  `cpf` char(11) NOT NULL,
  `primeiro_nome` varchar(15) NOT NULL,
  `nome_meio` char(1) DEFAULT NULL,
  `ultimo_nome` varchar(15) NOT NULL,
  `data_nascimento` date DEFAULT NULL,
  `endereco` varchar(50) DEFAULT NULL, # Aumentei o tamanho do endereço pois estava dando erro na hora de inserir os dados
  `sexo` char(1) DEFAULT NULL,
  `salario` decimal(10,2) NOT NULL,
  `cpf_supervisor` char(11) NOT NULL,
  `numero_departamento` int(11) NOT NULL,
  PRIMARY KEY (`cpf`)
  COSTRAINT `funcionarios_fk`
  FOREIGN KEY (`cpf_supevisor`) REFERENCES `funcionarios` (`cpf`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


-- CRIAÇÃO TABELA DEPENDENTES
CREATE TABLE `dependentes` (
  `cpf_funcionario` char(11) NOT NULL,
  `nome_dependente` varchar(15) NOT NULL,
  `sexo` char(1) DEFAULT NULL,
  `data_nascimento` date DEFAULT NULL,
  `parentesco` varchar(15) DEFAULT NULL,
  PRIMARY KEY (`nome_dependente`,`cpf_funcionario`)
  CONSTRAINT `dependentes_fk` 
  FOREIGN KEY (`cpf_funcionario`) REFERENCES `funcionario` (`cpf`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


-- CRIAÇÃO TABELA DEPARTAMENTO
CREATE TABLE `departamento` (
  `numero_departamento` int(11) NOT NULL,
  `nome_departamento` varchar(15) NOT NULL,
  `cpf_gerente` char(11) NOT NULL,
  `data_inicio_gerente` date DEFAULT NULL,
  PRIMARY KEY (`numero_departamento`),
  UNIQUE KEY `departamento_UN` (`nome_departamento`)
  CONSTRAINT `departamento_fk` 
  FOREIGN KEY (`cpf_gerente`) REFERENCES `funcionarios` (`cpf_supervisor`) 
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


-- CRIAÇÃO TABELA LOCALIZAÇÕES DEPARTAMENTO
CREATE TABLE `localizacoes_departamento` (
  `numero_departamento` int(11) NOT NULL,
  `local` varchar(15) NOT NULL,
  PRIMARY KEY (`numero_departamento`,`local`)
  CONSTRAINT `localizacoes_departamento_fk`
  FOREIGN KEY (`numero_departamento`) REFERENCES `departamento` (`numero_departamento`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


-- CRIAÇÃO TABELA TRABALHA EM 
CREATE TABLE `trabalha_em` (
  `cpf_funcionario` char(11) NOT NULL,
  `numero_projeto` int(11) NOT NULL,
  `horas` decimal(3,2) NOT NULL,
  PRIMARY KEY (`cpf_funcionario`,`numero_projeto`)
  CONSTRAINT `trabalha_em_fk`
  FOREIGN KEY (`numero_projeto`) REFERENCES `projeto` (`numero_projeto`)
  FOREIGN KEY (`cpf_funcionario`) REFERENCES `funcionario` (`cpf`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


-- CRIAÇÃO TABELA PROJETO
CREATE TABLE `projeto` (
  `numero_projeto` int(11) NOT NULL,
  `nome_projeto` varchar(15) NOT NULL,
  `local_projeto` varchar(15) DEFAULT NULL,
  `numero_departamento` int(11) NOT NULL,
  PRIMARY KEY (`numero_projeto`),
  UNIQUE KEY `projeto_UN` (`nome_projeto`)
  CONSTRAINT `projeto_fk`
  FOREIGN KEY (`numero_departamento`) REFERENCES `departamento`(`numero_departamento`) 
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


-- INSERÇÃO TABELA DEPARTAMENTO
INSERT INTO uvv.departamento
(nome_departamento, numero_departamento, cpf_gerente, data_inicio_gerente)
VALUES('Pesquisa', 5, '33344555587', '1988-05-22');
INSERT INTO uvv.departamento
(nome_departamento, numero_departamento, cpf_gerente, data_inicio_gerente)
VALUES('Administração', 4, '98765432168', '1995-01-01');
INSERT INTO uvv.departamento
(nome_departamento, numero_departamento, cpf_gerente, data_inicio_gerente)
VALUES('Matriz', 1, '88866555576', '1981-06-19');


-- INSERÇÃO TABELA DEPENDENTES 
INSERT INTO uvv.dependentes
(cpf_funcionario, nome_dependente, sexo, data_nascimento, parentesco)
VALUES('33344555587', 'Alicia', 'F', '1986-04-05', 'Filha');
INSERT INTO uvv.dependentes
(cpf_funcionario, nome_dependente, sexo, data_nascimento, parentesco)
VALUES('33344555587', 'Tiago', 'M', '1983-10-25', 'Filho');
INSERT INTO uvv.dependentes
(cpf_funcionario, nome_dependente, sexo, data_nascimento, parentesco)
VALUES('33344555587', 'Janaina', 'F', '1958-05-03', 'Esposa');
INSERT INTO uvv.dependentes
(cpf_funcionario, nome_dependente, sexo, data_nascimento, parentesco)
VALUES('98765432168', 'Antonio', 'M', '1942-02-28', 'Marido');
INSERT INTO uvv.dependentes
(cpf_funcionario, nome_dependente, sexo, data_nascimento, parentesco)
VALUES('12345678966', 'Michael', 'M', '1988-01-04', 'Filho');
INSERT INTO uvv.dependentes
(cpf_funcionario, nome_dependente, sexo, data_nascimento, parentesco)
VALUES('12345678966', 'Alicia', 'F', '1988-12-30', 'Filha');
INSERT INTO uvv.dependentes
(cpf_funcionario, nome_dependente, sexo, data_nascimento, parentesco)
VALUES('12345678966', 'Elizabeth', 'F', '1967-05-05', 'Esposa');


-- INSERÇÃO TABELA FUNCIONÁRIOS
INSERT INTO uvv.funcionarios
(cpf, primeiro_nome, nome_meio, ultimo_nome, data_nascimento, endereco, sexo, salario, cpf_supervisor, numero_departamento)
VALUES('12345678966', 'João', 'B', 'Silva', '1965-01-09', 'Rua das Flores,751, São Paulo, SP', 'M', 30000.0, '33344555587', 5);
INSERT INTO uvv.funcionarios
(cpf, primeiro_nome, nome_meio, ultimo_nome, data_nascimento, endereco, sexo, salario, cpf_supervisor, numero_departamento)
VALUES('33344555587', 'Fernando', 'T', 'Wong', '1955-12-08', 'Rua da Lapa, 34, São Paulo, SP', 'M', 40000.0, '88866555576', 5);
INSERT INTO uvv.funcionarios
(cpf, primeiro_nome, nome_meio, ultimo_nome, data_nascimento, endereco, sexo, salario, cpf_supervisor, numero_departamento)
VALUES('99988777767', 'Alice', 'J', 'Zelaya', '1968-01-19', 'Rua Souza Lima, 35, Curitiba, PR', 'F', 25000.0, '98765432168', 4);
INSERT INTO uvv.funcionarios
(cpf, primeiro_nome, nome_meio, ultimo_nome, data_nascimento, endereco, sexo, salario, cpf_supervisor, numero_departamento)
VALUES('98765432168', 'Jennifer', 'S', 'Souza', '1941-06-20', 'Av. Arthur de Lima, 54, Santo André, SP', 'F', 43000.0, '88866555576', 4);
INSERT INTO uvv.funcionarios
(cpf, primeiro_nome, nome_meio, ultimo_nome, data_nascimento, endereco, sexo, salario, cpf_supervisor, numero_departamento)
VALUES('66688444476', 'Ronaldo', 'K', 'Lima', '1962-09-15', 'Rua Rebouças, 55, Piracicaba, SP', 'M', 38000.0, '33344555587', 5);
INSERT INTO uvv.funcionarios
(cpf, primeiro_nome, nome_meio, ultimo_nome, data_nascimento, endereco, sexo, salario, cpf_supervisor, numero_departamento)
VALUES('45345345376', 'Joice', 'A', 'Leite', '1972-07-31', 'Av. Lucas Obes, 74, São Paulo, SP', 'F', 25000.0, '33344555587', 5);
INSERT INTO uvv.funcionarios
(cpf, primeiro_nome, nome_meio, ultimo_nome, data_nascimento, endereco, sexo, salario, cpf_supervisor, numero_departamento)
VALUES('98798798733', 'André', 'V', 'Pereira', '1969-03-29', 'Rua Timbira, 35, São Paulo, SP ', 'M', 25000.0, '98765432168', 4);
INSERT INTO uvv.funcionarios
(cpf, primeiro_nome, nome_meio, ultimo_nome, data_nascimento, endereco, sexo, salario, cpf_supervisor, numero_departamento)
VALUES('88866555576', 'Jorge', 'E', 'Brito', '1937-11-10', 'Rua do Horto, 35, São Paulo, SP', 'M', 55000.00, 'NULL', 1);



-- INSERÇÃO TABELA LOCALIZAÇÕES DEPARTAMENTO
INSERT INTO uvv.localizacao_departamento
(numero_departamento, `local`)
VALUES(1, 'São Paulo');
INSERT INTO uvv.localizacao_departamento
(numero_departamento, `local`)
VALUES(4, 'Mauá');
INSERT INTO uvv.localizacao_departamento
(numero_departamento, `local`)
VALUES(5, 'Santo André');
INSERT INTO uvv.localizacao_departamento
(numero_departamento, `local`)
VALUES(5, 'Itu');
INSERT INTO uvv.localizacao_departamento
(numero_departamento, `local`)
VALUES(5, 'São Paulo');


-- INSERÇÃO TABELA PROJETO
INSERT INTO uvv.projeto
(numero_projeto, nome_projeto, local_projeto, numero_departamento)
VALUES(1, 'ProdutoX', 'Santo André', 5);
INSERT INTO uvv.projeto
(numero_projeto, nome_projeto, local_projeto, numero_departamento)
VALUES(2, 'ProdutoY', 'Itu', 5);
INSERT INTO uvv.projeto
(numero_projeto, nome_projeto, local_projeto, numero_departamento)
VALUES(3, 'ProdutoZ', 'São Paulo', 5);
INSERT INTO uvv.projeto
(numero_projeto, nome_projeto, local_projeto, numero_departamento)
VALUES(10, 'Informatização', 'Mauá', 4);
INSERT INTO uvv.projeto
(numero_projeto, nome_projeto, local_projeto, numero_departamento)
VALUES(20, 'Reorganização', 'São Paulo', 1);
INSERT INTO uvv.projeto
(numero_projeto, nome_projeto, local_projeto, numero_departamento)
VALUES(30, 'Novosbenefícios', 'Mauá', 4);


--INSERÇÃO TABELA TRABALHA EM
INSERT INTO uvv.trabalha_em
(cpf_funcionario, numero_projeto, horas)
VALUES('12345678966', 1, 32.5);
INSERT INTO uvv.trabalha_em
(cpf_funcionario, numero_projeto, horas)
VALUES('12345678966', 2, 7.5);
INSERT INTO uvv.trabalha_em
(cpf_funcionario, numero_projeto, horas)
VALUES('66688444476', 3, 40.0);
INSERT INTO uvv.trabalha_em
(cpf_funcionario, numero_projeto, horas)
VALUES('45345345376', 1, 20.0);
INSERT INTO uvv.trabalha_em
(cpf_funcionario, numero_projeto, horas)
VALUES('45345345376', 2, 20.0);
INSERT INTO uvv.trabalha_em
(cpf_funcionario, numero_projeto, horas)
VALUES('33344555587', 2, 10.0);
INSERT INTO uvv.trabalha_em
(cpf_funcionario, numero_projeto, horas)
VALUES('33344555587', 3, 10.0);
INSERT INTO uvv.trabalha_em
(cpf_funcionario, numero_projeto, horas)
VALUES('33344555587', 10, 10.0);
INSERT INTO uvv.trabalha_em
(cpf_funcionario, numero_projeto, horas)
VALUES('33344555587', 20, 10.0);
INSERT INTO uvv.trabalha_em
(cpf_funcionario, numero_projeto, horas)
VALUES('99988777767', 30, 30.0);
INSERT INTO uvv.trabalha_em
(cpf_funcionario, numero_projeto, horas)
VALUES('99988777767', 10, 10.0);
INSERT INTO uvv.trabalha_em
(cpf_funcionario, numero_projeto, horas)
VALUES('98798798733', 10, 35.0);
INSERT INTO uvv.trabalha_em
(cpf_funcionario, numero_projeto, horas)
VALUES('98798798733', 30, 5.0);
INSERT INTO uvv.trabalha_em
(cpf_funcionario, numero_projeto, horas)
VALUES('98765432168', 30, 20.0);
INSERT INTO uvv.trabalha_em
(cpf_funcionario, numero_projeto, horas)
VALUES('98765432168', 20, 15.0);
INSERT INTO uvv.trabalha_em
(cpf_funcionario, numero_projeto, horas)
VALUES('88866555576', 20, NULL);





