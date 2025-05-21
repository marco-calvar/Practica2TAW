-- Roles
INSERT INTO roles (nombre) VALUES
('ROL_ADMIN'),
('ROL_DOCENTE'),
('ROL_ESTUDIANTE');

-- Usuarios
INSERT INTO usuarios (username, password, email, nombre, apellido, activo) VALUES
('adminUser', '$2a$10$hashPasswordAdmin', 'admin@universidad.com', 'Admin', 'General', true),
('docenteUser', '$2a$10$hashPasswordDocente', 'docente@universidad.com', 'Juan', 'Perez', true),
('estudianteUser', '$2a$10$hashPasswordEstudiante', 'estudiante@universidad.com', 'Maria', 'Lopez', true);

-- Asignar roles a usuarios
INSERT INTO usuario_roles (usuario_id, rol_id) VALUES
((SELECT id FROM usuarios WHERE username = 'adminUser'), (SELECT id FROM roles WHERE nombre = 'ROL_ADMIN')),
((SELECT id FROM usuarios WHERE username = 'docenteUser'), (SELECT id FROM roles WHERE nombre = 'ROL_DOCENTE')),
((SELECT id FROM usuarios WHERE username = 'estudianteUser'), (SELECT id FROM roles WHERE nombre = 'ROL_ESTUDIANTE'));

-- Personas
INSERT INTO persona (nombre, apellido, email, fecha_nacimiento) VALUES
('Juan', 'Perez', 'juan.perez@universidad.com', '1980-03-15'),
('Maria', 'Lopez', 'maria.lopez@universidad.com', '2000-07-20');

-- Docente vinculado a persona
INSERT INTO docente (id_persona, nro_empleado, departamento, estado, usuario_alta, fecha_alta) VALUES
((SELECT id_persona FROM persona WHERE email = 'juan.perez@universidad.com'), 'D12345', 'Matemáticas', 'activo', 'adminUser', CURRENT_DATE);

-- Estudiante vinculado a persona
INSERT INTO estudiante (id_persona, numero_inscripcion, estado, usuario_alta, fecha_alta) VALUES
((SELECT id_persona FROM persona WHERE email = 'maria.lopez@universidad.com'), 'EST2025001', 'activo', 'adminUser', CURRENT_DATE);

-- Materias
INSERT INTO materia (nombre_materia, codigo_unico, creditos, version) VALUES
('Matemáticas I', 'MAT101', 5, 0),
('Programación I', 'PROG101', 6, 0);

-- Relación prerequisitos (Programación I requiere Matemáticas I)
INSERT INTO materia_prerequisito (id_materia, id_prerequisito) VALUES
((SELECT id_materia FROM materia WHERE codigo_unico = 'PROG101'), (SELECT id_materia FROM materia WHERE codigo_unico = 'MAT101'));

-- Docente - Materia
INSERT INTO docente_materia (id_materia, id_persona) VALUES
((SELECT id_materia FROM materia WHERE codigo_unico = 'MAT101'), (SELECT id_persona FROM persona WHERE email = 'juan.perez@universidad.com'));

-- Inscripción Estudiante - Materia
INSERT INTO estudiante_materia (id_persona, id_materia, fecha_inscripcion, estado, usuario_alta) VALUES
((SELECT id_persona FROM persona WHERE email = 'maria.lopez@universidad.com'), (SELECT id_materia FROM materia WHERE codigo_unico = 'MAT101'), CURRENT_DATE, 'activa', 'adminUser');

-- Evaluación docente
INSERT INTO evaluacion_docente (docente_id, puntuacion, comentario, fecha) VALUES
((SELECT id_persona FROM persona WHERE email = 'juan.perez@universidad.com'), 5, 'Excelente profesor', CURRENT_DATE);
