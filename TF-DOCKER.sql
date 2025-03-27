create database loja;
use loja;

CREATE TABLE clientes (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    telefone VARCHAR(20)
);

CREATE TABLE usuarios (
    id INT AUTO_INCREMENT PRIMARY KEY,
    usuario VARCHAR(50) UNIQUE NOT NULL,
    senha VARCHAR(255) NOT NULL,
    cliente_id INT, 
    FOREIGN KEY (cliente_id) REFERENCES clientes(id)
);

DELIMITER //

CREATE PROCEDURE inserir_cliente_usuario(
    IN p_nome_cliente VARCHAR(100),
    IN p_email_cliente VARCHAR(100),
    IN p_telefone_cliente VARCHAR(20),
    IN p_endereco_cliente VARCHAR(255),
    IN p_usuario_usuario VARCHAR(50),
    IN p_senha_usuario VARCHAR(255)
)
BEGIN
    INSERT INTO clientes (nome, email, telefone, endereco) 
    VALUES (p_nome_cliente, p_email_cliente, p_telefone_cliente);
    
    INSERT INTO usuarios (usuario, senha, cliente_id)
    VALUES (p_usuario_usuario, p_senha_usuario, LAST_INSERT_ID());
END //

DELIMITER ;

DELIMITER //

CREATE PROCEDURE selecionar_clientes_usuarios()
BEGIN
    SELECT c.id AS cliente_id, c.nome AS cliente_nome, c.email AS cliente_email, c.telefone AS cliente_telefone
           u.id AS usuario_id, u.usuario AS usuario_nome
    FROM clientes c
    LEFT JOIN usuarios u ON c.id = u.cliente_id;
END //

DELIMITER ;

DELIMITER //

CREATE PROCEDURE atualizar_cliente_usuario(
    IN p_cliente_id INT,
    IN p_nome_cliente VARCHAR(100),
    IN p_email_cliente VARCHAR(100),
    IN p_telefone_cliente VARCHAR(20),
    IN p_usuario_usuario VARCHAR(50),
    IN p_senha_usuario VARCHAR(255)
)

BEGIN
    UPDATE clientes 
    SET nome = p_nome_cliente, email = p_email_cliente, telefone = p_telefone_cliente
    WHERE id = p_cliente_id;
    
    UPDATE usuarios 
    SET usuario = p_usuario_usuario, senha = p_senha_usuario
    WHERE cliente_id = p_cliente_id;
END //
DELIMITER ;

DELIMITER //
CREATE PROCEDURE excluir_cliente_usuario(
    IN p_cliente_id INT
)
BEGIN
    DELETE FROM usuarios WHERE cliente_id = p_cliente_id;
    DELETE FROM clientes WHERE id = p_cliente_id;
END //
DELIMITER ;
