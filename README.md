# 🎓 Sistema de Gestión Universitaria

<div align="center">

![Spring Boot](https://img.shields.io/badge/Spring%20Boot-3.2.5-brightgreen.svg)
![Java](https://img.shields.io/badge/Java-21-orange.svg)
![PostgreSQL](https://img.shields.io/badge/PostgreSQL-latest-blue.svg)
![Redis](https://img.shields.io/badge/Redis-latest-red.svg)
![License](https://img.shields.io/badge/License-MIT-green.svg)
![UMSA](https://img.shields.io/badge/UMSA-2025-blue.svg)

<img src="https://upload.wikimedia.org/wikipedia/commons/1/1e/Logo_de_la_Universidad_Mayor_de_San_Andr%C3%A9s.png" alt="UMSA Logo" width="180"/>

</div>

> API REST desarrollada con Spring Boot 3.x para la administración completa de entidades universitarias, incluyendo estudiantes, docentes, materias e inscripciones. Implementa seguridad con JWT y alto rendimiento con caché Redis.

## 📑 Tabla de Contenido

- [Características](#-características)
- [Tecnologías](#-tecnologías)
- [Estructura del Proyecto](#-estructura-del-proyecto)
- [Configuración](#️-configuración)
- [Seguridad y Roles](#️-seguridad-y-roles)
- [API Endpoints](#-api-endpoints)
   - [Inscripciones](#inscripciones)
   - [Estudiantes](#estudiantes)
   - [Docentes](#docentes)
   - [Evaluaciones de Docente](#evaluaciones-de-docente)
   - [Materias](#materias)
   - [Autenticación](#autenticación)
   - [Otros Endpoints](#otros-endpoints)
- [Instalación y Ejecución](#-instalación-y-ejecución)
- [Documentación](#-documentación)
- [Autor](#-autor)

## ✨ Características

- Gestión completa de estudiantes, docentes y materias
- Sistema de inscripciones con validaciones
- Autenticación y autorización basada en JWT
- Caché con Redis para operaciones de alta demanda
- API RESTful con documentación interactiva (Swagger)
- Validaciones personalizadas
- Arquitectura en capas

## 🚀 Tecnologías

| Tecnología | Versión | Propósito |
|------------|---------|-----------|
| Java | 21 | Lenguaje de programación |
| Spring Boot | 3.2.5 | Framework principal |
| Spring Security | - | Seguridad y autenticación |
| JWT | - | Tokens de seguridad |
| Spring Data JPA | - | Persistencia de datos |
| PostgreSQL | Latest | Base de datos relacional |
| Redis | Latest | Sistema de caché |
| Swagger OpenAPI | - | Documentación de API |
| Lombok | - | Reducción de código boilerplate |
| Maven | - | Gestión de dependencias |

## 📂 Estructura del Proyecto

```
mi-proyecto-spring-boot/
├── src/
│   └── main/
│       ├── java/com/universidad/
│       │   ├── config/              # Configuración global 
│       │   ├── controller/          # Controladores REST
│       │   │   ├── DocenteController.java
│       │   │   ├── EstudianteController.java
│       │   │   ├── EvaluacionDocenteController.java
│       │   │   ├── InscripcionController.java
│       │   │   ├── MateriaController.java
│       │   │   └── TestController.java
│       │   ├── dto/                 # Data Transfer Objects
│       │   │   ├── DocenteDTO.java
│       │   │   ├── EstudianteDTO.java
│       │   │   ├── InscripcionDTO.java
│       │   │   └── MateriaDTO.java
│       │   ├── model/               # Entidades JPA
│       │   │   ├── Docente.java
│       │   │   ├── Estudiante.java
│       │   │   ├── EvaluacionDocente.java
│       │   │   ├── Inscripcion.java
│       │   │   ├── Materia.java
│       │   │   └── Persona.java
│       │   ├── registro/            # Autenticación y seguridad
│       │   │   ├── config/
│       │   │   ├── controller/
│       │   │   ├── dto/
│       │   │   ├── model/
│       │   │   ├── repository/
│       │   │   ├── security/
│       │   │   └── service/
│       │   ├── repository/          # Interfaces JPA
│       │   ├── service/             # Servicios de negocio
│       │   │   ├── impl/
│       │   │   ├── IDocenteService.java
│       │   │   ├── IEstudianteService.java
│       │   │   ├── IEvaluacionDocenteService.java
│       │   │   ├── IInscripcionService.java
│       │   │   └── IMateriaService.java
│       │   ├── validation/          # Validadores
│       │   └── UniversidadApplication.java  # Clase principal
│       └── resources/
│           └── application.properties # Configuración
│
├── .mvn/                            # Configuración Maven
├── target/                          # Archivos compilados 
├── .gitignore                       # Configuración Git
├── mvnw                             # Maven Wrapper (Unix)
├── mvnw.cmd                         # Maven Wrapper (Windows)
└── pom.xml                          # Dependencias Maven
```

## ⚙️ Configuración

Edita el archivo `src/main/resources/application.properties` para ajustar la configuración:

```properties
# Base de datos PostgreSQL
spring.datasource.url=jdbc:postgresql://localhost:5432/universidad
spring.datasource.username=tu_usuario
spring.datasource.password=tu_contraseña
spring.jpa.hibernate.ddl-auto=update

# Swagger UI
springdoc.swagger-ui.path=/swagger-ui.html

# Redis para caché
spring.cache.type=redis
spring.redis.host=localhost
spring.redis.port=6379

# Configuración JWT
app.jwtSecret=tu_clave_secreta_jwt
app.jwtExpirationMs=86400000
```

## 🛡️ Seguridad y Roles

El sistema implementa seguridad basada en roles con Spring Security:

- **ADMIN**: Acceso total a todas las funcionalidades
- **DOCENTE**: Gestión de materias y calificaciones
- **ESTUDIANTE**: Consulta de materias e inscripciones

Todas las peticiones a endpoints protegidos requieren un token JWT válido en el encabezado (`Authorization: Bearer [token]`).

## 📡 API Endpoints

### Inscripciones

| Método | Ruta | Descripción | Roles |
|--------|------|-------------|-------|
| GET | `/api/inscripciones` | Listar todas las inscripciones | ADMIN, DOCENTE |
| GET | `/api/inscripciones/{id}` | Obtener inscripción por ID | ADMIN, DOCENTE, ESTUDIANTE |
| POST | `/api/inscripciones` | Crear una nueva inscripción | ESTUDIANTE, ADMIN |
| PUT | `/api/inscripciones/{id}` | Actualizar inscripción por ID | ADMIN |
| PUT | `/api/inscripciones/{id}/abandonar` | Abandonar inscripción | ESTUDIANTE, ADMIN |
| GET | `/api/inscripciones/materia/{idMateria}` | Obtener inscripciones por ID de materia | ADMIN, DOCENTE |
| GET | `/api/inscripciones/estudiante/{idEstudiante}` | Obtener inscripciones por ID de estudiante | ADMIN, DOCENTE, ESTUDIANTE |

### Estudiantes

| Método | Ruta | Descripción | Roles |
|--------|------|-------------|-------|
| GET | `/api/estudiantes` | Listar todos los estudiantes | ADMIN, DOCENTE |
| POST | `/api/estudiantes` | Crear estudiante | ADMIN |
| PUT | `/api/estudiantes/{id}` | Actualizar estudiante por ID | ADMIN |
| PUT | `/api/estudiantes/{id}/baja` | Dar de baja a estudiante por ID | ADMIN |
| GET | `/api/estudiantes/{id}/materias` | Obtener materias de un estudiante | ADMIN, DOCENTE, ESTUDIANTE |
| GET | `/api/estudiantes/{id}/lock` | Obtener estudiante con bloqueo (simulado) | ADMIN |
| GET | `/api/estudiantes/inscripcion/{numeroInscripcion}` | Obtener estudiante por número de inscripción | ADMIN, DOCENTE |
| GET | `/api/estudiantes/activos` | Obtener estudiantes activos | ADMIN, DOCENTE |

### Docentes

| Método | Ruta | Descripción | Roles |
|--------|------|-------------|-------|
| GET | `/api/docentes` | Listar todos los docentes | ADMIN, DOCENTE, ESTUDIANTE |
| POST | `/api/docentes` | Crear docente | ADMIN |
| PUT | `/api/docentes/{id}` | Actualizar docente por ID | ADMIN |
| DELETE | `/api/docentes/{id}` | Eliminar docente por ID | ADMIN |
| GET | `/api/docentes/{nroEmpleado}/materias` | Obtener materias asignadas a docente | ADMIN, DOCENTE |
| GET | `/api/docentes/empleado/{nroEmpleado}` | Obtener docente por número de empleado | ADMIN, DOCENTE |

### Evaluaciones de Docente

| Método | Ruta | Descripción | Roles |
|--------|------|-------------|-------|
| POST | `/api/evaluaciones-docente` | Crear evaluación docente | ESTUDIANTE |
| GET | `/api/evaluaciones-docente/{id}` | Obtener evaluación por ID | ADMIN, DOCENTE |
| DELETE | `/api/evaluaciones-docente/{id}` | Eliminar evaluación por ID | ADMIN |
| GET | `/api/evaluaciones-docente/docente/{docenteId}` | Obtener evaluaciones de un docente | ADMIN, DOCENTE |

### Materias

| Método | Ruta | Descripción | Roles |
|--------|------|-------------|-------|
| GET | `/api/materias` | Listar todas las materias | Todos |
| POST | `/api/materias` | Crear nueva materia | ADMIN, DOCENTE |
| PUT | `/api/materias/{id}` | Actualizar materia | ADMIN, DOCENTE |
| DELETE | `/api/materias/{id}` | Eliminar materia | ADMIN |

### Autenticación

| Método | Ruta | Descripción | Acceso |
|--------|------|-------------|--------|
| POST | `/api/auth/signup` | Registrar usuario nuevo | Público |
| POST | `/api/auth/login` | Iniciar sesión | Público |
| POST | `/api/auth/logout` | Cerrar sesión | Autenticado |
| GET | `/api/auth/session-info` | Información de la sesión actual | Autenticado |

### Otros Endpoints

| Método | Ruta | Descripción | Acceso |
|--------|------|-------------|--------|
| GET | `/api/test/ping` | Endpoint de prueba | Público |
| GET | `/api/public/test` | Endpoint de prueba público | Público |
| GET | `/api/estudiantes/test` | Endpoint de prueba para estudiantes | ESTUDIANTE |
| GET | `/api/docentes/test` | Endpoint de prueba para docentes | DOCENTE |
| GET | `/api/admin/test` | Endpoint de prueba para administradores | ADMIN |

## 📦 Instalación y Ejecución

1. **Clona el repositorio:**
   ```bash
   git clone https://github.com/HAjiMe-0/PracticaTaw.git
   cd PracticaTaw
   ```

2. **Configura la base de datos y Redis:**
   - Instala PostgreSQL y Redis si aún no los tienes
   - Crea una base de datos llamada `universidad`
   - Actualiza `application.properties` con tus credenciales

3. **Construye el proyecto con Maven:**
   ```bash
   mvn clean install
   ```

4. **Ejecuta la aplicación:**
   ```bash
   java -jar target/mi-proyecto-spring-boot-0.0.1-SNAPSHOT.jar
   ```

5. **Accede a la API:**
   - API REST: `http://localhost:8080/api/`
   - Documentación Swagger: `http://localhost:8080/swagger-ui.html`

## 📄 Documentación

- **API Interactiva**: Accede a la documentación Swagger en `http://localhost:8080/swagger-ui.html`
## 👨‍💻 Autor

<div align="center">
  <img src="https://avatars.githubusercontent.com/u/10578?v=4" alt="Perfil" width="100" style="border-radius:50%"/>
  <h3>Harold Ruddy Quispe Hilari</h3>
  <p>CI: 8432642</p>
  <p>Universidad Mayor de San Andrés</p>
  <p>La Paz, Bolivia</p>

[![GitHub](https://img.shields.io/badge/GitHub-HAjiMe--0-181717?style=flat&logo=github)](https://github.com/HAjiMe-0)
[![LinkedIn](https://img.shields.io/badge/LinkedIn-Harold_Quispe-0077B5?style=flat&logo=linkedin)](https://linkedin.com/in/harold-quispe)
</div>

---

<div align="center">
  <img src="https://upload.wikimedia.org/wikipedia/commons/1/1e/Logo_de_la_Universidad_Mayor_de_San_Andr%C3%A9s.png" alt="UMSA Logo" width="120"/>
   <p>© 2025 Universidad Mayor de San Andrés</p>
</div>