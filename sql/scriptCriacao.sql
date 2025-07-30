-- Criação da tabela usuarios
CREATE TABLE usuarios (
  id SERIAL PRIMARY KEY,
  nome VARCHAR(100) NOT NULL,
  email VARCHAR(320) NOT NULL UNIQUE,
  senha VARCHAR(64) NOT NULL CHECK (LENGTH(senha) >= 8),
  telefone VARCHAR(25) NOT NULL CHECK (LENGTH(telefone) BETWEEN 8 AND 15),
  empresa VARCHAR(50) DEFAULT 'Empresa Não Informada',
  foto VARCHAR(255)
);

-- Criação da tabela admins
CREATE TABLE admins (
  id SERIAL PRIMARY KEY,
  nome VARCHAR(100) NOT NULL,
  email VARCHAR(320) NOT NULL UNIQUE,
  senha VARCHAR(64) NOT NULL CHECK (LENGTH(senha) >= 8)
);

-- Criação da tabela de nutrientes
CREATE TABLE nutrientes (
  id SERIAL PRIMARY KEY,
  
  -- Nutrientes obrigatórios
  carboidratos VARCHAR(50) NOT NULL CHECK (carboidratos LIKE '%g'),
  acucares_totais VARCHAR(50) NOT NULL CHECK (acucares_totais LIKE '%g'),
  acucares_adicionados VARCHAR(50) NOT NULL CHECK (acucares_adicionados LIKE '%g'),
  proteinas VARCHAR(50) NOT NULL CHECK (proteinas LIKE '%g'),
  gorduras_totais VARCHAR(50) NOT NULL CHECK (gorduras_totais LIKE '%g'),
  gorduras_saturadas VARCHAR(50) NOT NULL CHECK (gorduras_saturadas LIKE '%g'),
  gorduras_trans VARCHAR(50) NOT NULL CHECK (gorduras_trans LIKE '%g'),
  fibra_alimentar VARCHAR(50) NOT NULL CHECK (fibra_alimentar LIKE '%g'),
  sodio VARCHAR(50) NOT NULL CHECK (sodio LIKE '%mg'),
  
  -- Nutrientes opcionais
  colesterol VARCHAR(50) DEFAULT '0mg' CHECK (colesterol LIKE '%mg'),
  vitamina_A VARCHAR(50) DEFAULT '0µg RE' CHECK (vitamina_A LIKE '%µg RE'),
  vitamina_C VARCHAR(50) DEFAULT '0mg' CHECK (vitamina_C LIKE '%mg'),
  vitamina_D VARCHAR(50) DEFAULT '0µg' CHECK (vitamina_D LIKE '%µg'),
  calcio VARCHAR(50) DEFAULT '0mg' CHECK (calcio LIKE '%mg'),
  ferro VARCHAR(50) DEFAULT '0mg' CHECK (ferro LIKE '%mg'),
  potassio VARCHAR(50) DEFAULT '0mg' CHECK (potassio LIKE '%mg'),
  magnesio VARCHAR(50) DEFAULT '0mg' CHECK (magnesio LIKE '%mg'),
  zinco VARCHAR(50) DEFAULT '0mg' CHECK (zinco LIKE '%mg'),
  fosforo VARCHAR(50) DEFAULT '0mg' CHECK (fosforo LIKE '%mg')
);

-- Criação da tabela de ingredientes
CREATE TABLE ingredientes (
  id SERIAL PRIMARY KEY,
  nome VARCHAR(100) NOT NULL UNIQUE,
  quantidade INT NOT NULL,
  id_nutrientes INT REFERENCES nutrientes(id)
);


