CREATE TABLE usuarios (
    id BIGINT NOT NULL AUTO_INCREMENT,
    login VARCHAR(100) NOT NULL UNIQUE,
    clave VARCHAR(300) NOT NULL,
    
    PRIMARY KEY (id)
);

-- Insertar usuario de prueba (password: 123456)
INSERT INTO usuarios (login, clave) VALUES 
('admin', '$2a$10$Y50UaMFOxteibQEYLrwuAOiadK8JNkWaVBffkYAiQqhQtzZoy.Oa6');