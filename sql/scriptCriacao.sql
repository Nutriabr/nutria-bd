-- Criação da tabela usuarios
CREATE TABLE usuario (
  id SERIAL PRIMARY KEY,
  nome VARCHAR(100) NOT NULL,
  email VARCHAR(320) NOT NULL UNIQUE,
  senha VARCHAR(64) NOT NULL CHECK (LENGTH(senha) >= 8),
  telefone VARCHAR(11) NOT NULL UNIQUE,
  empresa VARCHAR(50) DEFAULT 'Empresa Não Informada',
  foto VARCHAR(255) DEFAULT 'Sem foto'
);

-- Criação da tabela admins
CREATE TABLE admin (
  id SERIAL PRIMARY KEY,
  nome VARCHAR(100) NOT NULL,
  email VARCHAR(320) NOT NULL UNIQUE,
  senha VARCHAR(64) NOT NULL CHECK (LENGTH(senha) >= 8)
);

-- Criação da tabela ingredientes
CREATE TABLE ingrediente (
  id SERIAL PRIMARY KEY,
  nome VARCHAR(100) NOT NULL UNIQUE
);


-- Criação da tabela com a informação nutricional
CREATE TABLE tabela_nutricional (
  -- PK é a mesma do ingrediente, criando uma relação 1-1
  id_ingrediente INT PRIMARY KEY REFERENCES ingrediente(id),

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
  potassio_mg DECIMAL(6, 2) DEFAULT 0
);

-- Criação da tabela de produtos
CREATE TABLE produto (
  id SERIAL PRIMARY KEY,
  nome VARCHAR(100) NOT NULL UNIQUE
);

-- Criação da tabela de receitas
CREATE TABLE receita (
  id SERIAL PRIMARY KEY,
  porcao VARCHAR(100) NOT NULL,
  id_produto INT REFERENCES produto(id)
);

-- Criação da tabela de conexão de receitas com ingrediente
CREATE TABLE receita_ingrediente (
  id_receita INT NOT NULL,
  id_ingrediente INT NOT NULL,
  quantidade DECIMAL(6, 2) NOT NULL,
  PRIMARY KEY (id_receita, id_ingrediente),
  FOREIGN KEY (id_receita) REFERENCES receita(id),
  FOREIGN KEY (id_ingrediente) REFERENCES ingrediente(id)
);