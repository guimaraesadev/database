-- listar os dados dos empregados que trabalhem no dept. 40 e possuem salário superior à 500 reais 

SELECT * FROM Empregado
WHERE Departamento_Codigo = 40 AND Salario > 500,00; 

-- listar os dados dos empregados que trabalhem no dept. 40 ou possuem salário superior à 500 reais 

SELECT * FROM Empregado
WHERE Departamento_Codigo = 40 OR Salario > 500,00; 

-- listar dados dos empregados que trabalham nos departamentos 10 ou 30 

SELECT * FROM Empregado
WHERE Departamento_Codigo = 10 OR Departamento_Codigo = 30; 

-- outra maneira; 
-- semelhantes semânticamente;

SELECT * FROM Empregado 
WHERE Departamento_Codigo IN (10, 30); 


-- listar dado dos empregados que NÃO trabalham nos departamentos 10 nem 30; 

SELECT * FROM Empregado
WHERE (Departamento_Codigo <> 10 and Departamento_Codigo <> 30); 

-- outra maneira;
-- semelhantes semanticamente 

SELECT * FROM Empregado
WHERE Departamento_Codigo NOT IN (10, 30); 

-- listar dado dos empregados que NÃO trabalham nos departamentos 10 nem 30, inclusive os de departamento NULL 

SELECT * FROM Empregado
WHERE (Departamento_Codigo <> 10 and Departamento_Codigo <> 30) OR Departamento_Codigo IS NULL; 

-- explicando: não pode ser 10, não pode ser 30, mas pode ser NULO; 
-- se eu utilizasse o AND, geraria conflito, pois o departamento teria que ser obrigatóriamente NULL também 
-- null: ausência de valor 

-- outra maneira semanticamente igual 

SELECT * FROM Empregado
WHERE Departamento_Codigo NOT IN (10, 30) OR Departamento_Codigo IS NULL; 

-- listar dados dos empregados que possuem salário entre R$ 250,00 e R$ 800,00
-- maneira primitiva: 

SELECT * FROM Empregado 
WHERE salário >= 250.00 AND <= 800.00 

-- maneira moderna/mais utilizável 






