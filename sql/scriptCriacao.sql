-- Criação da Tabela usuario
CREATE TABLE usuario (
  id SERIAL PRIMARY KEY,
  nome_completo VARCHAR(30) NOT NULL,
  endereco_email VARCHAR(320) NOT NULL UNIQUE,
  senha VARCHAR(64) NOT NULL,
  telefone VARCHAR(25) NOT NULL,
  empresa VARCHAR(50) DEFAULT 'Empresa Não Informada',
  foto VARCHAR(255),
  
  -- Restrições CHECK
  CHECK (LENGTH(senha) >= 8),
  CHECK (LENGTH(telefone) BETWEEN 8 AND 15)
);