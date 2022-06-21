-- JOIN: uma junção de duas ou mais tabelas para uma única consulta; 
-- A chave estrangeira (FK) é essêncial para juntar tabelas; 
-- FK's e PK's indentificam o relacionamento entre tabelas; 

-- Inner Join: Interseção da duas tabelas (o que tem em comum nas duas)

SELECT 

cli.ID,
cli.NOME
vend.valor

FROM CLIENTE cli -- o AS não se torna mais obrigatório, é uma boa prática; 

INNER JOIN 

venda vend ON vend.ID_CLIENTE = cli.ID 




