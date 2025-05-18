-- Função 1: Total pago por usuário
CREATE OR REPLACE FUNCTION func_valor_total_pago(p_usuario_id INT)
RETURNS NUMERIC
LANGUAGE plpgsql
AS $$
DECLARE
    total_pago NUMERIC;
BEGIN
    SELECT COALESCE(SUM(valor_pago), 0)
    INTO total_pago
    FROM reserva
    WHERE usuario_id = p_usuario_id;

    RETURN total_pago;
END;
$$;

-- Função 2: Quantidade de reservas por espaço
CREATE OR REPLACE FUNCTION func_qtd_reservas_por_espaco(p_espaco_id INT)
RETURNS INT
LANGUAGE plpgsql
AS $$
DECLARE
    qtd_reservas INT;
BEGIN
    SELECT COUNT(*)
    INTO qtd_reservas
    FROM reserva r
    JOIN disponibilidade d ON r.disponibilidade_id = d.id
    WHERE d.espaco_id = p_espaco_id;

    RETURN qtd_reservas;
END;
$$;

-- Procedure 1: Listar disponibilidades (com cursor explícito)
CREATE OR REPLACE PROCEDURE proc_listar_disponibilidades(p_espaco_id INT)
LANGUAGE plpgsql
AS $$
DECLARE
    rec RECORD;
    cur CURSOR FOR
        SELECT id, data FROM disponibilidade
        WHERE espaco_id = p_espaco_id
        ORDER BY data;
BEGIN
    RAISE NOTICE 'Listando disponibilidades para o espaço ID: %', p_espaco_id;

    OPEN cur;
    LOOP
        FETCH cur INTO rec;
        EXIT WHEN NOT FOUND;
        RAISE NOTICE 'Disponibilidade ID: %, Data: %', rec.id, rec.data;
    END LOOP;
    CLOSE cur;
END;
$$;

-- Procedure 2: Criar reserva (simples)
CREATE OR REPLACE PROCEDURE proc_criar_reserva(
    p_usuario_id INT,
    p_disponibilidade_id INT,
    p_valor_pago NUMERIC,
    p_taxa_site NUMERIC
)
LANGUAGE plpgsql
AS $$
BEGIN
    INSERT INTO reserva (usuario_id, disponibilidade_id, valor_pago, taxa_site, data_pagamento, data_cancelamento)
    VALUES (
        p_usuario_id,
        p_disponibilidade_id,
        p_valor_pago,
        p_taxa_site,
        NOW(),
        NULL
    );

    RAISE NOTICE 'Reserva criada com sucesso para o usuário ID: %', p_usuario_id;
END;
$$;

-- "Package" principal que chama as procedures/functions
CREATE OR REPLACE PROCEDURE pkg_reservas_gerenciamento(
    p_usuario_id INT,
    p_disponibilidade_id INT,
    p_espaco_id INT
)
LANGUAGE plpgsql
AS $$
DECLARE
    total_pago NUMERIC;
    qtd_reservas INT;
BEGIN
    -- Chama procedure com cursor
    CALL proc_listar_disponibilidades(p_espaco_id);

    -- Chama procedure de criação de reserva
    CALL proc_criar_reserva(p_usuario_id, p_disponibilidade_id, 100.00, 10.00);

    -- Chama function de total pago
    total_pago := func_valor_total_pago(p_usuario_id);
    RAISE NOTICE 'Total pago pelo usuário: R$ %', total_pago;

    -- Chama function de total de reservas no espaço
    qtd_reservas := func_qtd_reservas_por_espaco(p_espaco_id);
    RAISE NOTICE 'Quantidade de reservas no espaço: %', qtd_reservas;
END;
$$;
