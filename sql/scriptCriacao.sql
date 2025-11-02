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
  senha VARCHAR(64) NOT NULL,
  telefone VARCHAR(11) NOT NULL UNIQUE CHECK (telefone ~'^\(?[0-9]{2}\)? ?[0-9]{5}-?[0-9]{4}$'),
  empresa VARCHAR(50) DEFAULT 'Empresa Não Informada',
  foto VARCHAR(255) DEFAULT 'Sem foto'
);

-- Criação da tabela admins
CREATE TABLE admin (
  id SERIAL PRIMARY KEY,
  nome VARCHAR(100) NOT NULL,
  email VARCHAR(320) NOT NULL UNIQUE,
  senha VARCHAR(64)  NOT NULL,
  telefone VARCHAR(11) NOT NULL UNIQUE CHECK (telefone ~'^\(?[0-9]{2}\)? ?[0-9]{5}-?[0-9]{4}$'),
  nascimento DATE NOT NULL,
  cargo VARCHAR(64) NOT NULL DEFAULT 'Admin',
  foto VARCHAR(255) DEFAULT 'Sem foto'
);


-- Criação da tabela ingredientes
CREATE TABLE ingrediente (
  id SERIAL PRIMARY KEY,
  nome VARCHAR(100) NOT NULL UNIQUE
);


-- Criação da tabela com a informação nutricional
CREATE TABLE tabela_nutricional (
  id_ingrediente INT NOT NULL PRIMARY KEY REFERENCES ingrediente(id) ON DELETE CASCADE,

  valor_energetico_kcal DECIMAL(6, 2) NOT NULL CHECK (valor_energetico_kcal >= 0),
  carboidratos_g DECIMAL(6, 2) NOT NULL CHECK (carboidratos_g >=0),
  acucares_totais_g DECIMAL(6, 2) NOT NULL CHECK (acucares_totais_g >=0),
  acucares_adicionados_g DECIMAL(6, 2) NOT NULL CHECK (acucares_adicionados_g >=0),
  proteinas_g DECIMAL(6, 2) NOT NULL CHECK (proteinas_g >=0),
  gorduras_totais_g DECIMAL(6, 2) NOT NULL CHECK (gorduras_totais_g >=0),
  gorduras_saturadas_g DECIMAL(6, 2) NOT NULL CHECK (gorduras_saturadas_g >=0),
  gorduras_trans_g DECIMAL(6, 2) NOT NULL CHECK (gorduras_trans_g >=0),
  fibra_alimentar_g DECIMAL(6, 2) NOT NULL CHECK (fibra_alimentar_g >=0),
  sodio_mg DECIMAL(6, 2) NOT NULL CHECK (sodio_mg >=0),

  colesterol_mg DECIMAL(6, 2) DEFAULT 0 CHECK (colesterol_mg >=0),
  vitamina_a_mcg DECIMAL(6, 2) DEFAULT 0 CHECK (vitamina_a_mcg >=0),
  vitamina_c_mg DECIMAL(6, 2) DEFAULT 0 CHECK (vitamina_c_mg >=0),
  vitamina_d_mcg DECIMAL(6, 2) DEFAULT 0 CHECK (vitamina_d_mcg >=0),
  calcio_mg DECIMAL(6, 2) DEFAULT 0 CHECK (calcio_mg >=0),
  ferro_mg DECIMAL(6, 2) DEFAULT 0 CHECK (ferro_mg >=0),
  potassio_mg DECIMAL(6, 2) DEFAULT 0 CHECK (potassio_mg >=0)
);

-- Criação da tabela de produtos
CREATE TABLE produto (
  id SERIAL PRIMARY KEY,
  nome VARCHAR(100) NOT NULL UNIQUE,
  id_usuario INT NOT NULL REFERENCES usuario(id) ON DELETE CASCADE
);

-- Criação da tabela de receitas
CREATE TABLE receita (
  id SERIAL PRIMARY KEY,
  porcao VARCHAR(100) NOT NULL,
  id_produto INT NOT NULL REFERENCES produto(id) ON DELETE CASCADE
);

-- Criação da tabela de conexão de receitas com ingrediente
CREATE TABLE receita_ingrediente (
    id SERIAL PRIMARY KEY,
    id_receita INT NOT NULL REFERENCES receita(id) ON DELETE CASCADE,
    id_ingrediente INT NOT NULL REFERENCES ingrediente(id) ON DELETE CASCADE,
    quantidade DECIMAL(10,2) NOT NULL CHECK (quantidade > 0),
    CONSTRAINT uq_receita_ingrediente UNIQUE (id_receita, id_ingrediente)
);