# Sistema de Gestión Universitaria

<div align="center">

![Spring Boot](https://img.shields.io/badge/Spring%20Boot-3.2.5-brightgreen.svg)
![Java](https://img.shields.io/badge/Java-21-orange.svg)
![PostgreSQL](https://img.shields.io/badge/PostgreSQL-latest-blue.svg)
![Redis](https://img.shields.io/badge/Redis-latest-red.svg)
![License](https://img.shields.io/badge/License-MIT-green.svg)
![UMSA](https://img.shields.io/badge/UMSA-2025-blue.svg)

<img src="https://upload.wikimedia.org/wikipedia/commons/1/1e/Logo_de_la_Universidad_Mayor_de_San_Andr%C3%A9s.png" alt="UMSA Logo" width="180"/>

</div>

Sistema de gestión académica desarrollado con Spring Boot 3.x para la administración integral de entidades universitarias, incluyendo estudiantes, docentes, materias e inscripciones. Implementa mecanismos de seguridad mediante JWT y optimización de rendimiento con caché Redis.

## Índice

- [Características Principales](#características-principales)
- [Tecnologías Implementadas](#tecnologías-implementadas)
- [Estructura del Proyecto](#estructura-del-proyecto)
- [Configuración del Sistema](#configuración-del-sistema)
- [Seguridad y Control de Acceso](#seguridad-y-control-de-acceso)
- [Endpoints de la API](#endpoints-de-la-api)
   - [Gestión de Inscripciones](#gestión-de-inscripciones)
   - [Gestión de Estudiantes](#gestión-de-estudiantes)
   - [Gestión de Docentes](#gestión-de-docentes)
   - [Sistema de Evaluación Docente](#sistema-de-evaluación-docente)
   - [Administración de Materias](#administración-de-materias)
   - [Sistema de Autenticación](#sistema-de-autenticación)
   - [Endpoints Adicionales](#endpoints-adicionales)
- [Instalación y Despliegue](#instalación-y-despliegue)
- [Documentación Técnica](#documentación-técnica)
- [Información del Desarrollador](#información-del-desarrollador)

## Características Principales

- Administración integral de estudiantes, docentes y materias
- Sistema robusto de inscripciones con validaciones
- Implementación de autenticación y autorización mediante JWT
- Optimización de rendimiento mediante caché Redis
- API RESTful documentada (Swagger)
- Sistema de validaciones personalizado
- Arquitectura por capas

## Tecnologías Implementadas

| Tecnología | Versión | Función Principal |
|------------|---------|-------------------|
| Java | 21 | Lenguaje base de desarrollo |
| Spring Boot | 3.2.5 | Framework de desarrollo |
| Spring Security | - | Marco de seguridad |
| JWT | - | Autenticación mediante tokens |
| Spring Data JPA | - | Persistencia de datos |
| PostgreSQL | Latest | Sistema de base de datos |
| Redis | Latest | Sistema de caché |
| Swagger OpenAPI | - | Documentación de API |
| Lombok | - | Optimización de desarrollo |
| Maven | - | Gestión de dependencias |

## Estructura del Proyecto

```
mi-proyecto-spring-boot/
├── src/
│   └── main/
│       ├── java/com/universidad/
│       │   ├── config/              
│       │   ├── controller/          
│       │   ├── dto/                 
│       │   ├── model/                
│       │   ├── registro/            
│       │   ├── repository/          
│       │   ├── service/             
│       │   ├── validation/          
│       │   └── UniversidadApplication.java
│       └── resources/
│           └── application.properties
│
├── .mvn/                            # Configuración Maven
├── target/                          # Archivos compilados 
├── .gitignore                       # Configuración Git
├── mvnw                             # Maven Wrapper (Unix)
├── mvnw.cmd                         # Maven Wrapper (Windows)
└── pom.xml                          # Dependencias Maven
```

## Configuración del Sistema

El archivo `src/main/resources/application.properties` contiene la configuración principal:

```properties
# Configuración PostgreSQL
spring.datasource.url=jdbc:postgresql://localhost:5432/universidad
spring.datasource.username=usuario_bd
spring.datasource.password=contraseña_bd
spring.jpa.hibernate.ddl-auto=update

# Configuración Swagger
springdoc.swagger-ui.path=/swagger-ui.html

# Configuración Redis
spring.cache.type=redis
spring.redis.host=localhost
spring.redis.port=6379

# Configuración JWT
app.jwtSecret=clave_secreta_jwt
app.jwtExpirationMs=86400000
```

## Seguridad y Control de Acceso

El sistema implementa tres niveles de acceso:

- **Administrador**: Acceso completo al sistema
- **Docente**: Gestión de materias y evaluaciones
- **Estudiante**: Consulta de información académica

Las solicitudes a endpoints protegidos requieren autenticación mediante token JWT.

## Endpoints de la API

### Gestión de Inscripciones

| Método | Ruta | Descripción | Roles |
|--------|------|-------------|-------|
| GET | `/api/inscripciones` | Listar todas las inscripciones | ADMIN, DOCENTE |
| GET | `/api/inscripciones/{id}` | Obtener inscripción por ID | ADMIN, DOCENTE, ESTUDIANTE |
| POST | `/api/inscripciones` | Crear una nueva inscripción | ESTUDIANTE, ADMIN |
| PUT | `/api/inscripciones/{id}` | Actualizar inscripción por ID | ADMIN |
| PUT | `/api/inscripciones/{id}/abandonar` | Abandonar inscripción | ESTUDIANTE, ADMIN |
| GET | `/api/inscripciones/materia/{idMateria}` | Obtener inscripciones por ID de materia | ADMIN, DOCENTE |
| GET | `/api/inscripciones/estudiante/{idEstudiante}` | Obtener inscripciones por ID de estudiante | ADMIN, DOCENTE, ESTUDIANTE |

### Gestión de Estudiantes

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

### Gestión de Docentes

| Método | Ruta | Descripción | Roles |
|--------|------|-------------|-------|
| GET | `/api/docentes` | Listar todos los docentes | ADMIN, DOCENTE, ESTUDIANTE |
| POST | `/api/docentes` | Crear docente | ADMIN |
| PUT | `/api/docentes/{id}` | Actualizar docente por ID | ADMIN |
| DELETE | `/api/docentes/{id}` | Eliminar docente por ID | ADMIN |
| GET | `/api/docentes/{nroEmpleado}/materias` | Obtener materias asignadas a docente | ADMIN, DOCENTE |
| GET | `/api/docentes/empleado/{nroEmpleado}` | Obtener docente por número de empleado | ADMIN, DOCENTE |

### Sistema de Evaluación Docente

| Método | Ruta | Descripción | Roles |
|--------|------|-------------|-------|
| POST | `/api/evaluaciones-docente` | Crear evaluación docente | ESTUDIANTE |
| GET | `/api/evaluaciones-docente/{id}` | Obtener evaluación por ID | ADMIN, DOCENTE |
| DELETE | `/api/evaluaciones-docente/{id}` | Eliminar evaluación por ID | ADMIN |
| GET | `/api/evaluaciones-docente/docente/{docenteId}` | Obtener evaluaciones de un docente | ADMIN, DOCENTE |

### Administración de Materias

| Método | Ruta | Descripción | Roles |
|--------|------|-------------|-------|
| GET | `/api/materias` | Listar todas las materias | Todos |
| POST | `/api/materias` | Crear nueva materia | ADMIN, DOCENTE |
| PUT | `/api/materias/{id}` | Actualizar materia | ADMIN, DOCENTE |
| DELETE | `/api/materias/{id}` | Eliminar materia | ADMIN |

### Sistema de Autenticación

| Método | Ruta | Descripción | Acceso |
|--------|------|-------------|--------|
| POST | `/api/auth/signup` | Registrar usuario nuevo | Público |
| POST | `/api/auth/login` | Iniciar sesión | Público |
| POST | `/api/auth/logout` | Cerrar sesión | Autenticado |
| GET | `/api/auth/session-info` | Información de la sesión actual | Autenticado |

### Endpoints Adicionales

| Método | Ruta | Descripción | Acceso |
|--------|------|-------------|--------|
| GET | `/api/test/ping` | Endpoint de prueba | Público |
| GET | `/api/public/test` | Endpoint de prueba público | Público |
| GET | `/api/estudiantes/test` | Endpoint de prueba para estudiantes | ESTUDIANTE |
| GET | `/api/docentes/test` | Endpoint de prueba para docentes | DOCENTE |
| GET | `/api/admin/test` | Endpoint de prueba para administradores | ADMIN |

## Instalación y Despliegue

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

## Documentación Técnica

- **API Interactiva**: Accede a la documentación Swagger en `http://localhost:8080/swagger-ui.html`

## Información del Desarrollador

<div align="center">
  <img src="https://avatars.githubusercontent.com/u/10578?v=4" alt="Perfil" width="100" style="border-radius:50%"/>
  <h3>Marco Ronaldo Callisaya Vargas</h3>
  <p>Universidad Mayor de San Andrés</p>
  <p>Carrera de Informatica</p>
  <p>La Paz, Bolivia</p>

[![GitHub](https://img.shields.io/badge/Marco-Calvar-181717?style=flat&logo=github)](https://github.com/marco-calvar)
[![LinkedIn](https://img.shields.io/badge/LinkedIn-Harold_Quispe-0077B5?style=flat&logo=linkedin)](https://linkedin.com/in/harold-quispe)
</div>

---

<div align="center">
  <img src="https://upload.wikimedia.org/wikipedia/commons/1/1e/Logo_de_la_Universidad_Mayor_de_San_Andr%C3%A9s.png" alt="UMSA Logo" width="120"/>
   <p>© 2025 Universidad Mayor de San Andrés</p>
</div>