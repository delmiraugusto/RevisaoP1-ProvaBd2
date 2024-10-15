
-- REVISAO--
-- 1) Deseja-se armazenar mais informações no banco de dados acerca da editora. 
-- Deseja-se conhecer o telefone e endereço da editora. Cada editora irá possuir um 
-- identificador único. Escreva os comandos necessários para criar a tabela editora 
-- contendo as informações anteriormente descritas e os relacionamentos necessários 
-- com as demais tabelas do banco de dados.

alter table livro 
drop editora;

create table editora(
	telefone int,
    endereco varchar(30),
    id_editora int auto_increment,
    nome_editora varchar(30),
    PRIMARY KEY (id_editora));
    
alter table livro add(
    livro_id_editora int,
    FOREIGN KEY (livro_id_editora) references editora (id_editora)); 
    
-- 2) Faça uma consulta para encontrar o valor total 
-- gasto pelo cliente “José da Silva” na compra de livros do autor “José de Alencar”?

select sum(iv.quantidade * l.preco) as total
from cliente c 
			 join venda v on v.cliente_idcliente = c.idcliente
			 join itemVenda i on i.venda_idvenda = v.idvenda
             join livro l on l.idlivro = i.livro_idlivro
             join escreve e on e.livro_idlivro = l.idlivro
             join autor a on a.idautor = e.autor_idautor
where c.nome = "José da Silva" and a.autor = "Jose de Alencar";

-- 3) Faça uma consulta para encontrar a quantidade de autores 
-- que escreveram livros dos gêneros TÈCNICO e ROMANCE que estão cadastrados na loja?

select count(idautor)
from autor a
			join escreve e on e.autor_idautor = a.idautor
			join livro l on l.idlivro = e.autor_idautor
            join genero g on g.idgenero = l.genero_idgenero
where g.descricao = "TECNICO" or g.descricao = "ROMANCE";

-- 4) Considerando as mudanças realizadas no banco de dados na Questão 1, 
-- elabore uma consulta para encontrar o nome do autor que escreveu mais 
-- exemplares de livros da editora Vozes e gênero Ficção.

select count(a.nome)
from autor a 
			join escreve e on e.autor_idautor = a.id_autor
            join livro l on l.idlivro = l.livro_idlivro
            join editora d on d.id_editora = l.livro_id_editora
            join genero g on g.id_genero = l.genero_idgenero
            
-- 5 Elabore um comando para aumentar em 20% os preços dos livros escritos 
-- por José de Alencar pela editora Rocco.

UPDATE livro l
			JOIN escreve e ON e.livro_idlivro = l.idlivro
			JOIN autor a ON a.idautor = e.autor_idautor
			JOIN editora d ON d.id_editora = l.livro_id_editora
	SET l.preco = l.preco * 1.20
WHERE a.nome = 'José de Alencar' AND d.nome_editora = 'Rocco';

-- 6 Elabore um comando para remover os gêneros que não estejam vinculados 
-- a pelo menos um livro na livraria

DELETE g.idgenero
	FROM genero g
	LEFT JOIN livro l ON l.genero_idgenero = g.idgenero
WHERE l.genero_idgenero IS NULL;






