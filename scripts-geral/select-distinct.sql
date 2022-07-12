-- elimina repetições nas consultas; 

USE customer; 

SELECT DISTINCT column1, column2 
FROM table_name; 


-- terá repetições 

SELECT departamento_codigo
FROM empregado; 

-- não terá repetições na tabela

SELECT DISTINCT departamento_codigo
FROM empregado

