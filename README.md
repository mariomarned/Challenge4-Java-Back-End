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
- `GET /topicos` - Listar todos los tópicos (con paginación)
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

**Parámetros opcionales:**
- `page=0` - Número de página (default: 0)
- `size=10` - Tamaño de página (default: 10)
- `sort=fechaCreacion,desc` - Ordenamiento

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
  "mensaje": "¿Cómo configurar Spring Security con JWT? - Mensaje actualizado",
  "autor": "Juan Pérez",
  "curso": "Spring Boot Avanzado"
}
```

### 6. Eliminar Tópico

**DELETE** `http://localhost:8080/topicos/1`

**Headers:**
```
Authorization: Bearer {tu-token-jwt}
```

## Estructura del Proyecto

```
src/
├── main/
│   ├── java/com/forohub/
│   │   ├── ForoHubApplication.java
│   │   ├── controller/
│   │   │   ├── AutenticacionController.java
│   │   │   └── TopicoController.java
│   │   ├── domain/
│   │   │   ├── topico/
│   │   │   │   ├── Topico.java
│   │   │   │   ├── StatusTopico.java
│   │   │   │   ├── TopicoRepository.java
│   │   │   │   ├── DatosRegistroTopico.java
│   │   │   │   ├── DatosActualizarTopico.java
│   │   │   │   └── DatosRespuestaTopico.java
│   │   │   └── usuario/
│   │   │       ├── Usuario.java
│   │   │       └── UsuarioRepository.java
│   │   └── infra/
│   │       └── security/
│   │           ├── AutenticacionService.java
│   │           ├── SecurityConfigurations.java
│   │           ├── SecurityFilter.java
│   │           ├── TokenService.java
│   │           └── DatosAutenticacionUsuario.java
│   └── resources/
│       ├── application.properties
│       └── db/migration/
│           ├── V1__create-table-topicos.sql
│           └── V2__create-table-usuarios.sql
```

## Configuración de Seguridad

La aplicación utiliza Spring Security con JWT para la autenticación:

- **Algoritmo JWT:** HMAC256
- **Expiración del token:** 24 horas (configurable)
- **Endpoints públicos:** Solo `/login`
- **Endpoints protegidos:** Todos los demás requieren token válido

## Variables de Entorno

Puedes configurar las siguientes variables de entorno:

```bash
JWT_SECRET=tu-clave-secreta-super-segura
```

## Pruebas

Utiliza Postman o Insomnia para probar los endpoints de la API siguiendo los ejemplos anteriores.

### Colección de Postman

Puedes importar esta colección básica en Postman:

1. Crea una nueva colección llamada "Foro Hub"
2. Agrega los endpoints mencionados arriba
3. Configura una variable de entorno `{{token}}` para reutilizar el JWT
4. Configura una variable `{{baseUrl}}` con valor `http://localhost:8080`

## Solución de Problemas

### Error de Conexión a la Base de Datos
- Verifica que MySQL esté ejecutándose
- Confirma las credenciales en `application.properties`
- Asegúrate de que la base de datos `forohub_db` exista

### Error de Token JWT
- Verifica que el token esté incluido en el header `Authorization`
- Asegúrate de usar el formato: `Bearer {token}`
- Confirma que el token no haya expirado

### Error de Validación
- Revisa que todos los campos obligatorios estén presentes
- Verifica el formato JSON de las peticiones

## Contribución

1. Fork el proyecto
2. Crea una rama para tu feature (`git checkout -b feature/AmazingFeature`)
3. Commit tus cambios (`git commit -m 'Add some AmazingFeature'`)
4. Push a la rama (`git push origin feature/AmazingFeature`)
5. Abre un Pull Request

## Licencia

Este proyecto está bajo la Licencia MIT - ver el archivo [LICENSE.md](LICENSE.md) para detalles.

## Autor

Desarrollado como parte del desafío Foro Hub - Challenge Backend Java Spring Boot

---

⭐ Si este proyecto te fue útil, ¡no olvides darle una estrella!