# Foro Hub - API REST

API REST desarrollada con Spring Boot para la gestión de tópicos de un foro, implementando operaciones CRUD completas y sistema de autenticación JWT.

## Funcionalidades

- ✅ Crear un nuevo tópico
- ✅ Mostrar todos los tópicos creados
- ✅ Mostrar un tópico específico
- ✅ Actualizar un tópico
- ✅ Eliminar un tópico
- ✅ Autenticación y autorización con JWT
- ✅ Validaciones de reglas de negocio
- ✅ Persistencia en base de datos MySQL

## Tecnologías Utilizadas

- Java 17+
- Spring Boot 3+
- Spring Security
- Spring Data JPA
- MySQL
- Flyway Migration
- JWT (JSON Web Token)
- Maven
- Lombok

## Configuración del Proyecto

### Requisitos Previos

- Java JDK 17 o superior
- Maven 4+
- MySQL 8.0+
- IDE de tu preferencia (IntelliJ IDEA, Eclipse, VS Code)

### Instalación

1. **Clona el repositorio**
   ```bash
   git clone <url-del-repositorio>
   cd foro-hub
   ```

2. **Configura la base de datos MySQL**
   ```sql
   CREATE DATABASE forohub_db;
   ```

3. **Actualiza las credenciales en `application.properties`**
   ```properties
   spring.datasource.url=jdbc:mysql://localhost:3306/forohub_db
   spring.datasource.username=tu_usuario
   spring.datasource.password=tu_contraseña
   ```

4. **Compila y ejecuta la aplicación**
   ```bash
   mvn clean install
   mvn spring-boot:run
   ```

5. **Las migraciones se ejecutarán automáticamente con Flyway**

### Usuario de Prueba

- **Login:** admin
- **Password:** 123456

## Endpoints de la API

### Autenticación
- `POST /login` - Autenticar usuario y obtener token JWT

### Tópicos
- `GET /topicos` - Listar todos los tópicos
- `GET /topicos/{id}` - Obtener tópico específico
- `POST /topicos` - Crear nuevo tópico
- `PUT /topicos/{id}` - Actualizar tópico
- `DELETE /topicos/{id}` - Eliminar tópico

## Estructura de la Base de Datos

### Tabla: topicos
- id (BIGINT, PRIMARY KEY, AUTO_INCREMENT)
- titulo (VARCHAR, NOT NULL)
- mensaje (TEXT, NOT NULL)
- fecha_creacion (DATETIME, NOT NULL)
- status (VARCHAR, NOT NULL)
- autor (VARCHAR, NOT NULL)
- curso (VARCHAR, NOT NULL)

### Tabla: usuarios
- id (BIGINT, PRIMARY KEY, AUTO_INCREMENT)
- login (VARCHAR, UNIQUE, NOT NULL)
- clave (VARCHAR, NOT NULL)

## Reglas de Negocio

- Todos los campos son obligatorios al crear/actualizar tópicos
- No se permiten tópicos duplicados (mismo título y mensaje)
- Acceso restringido mediante autenticación JWT
- Tokens JWT con expiración configurable

## Ejemplos de Uso

### 1. Autenticación

**POST** `http://localhost:8080/login`

```json
{
  "login": "admin",
  "clave": "123456"
}
```

**Respuesta:**
```json
{
  "token": "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9..."
}
```

### 2. Crear un Tópico

**POST** `http://localhost:8080/topicos`

**Headers:**
```
Authorization: Bearer {tu-token-jwt}
Content-Type: application/json
```

**Body:**
```json
{
  "titulo": "Duda sobre Spring Boot",
  "mensaje": "¿Cómo configurar Spring Security con JWT?",
  "autor": "Juan Pérez",
  "curso": "Spring Boot"
}
```

### 3. Listar Tópicos

**GET** `http://localhost:8080/topicos`

**Headers:**
```
Authorization: Bearer {tu-token-jwt}
```

### 4. Obtener Tópico por ID

**GET** `http://localhost:8080/topicos/1`

**Headers:**
```
Authorization: Bearer {tu-token-jwt}
```

### 5. Actualizar Tópico

**PUT** `http://localhost:8080/topicos/1`

**Headers:**
```
Authorization: Bearer {tu-token-jwt}
Content-Type: application/json
```

**Body:**
```json
{
  "id": 1,
  "titulo": "Duda sobre Spring Boot - Actualizada",
  "mensaje": "¿Cómo configurar Spring Security con JWT? - Mensaje actualizado"
}
```

### 6. Eliminar Tópico

**DELETE** `http://localhost:8080/topicos/1`

**Headers:**
```
Authorization: Bearer {tu-token-jwt}
```

## Pruebas

Utiliza Postman o Insomnia para probar los endpoints de la API siguiendo los ejemplos anteriores.

## Autor

Desarrollado como parte del desafío Foro Hub