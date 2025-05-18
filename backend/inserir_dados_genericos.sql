-- 1. Inserir usuários
INSERT INTO usuario (nome, data_nascimento, cpf, genero, cep, endereco, complemento, email, telefone) VALUES
('João Silva', '1985-03-12', '11111111111', 'Masculino', '01001-000', 'Rua A, 123', 'Apto 1', 'joao@email.com', '11999990001'),
('Maria Souza', '1990-07-22', '22222222222', 'Feminino', '02002-000', 'Rua B, 456', 'Casa', 'maria@email.com', '11999990002'),
('Alex Lima', '1995-11-30', '33333333333', 'Outros', '03003-000', 'Rua C, 789', 'Fundos', 'alex@email.com', '11999990003');

-- 2. Inserir espaços
INSERT INTO espaco (usuario_id, nome, descricao, valor_diaria, exclusivo, cep, endereco, complemento) VALUES
(1, 'Garagem João', 'Espaço coberto para 2 carros.', 50.00, TRUE, '01001-000', 'Rua A, 123', 'Apto 1'),
(2, 'Quintal Maria', 'Espaço aberto para vendas.', 30.00, FALSE, '02002-000', 'Rua B, 456', 'Casa');

-- 3. Inserir disponibilidades
INSERT INTO disponibilidade (espaco_id, data) VALUES
(1, '2025-05-20'),
(1, '2025-05-21'),
(2, '2025-05-20');

-- 4. Inserir reservas
INSERT INTO reserva (usuario_id, disponibilidade_id, valor_pago, taxa_site, data_pagamento, data_cancelamento) VALUES
(2, 1, 50.00, 5.00, '2025-05-18 10:00:00', '2025-05-19 18:00:00'),
(3, 3, 30.00, 3.00, '2025-05-18 11:00:00', '2025-05-19 19:00:00');

-- 5. Inserir pagamentos
INSERT INTO pagamento (reserva_id, metodo, status, valor_total, data_confirmacao) VALUES
(1, 'Cartão de Crédito', 'Confirmado', 50.00, '2025-05-18 10:05:00'),
(2, 'Pix', 'Confirmado', 30.00, '2025-05-18 11:10:00');

-- 6. Inserir fotos de espaços
INSERT INTO foto_espaco (espaco_id, url_imagem, descricao) VALUES
(1, 'https://example.com/garagem.jpg', 'Garagem coberta com portão automático'),
(2, 'https://example.com/quintal.jpg', 'Quintal amplo com sombra');

-- 7. Inserir cancelamentos
INSERT INTO cancelamento (reserva_id, motivo, data_cancelamento, tipo) VALUES
(1, 'Mudança de planos', '2025-05-19 18:00:00', 'Usuário'),
(2, 'Chuva forte', '2025-05-19 19:00:00', 'Anfitrião');

-- 8. Inserir feedbacks
INSERT INTO feedback (usuario_id, espaco_id, nota, comentario, data) VALUES
(2, 1, 4, 'Espaço limpo e seguro', '2025-05-21 12:00:00'),
(3, 2, 5, 'Ótima localização e vizinhança amigável', '2025-05-21 13:00:00');

