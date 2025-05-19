-- Nao aparece nada porque nao tem ninguem com a data adm falada(Relatorio 1)
SELECT 
    e.nome AS "Nome Empregado",
    e.cpf AS "CPF Empregado",
    e.dataAdm AS "Data de Admissão",
    e.salario AS "Salário",
    d.nome AS "Departamento",
    t.numero AS "Número de Telefone"
FROM 
    empregado e
JOIN 
    departamento d ON e.Departamento_idDepartamento = d.idDepartamento
LEFT JOIN 
    telefone t ON e.cpf = t.Empregado_cpf
WHERE 
    e.dataAdm BETWEEN '2019-01-01' AND '2022-03-31'
ORDER BY 
    e.dataAdm DESC;
-- esse proximo mudei a data (Relatorio 1)
SELECT 
    e.nome AS "Nome Empregado",
    e.cpf AS "CPF Empregado",
    e.dataAdm AS "Data de Admissão",
    e.salario AS "Salário",
    d.nome AS "Departamento",
    t.numero AS "Número de Telefone"
FROM 
    empregado e
JOIN 
    departamento d ON e.Departamento_idDepartamento = d.idDepartamento
LEFT JOIN 
    telefone t ON e.cpf = t.Empregado_cpf
WHERE 
    e.dataAdm BETWEEN '2019-01-01' AND '2023-03-31'
ORDER BY 
    e.dataAdm DESC;
    -- Relatorio 2
    SELECT 
    e.nome AS "Nome Empregado",
    e.cpf AS "CPF Empregado",
    e.dataAdm AS "Data de Admissão",
    e.salario AS "Salário",
    d.nome AS "Departamento",
    t.numero AS "Número de Telefone"
FROM 
    empregado e
JOIN 
    departamento d ON e.Departamento_idDepartamento = d.idDepartamento
LEFT JOIN 
    telefone t ON e.cpf = t.Empregado_cpf
WHERE 
    e.salario < (
        SELECT AVG(salario)
        FROM empregado
    )
ORDER BY 
    e.nome ASC;
-- Relatorio 3
SELECT 
    d.nome AS "Departamento",
    COUNT(e.cpf) AS "Quantidade de Empregados",
    ROUND(AVG(e.salario), 2) AS "Média Salarial",
    ROUND(AVG(e.comissao), 2) AS "Média da Comissão"
FROM 
    departamento d
LEFT JOIN 
    empregado e ON e.Departamento_idDepartamento = d.idDepartamento
GROUP BY 
    d.nome
ORDER BY 
    d.nome ASC;
    -- Relatorio 4
    SELECT 
    e.nome AS 'Nome Empregado',
    e.cpf AS 'CPF Empregado',
    e.sexo AS 'Sexo',
    e.salario AS 'Salário',
    COUNT(v.idVenda) AS 'Quantidade Vendas',
    COALESCE(SUM(v.valor), 0) AS 'Total Valor Vendido',
    COALESCE(SUM(v.comissao), 0) AS 'Total Comissão das Vendas'
FROM 
    empregado e
LEFT JOIN 
    venda v ON e.cpf = v.Empregado_cpf
GROUP BY 
    e.cpf, e.nome, e.sexo, e.salario
ORDER BY 
    COUNT(v.idVenda) DESC;
    -- Relatorio 5
SELECT 
    e.nome AS 'Nome Empregado',
    e.cpf AS 'CPF Empregado',
    e.sexo AS 'Sexo',
    e.salario AS 'Salário',
    COUNT(DISTINCT v.idVenda) AS 'Quantidade Vendas com Serviço',
    COALESCE(SUM(s.valorVenda), 0) AS 'Total Valor Vendido com Serviço',
    COALESCE(SUM(v.comissao * (s.valorVenda/v.valor)), 0) AS 'Total Comissão das Vendas com Serviço'
FROM 
    empregado e
JOIN 
    venda v ON e.cpf = v.Empregado_cpf
JOIN 
    itensservico iv ON v.idVenda = iv.Venda_idVenda
JOIN
    servico s ON iv.Servico_idServico = s.idServico
GROUP BY 
    e.cpf, e.nome, e.sexo, e.salario
ORDER BY 
    COUNT(DISTINCT v.idVenda) DESC;
    -- Relatorio 6
    SELECT
    p.nome AS 'Nome do Pet',
    v.data AS 'Data do Serviço',
    s.nome AS 'Nome do Serviço',
    COUNT(*) AS 'Quantidade',
    s.valorVenda AS 'Valor',
    e.nome AS 'Empregado que realizou o Serviço'
FROM
    pet p
JOIN
    venda v ON p.Cliente_cpf = v.Cliente_cpf
JOIN
    itensservico iv ON v.idVenda = iv.Venda_idVenda
JOIN
    servico s ON iv.Servico_idServico = s.idServico
JOIN
    empregado e ON v.Empregado_cpf = e.cpf
GROUP BY
    p.nome, v.data, s.nome, s.valorVenda, e.nome
ORDER BY
    v.data DESC;
    -- Relatorio 7
SELECT
    v.data AS 'Data da Venda',
    v.valor AS 'Valor',
    v.desconto AS 'Desconto',
    (v.valor - COALESCE(v.desconto, 0)) AS 'Valor Final',
    e.nome AS 'Empregado que realizou a venda'
FROM
    venda v
JOIN
    cliente c ON v.Cliente_cpf = c.cpf
JOIN
    empregado e ON v.Empregado_cpf = e.cpf
ORDER BY
    v.data DESC;
    -- Relatorio 8
SELECT
    s.nome AS 'Nome do Serviço',
    COUNT(iv.Servico_idServico) AS 'Quantidade Vendas',
    SUM(s.valorVenda) AS 'Total Valor Vendido'
FROM
    servico s
JOIN
    itensservico iv ON s.idServico = iv.Servico_idServico
JOIN
    venda v ON iv.Venda_idVenda = v.idVenda
GROUP BY
    s.idServico, s.nome
ORDER BY
    COUNT(iv.Servico_idServico) DESC
LIMIT 10;
-- Relatorio 9
SELECT
    fp.tipo AS 'Tipo Forma Pagamento',
    COUNT(fp.Venda_idVenda) AS 'Quantidade Vendas',
    SUM(fp.valorPago) AS 'Total Valor Vendido'
FROM
    formapgvenda fp
GROUP BY
    fp.tipo
ORDER BY
    COUNT(fp.Venda_idVenda) DESC;
    -- Relatorio 10
    SELECT
    DATE(v.data) AS 'Data Venda',
    COUNT(v.idVenda) AS 'Quantidade de Vendas',
    SUM(v.valor) AS 'Valor Total Venda'
FROM
    venda v
GROUP BY
    DATE(v.data)
ORDER BY
    DATE(v.data) DESC;
    -- Relatorio 11
SELECT
    p.nome AS 'Produto',
    p.marca AS 'Marca',
    f.nome AS 'Fornecedor',
    IFNULL(
        (SELECT GROUP_CONCAT(DISTINCT numero SEPARATOR ' / ') 
         FROM telefone 
         WHERE Fornecedor_cpf_cnpj = f.cpf_cnpj),
        'Sem telefone cadastrado'
    ) AS 'Telefones'
FROM
    produtos p
JOIN fornecedor f ON 
    p.nome LIKE CONCAT('%', SUBSTRING_INDEX(f.nome, ' ', 1), '%') OR
    p.marca LIKE CONCAT('%', SUBSTRING_INDEX(f.nome, ' ', 1), '%')
GROUP BY
    p.idProduto, p.nome, p.marca, f.nome, f.cpf_cnpj
ORDER BY
    p.nome;
    -- Relatorio 12
    SELECT
    p.nome AS 'Nome Produto',
    SUM(iv.quantidade) AS 'Quantidade (Total) Vendas',
    SUM(iv.quantidade * iv.valor) AS 'Valor Total Recebido'
FROM
    produtos p
JOIN
    itensvendaprod iv ON p.idProduto = iv.Produto_idProduto
GROUP BY
    p.idProduto, p.nome
ORDER BY
    SUM(iv.quantidade) DESC;


  


  



