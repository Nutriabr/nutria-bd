-- Criação da tabela usuarios
CREATE TABLE usuarios (
  id SERIAL PRIMARY KEY,
  nome VARCHAR(100) NOT NULL,
  email VARCHAR(320) NOT NULL UNIQUE,
  senha VARCHAR(64) NOT NULL CHECK (LENGTH(senha) >= 8),
  telefone VARCHAR(11) NOT NULL,
  empresa VARCHAR(50) DEFAULT 'Empresa Não Informada',
  foto VARCHAR(255) DEFAULT 'Sem foto'
);

-- Criação da tabela admins
CREATE TABLE admins (
  id SERIAL PRIMARY KEY,
  nome VARCHAR(100) NOT NULL,
  email VARCHAR(320) NOT NULL UNIQUE,
  senha VARCHAR(64) NOT NULL CHECK (LENGTH(senha) >= 8)
);

-- Criação da tabela ingredientes
CREATE TABLE ingredientes (
  id SERIAL PRIMARY KEY,
  nome VARCHAR(100) NOT NULL UNIQUE
);

-- Criação da tabela com a informação nutricional
CREATE TABLE tabela_nutricional (
  -- PK é a mesma do ingrediente, criando uma relação 1-1
  id_ingrediente INT PRIMARY KEY REFERENCES ingredientes(id),

  valor_energetico_kcal DECIMAL(6, 2) NOT NULL DEFAULT 0,
  carboidratos_g DECIMAL(6, 2) NOT NULL DEFAULT 0,
  acucares_totais_g DECIMAL(6, 2) NOT NULL DEFAULT 0,
  acucares_adicionados_g DECIMAL(6, 2) NOT NULL DEFAULT 0,
  proteinas_g DECIMAL(6, 2) NOT NULL DEFAULT 0,
  gorduras_totais_g DECIMAL(6, 2) NOT NULL DEFAULT 0,
  gorduras_saturadas_g DECIMAL(6, 2) NOT NULL DEFAULT 0,
  fibra_alimentar_g DECIMAL(6, 2) NOT NULL DEFAULT 0,
  sodio_mg DECIMAL(6, 2) NOT NULL DEFAULT 0,

  colesterol_mg DECIMAL(6, 2) DEFAULT 0,
  vitamina_a_mcg DECIMAL(6, 2) DEFAULT 0,
  vitamina_c_mg DECIMAL(6, 2) DEFAULT 0,
  vitamina_d_mcg DECIMAL(6, 2) DEFAULT 0,
  calcio_mg DECIMAL(6, 2) DEFAULT 0,
  ferro_mg DECIMAL(6, 2) DEFAULT 0,
  potassio_mg DECIMAL(6, 2) DEFAULT 0,
);

-- Criação da tabela de produtos
CREATE TABLE produtos (
  id SERIAL PRIMARY KEY,
  nome VARCHAR(100) NOT NULL UNIQUE
);

-- Criação da tabela de receitas
CREATE TABLE receitas (
  id SERIAL PRIMARY KEY,
  nome VARCHAR(100) NOT NULL UNIQUE,
  porcao VARCHAR(100) NOT NULL,
  id_produto INT REFERENCES produtos(id)
);

-- Criação da tabela de conexão de receitas com ingrediente
CREATE TABLE receita_ingredientes (
  id_receita INT NOT NULL,
  id_ingrediente INT NOT NULL,
  quantidade DECIMAL(6, 2) NOT NULL,
  PRIMARY KEY (id_receita, id_ingrediente),
  FOREIGN KEY (id_receita) REFERENCES receitas(id),
  FOREIGN KEY (id_ingrediente) REFERENCES ingredientes(id)
);

-- Insert na tabela de produtos
INSERT INTO produtos (nome) VALUES
('Bolo de chocolate');

-- Insert na tabelas de ingredientes
INSERT INTO ingredientes (nome) VALUES
('Farinha de Trigo'),
('Ovo'),
('Açúcar'),
('Leite'),
('Fermento em Pó'),
('Chocolate em Pó'),
('Óleo');

-- Cada ingrediente baseado em 100g
INSERT INTO tabela_nutricional (id_ingrediente, valor_energetico_kcal, carboidratos_g, proteinas_g, gorduras_totais_g, sodio_mg) VALUES
(1, 364.00, 76.31, 10.33, 0.98, 2.00), -- Farinha
(2, 155.00, 1.12, 12.58, 11.00, 124.00), -- Ovo
(3, 387.00, 99.98, 0.00, 0.00, 1.00), -- Açúcar
(4, 42.00, 4.80, 3.40, 1.00, 44.00), -- Leite
(5, 76.00, 19.00, 0.00, 0.00, 290.00), --Fermento
(6, 228.00, 57.90, 20.00, 14.00, 21.00), --Chocolate
(7, 884.00, 0.00, 0.00, 100.00, 0.00); -- Óleo

INSERT INTO receitas (nome, porcao, id_produto) VALUES
('Bolo de Chocolate Simples', '200g', 1);

-- Insert ingredientes da receita na tabela de conexão
INSERT INTO receita_ingredientes (id_receita, id_ingrediente, quantidade) VALUES
(1, 1, 250.00), -- Farnha
(1, 2, 3.00), -- Ovos
(1, 3, 200.00), --Açúcar
(1, 4, 240.00), --Leite
(1, 5, 10.00), -- Fermento
(1, 6, 50.00), -- Chocolate
(1, 7, 120.00); -- Óleo

-- Insert na tabela de usuários
INSERT INTO usuarios (nome, email, senha, telefone, empresa, foto) VALUES
('João da Silva', 'joao.silva@exemplo.com', 'senha_segura123', '11987654321', 'Tecnologia SA', DEFAULT),
('Maria Souza', 'maria.souza@exemplo.com', 'senha_maisforte456', '21912345678', DEFAULT, DEFAULT),
('Pedro Santos', 'pedro.santos@exemplo.com', 'outra_senha789', '31998765432', 'Empresa de Teste Ltda', 'https://exemplo.com/fotos/pedro.jpg');

-- Insert na tabela de administradores
INSERT INTO admins (nome, email, senha) VALUES
('Ana Paula', 'ana.paula@empresa.com', 'admin_senha_muito_forte_123'),
('Carlos Oliveira', 'carlos.o@empresa.com', 'senha_do_carlos_9876');

SELECT 
  r.nome AS nome_receita,
  r.porcao,
  SUM(ri.quantidade * (tn.proteinas_g) / 100) AS Proteinas_g,
  SUM(ri.quantidade * (tn.carboidratos_g) / 100) AS Carboidratos_g,
  SUM(ri.quantidade * (tn.gorduras_totais_g) / 100) AS Gorduras_g,
  SUM(ri.quantidade * (tn.valor_energetico_kcal) / 100) AS Valor_energetico_kcal
FROM receitas receita
JOIN receita_ingredientes ri ON r.id = ri.id_receita
JOIN tabela_nutricional tn ON ri.id_ingrediente = tn.id_ingrediente 
WHERE r.id = 1
GROUP BY r.nome, r.porcao;