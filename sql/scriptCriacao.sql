DROP TABLE IF EXISTS receita_ingrediente CASCADE;
DROP TABLE IF EXISTS receita CASCADE;
DROP TABLE IF EXISTS produto CASCADE;
DROP TABLE IF EXISTS tabela_nutricional CASCADE;
DROP TABLE IF EXISTS ingrediente CASCADE;
DROP TABLE IF EXISTS admin CASCADE;
DROP TABLE IF EXISTS usuario CASCADE;


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
CREATE TABLE admin(
  id    SERIAL PRIMARY KEY,
  nome    VARCHAR(100) NOT NULL,
  email      VARCHAR(320) NOT NULL UNIQUE,
  senha      VARCHAR(64)  NOT NULL CHECK (LENGTH(Senha) >= 8),
  telefone   VARCHAR(11) NOT NULL UNIQUE,
  nascimento DATE NOT NULL,
  cargo      VARCHAR(64) NOT NULL DEFAULT 'Admin',
  foto       VARCHAR(255) DEFAULT 'Sem foto'
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

  valor_energetico_kcal DECIMAL(6, 2) NOT NULL,
  carboidratos_g DECIMAL(6, 2) NOT NULL,
  acucares_totais_g DECIMAL(6, 2) NOT NULL,
  acucares_adicionados_g DECIMAL(6, 2) NOT NULL,
  proteinas_g DECIMAL(6, 2) NOT NULL,
  gorduras_totais_g DECIMAL(6, 2) NOT NULL,
  gorduras_saturadas_g DECIMAL(6, 2) NOT NULL,
  gorduras_trans_g DECIMAL(6, 2) NOT NULL,
  fibra_alimentar_g DECIMAL(6, 2) NOT NULL,
  sodio_mg DECIMAL(6, 2) NOT NULL,

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
  nome VARCHAR(100) NOT NULL UNIQUE,
  id_usuario INT REFERENCES usuario(id)
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