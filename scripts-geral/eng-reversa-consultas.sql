DROP VIEW `ANALISE_SEMANAL_BOLETOS`;

CREATE VIEW `ANALISE_SEMANAL_BOLETOS` AS 
(
SELECT -- TABELAS UTILIZADAS 
    aluno_bolet.MATRICULA "Matrícula",
    aluno_bolet.NOME "Nome",
    aluno_bolet.SEMANA "Semana analisada",
    aluno_bolet.FALTA_SEMANA_ANT "Faltas contabilizadas",
    aluno_bolet.CUSTO_DIARIO "Custo diário",
    aluno_bolet.CUSTO_SEMANAL "Custo semanal",
    aluno_bolet.VALOR_LIBERADO "Valor Liberado",
    aluno_bolet.VALOR_PEDIDO "Valor solicitado",
    aluno_bolet.CODIGO_BOLETO "Código do boleto",
    aluno_bolet.LINK_BOLETO "Link para boleto",
    CASE 
        WHEN aluno_bolet.VALOR_LIBERADO >= aluno_bolet.VALOR_PEDIDO THEN 'SIM'
        ELSE 'NÃO!'
    END "Pagamento aprovado",
    aluno_bolet.JUSTIFICATIVA "Justificativa",
    aluno_bolet.PAGO "Pago"
FROM (
    SELECT -- TABELAS UTILIZADAS 
        custos_desloc.MATRICULA,
        custos_desloc.NOME,
        custos_desloc.SEMANA,
        custos_desloc.FALTA_SEMANA_ANT,
        custos_desloc.CUSTO_DIARIO,
        custos_desloc.CUSTO_SEMANAL,
        (custos_desloc.CUSTO_SEMANAL - (custos_desloc.CUSTO_DIARIO * custos_desloc.FALTA_SEMANA_ANT)) * 1.1 "VALOR_LIBERADO",
        bol_pas.VALOR_PEDIDO,
        bol_pas.CODIGO_BOLETO,
        bol_pas.LINK_BOLETO,
        bol_pas.JUSTIFICATIVA,
        bol_pas.PAGO
    FROM (
        SELECT 
            al.ID "MATRICULA", -- CHAVE
            CONCAT(al.PRIMEIRO_NOME, " ", al.SOBRENOME) "NOME",
            (deslc.CUSTO_IDA + deslc.CUSTO_VOLTA) "CUSTO_DIARIO",
            (deslc.CUSTO_IDA + deslc.CUSTO_VOLTA) * 5 "CUSTO_SEMANAL", -- SEMANA BASE DE 5 dias. Caso necessário trocar 5 pelo número de dias da próxima semana ========
            pres.SEMANA,
            SUM(
                CASE 
                    WHEN pres.STATUS_PRESENCA = 0 THEN 1 
                    ELSE 0 
                END 
            ) "FALTA_SEMANA_ANT" -- contando as faltas da semana anterior
        FROM ALUNOS al 
        INNER JOIN DESLOCAMENTO deslc 
            ON deslc.ID = al.VALE_TRANSPORTE
        INNER JOIN PRESENCAS pres 
            ON pres.ALUNO_ID = al.ID -- CHAVE
        WHERE 
            al.desistente = 0
            AND pres.SEMANA = (SELECT MAX(SEMANA) FROM PRESENCAS)
        GROUP BY 
            al.ID 
    ) custos_desloc
    INNER JOIN BOLETOS_PASSAGENS bol_pas 
        ON bol_pas.ALUNO_ID = custos_desloc.MATRICULA 
        AND bol_pas.SEMANA_REQ = custos_desloc.SEMANA 
) aluno_bolet
ORDER BY 
    11

);

-- BANCO DE DADOS REFERÊNTE AOS ALUNOS 

-- O que a query faz no banco? 
# Analisa o pagamento;
# Calcula o custo de ida e volta diaramente e semanalmente, multiplicando por 5; 
# Analisa as faltas de cada aluno; 

