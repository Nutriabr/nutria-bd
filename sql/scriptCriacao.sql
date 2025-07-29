-- Criação da tabela usuario
CREATE TABLE usuario (
  id SERIAL PRIMARY KEY,
  nome VARCHAR(100) NOT NULL,
  email VARCHAR(320) NOT NULL UNIQUE,
  senha VARCHAR(64) NOT NULL,
  telefone VARCHAR(25) NOT NULL,
  empresa VARCHAR(50) DEFAULT 'Empresa Não Informada',
  foto VARCHAR(255),
  
  -- Restrições CHECK
  CHECK (LENGTH(senha) >= 8),
  CHECK (LENGTH(telefone) BETWEEN 8 AND 15)
);

-- Criação da tabela admins
CREATE TABLE admins(
  id SERIAL PRIMARY KEY,
  nome VARCHAR(100) NOT NULL,
  email VARCHAR(320) NOT NULL UNIQUE,
  senha VARCHAR(64) NOT NULL

  -- Restrições CHECK
  CHECK (LENGTH(senha) >= 8),
);