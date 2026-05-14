-- QUERY EXAMPLE
SELECT 
    name AS program
FROM university.programs
WHERE faculty_id = 6
LIMIT 5;

-- Mostrar los estudiantes que vean
-- los programas de Ing Sistemas 
-- y vayan en 5to semestre o superior
SELECT 
    u.first_name, 
    u.last_name, 
    p.name AS programa, 
    ps.semester
FROM university.users u
JOIN university.programs_students ps ON u.user_id = ps.user_id
JOIN university.programs p ON ps.program_id = p.program_id
WHERE p.name ILIKE '%Sistemas%' 
  AND ps.semester >= 5;


-- Obtener el nombre completo y el correo
-- de los profesores de la Universidad.
-- ||' '||

SELECT 
    first_name || ' ' || last_name AS full_name,
    email
FROM 
    university.users
JOIN 
    university.roles 
ON 
    university.users.role_id = university.roles.role_id
WHERE 
    university.roles.name = 'Professor';

-- Listar los cursos que se dan en mas de una
-- facultad


SELECT 
    c.name AS curso, 
    COUNT(DISTINCT p.faculty_id) AS num_facultades
FROM 
    university.courses c
JOIN 
    university.programs_courses pc 
ON 
    c.course_id = pc.course_id
JOIN 
    university.programs p 
ON 
    pc.program_id = p.program_id
JOIN 
    university.faculties f 
ON 
    p.faculty_id = f.faculty_id
GROUP BY 
    c.name
HAVING 
    COUNT(DISTINCT p.faculty_id) > 1;


