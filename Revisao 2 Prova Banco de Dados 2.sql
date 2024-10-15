-- 1 Escreva um conjunto de instrucoes SQL responsavel por criar um tabela chamada 
-- Projeto com as colunas id(int), nome(varchar) e 
-- descricao(varchar). Um empregado pode trabalhar em um ou mais projetos ao mesmo tempo.

create table projeto (
	id_projeto int not null auto_increment,
    nome varchar (30),
    descricao varchar(30),
    PRIMARY KEY (id_projeto));
    
create table projeto_Empregado(
	pj_id_projeto int,
    pj_emp_no int,
    PRIMARY KEY(id_projeto, emp),
    foreign key (id_projeto) references projeto (id_projeto),
    foreign key (pj_emp_no) references empregados (emp_no));
    
-- 2 escreva uma consulta sql que retorne o numero total de titulos que o 
-- empregado 'Jose Silva' possui, somente se seu salario for superior a RS 10.000,00

select count(t.titulo)
from empregados e
	join titulos t on t.emp_on = e.emp_no
    join salarios s on s.emp_on = e.emp_no
where s.salario >= 10000 and e.primeiro_nome = 'Jose' and e.ultimo_nome = 'Silva';

-- 3 escreva uma consulta sql para retornar o total de salarios dos gerentes

select SUM(s.salario) as totalSalario
from dept_gerente d
	join empregados e on e.emp_on = d.emp_on
	join salarios s on s.emp_on = e.emp_on;
    
-- 4 escreva uma consulta sql para retornar o nome e ultimo nome dos gerentes que 
-- possuam o titulo de Doutor, trabalhem no departamento Desenvolvimento 
-- e que ganhem menos de R$ 7000. Mostre os resultados ordenados pelo nome e ultimo nome.

select e.primero_nome, e.ultimo_nome
from dept_gerente d
	join departamentos on departamentos.dept_no = d.dept_no
    join dept_emp on dept_emp.dept_no = departamentos.dept_no
	join empregados e on e.emp_no = dept_emp.emp_on
    join titulos t on t.emp_no = e.emp_no
    join salarios s on s.emp_no = e.emp_no
where t.titulo = 'Doutor' and departamentos.dept_nome = "Desenvolvimento" 
and s.salario < 7000
order by e.primeiro_nome, e.ultimo_nome;

-- 5 escreva uma consulta sql que retorne a 
-- lista de departamentos que nao possuem gerentes atribuidos 

select d.dept_nome
from departamentos d
	left join dept_gerente g on g.emp_no = d.emp_no
where g.emp_no is NULL;

-- 6 escreva uma consulta sql que retorne a media 
-- salarial dos empregados que possuem o titulo de mestre 
-- do departamento pesquisa

SELECT AVG(s.salario)
FROM empregados e
	JOIN salarios s ON s.emp_no = e.emp_no
	JOIN titulos t ON t.emp_no = e.emp_no
	JOIN dept_emp de ON de.emp_no = e.emp_no
	JOIN departamentos d ON d.dept_no = de.dept_no
WHERE t.titulo = 'Mestre' AND d.dept_name = 'Pesquisa';