-- Create the test database
CREATE DATABASE dbEcommerce;
GO
USE dbEcommerce;
EXEC sys.sp_cdc_enable_db;

-- Create and populate our products using a single insert with many rows
CREATE TABLE produtos (
  id INTEGER IDENTITY(1,1) NOT NULL PRIMARY KEY,
  nome VARCHAR(255) NOT NULL,
  descricao VARCHAR(512),
  valor decimal(10,2),
  quantidade INTEGER
);
INSERT INTO produtos(nome,descricao, valor, quantidade)  VALUES ('Lapis','lapis de escrever', 1.50, 100);

EXEC sys.sp_cdc_enable_table @source_schema = 'dbo', @source_name = 'produtos', @role_name = NULL, @supports_net_changes = 0;


CREATE TABLE pedidos (
  id INTEGER IDENTITY(1,1) NOT NULL PRIMARY KEY  ,
  dataPedido datetime
);
EXEC sys.sp_cdc_enable_table @source_schema = 'dbo', @source_name = 'pedidos', @role_name = NULL, @supports_net_changes = 0;

CREATE TABLE pedidosDetalhes (
  id INTEGER IDENTITY(1,1) NOT NULL PRIMARY KEY  ,
  idPedido INTEGER NOT NULL, 
  idProduto INTEGER NOT NULL, 
  constraint pedido_detalhes foreign key (idPedido) references pedidos(id) ,
  constraint pedido_produto foreign key (idProduto) references produtos(id));

EXEC sys.sp_cdc_enable_table @source_schema = 'dbo', @source_name = 'pedidosDetalhes', @role_name = NULL, @supports_net_changes = 0;


GO