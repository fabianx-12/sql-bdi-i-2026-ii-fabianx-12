-- Obtener el total de programas por cada facultad
-- ordenado de la facultad con mas programas hacia abajo.
SELECT
    T1.name AS faculty,
    COUNT(*) AS total_programs

FROM university.faculties T1
INNER JOIN university.programs T2
    ON T1.faculty_id = T2.faculty_id
GROUP BY T1.name
ORDER BY total_programs DESC;

-- Obtener el total de estudiantes registrados en el sistema
-- que tengan el rol de estudiante.
-- Tipo de JOIN: INNER
-- Agregación: COUNT

SELECT
    COUNT(*) AS total_students
FROM university.users u
JOIN university.roles r ON u.role_id = r.role_id
WHERE r.name = 'Student';  

-- Obtener la capacidad máxima entre todas las ofertas de curso
-- que se dictan en un edificio específico.
-- Tipo de JOIN: INNER
-- Agregación: MAX

SELECT
    MAX(co.capacity) AS max_capacity
FROM university.course_offerings co
JOIN university.classrooms cl ON co.classroom_id = cl.classroom_id
JOIN university.buildings b ON cl.building_id = b.building_id
WHERE b.name = 'Edificio Central';

-- Obtener la capacidad mínima registrada entre todas las ofertas
-- de curso disponibles, mostrando el nombre del curso asociado.
-- Tipo de JOIN: INNER
-- Agregación: MIN

SELECT
    c.name AS course,
    MIN(co.capacity) AS min_capacity
FROM university.course_offerings co
JOIN university.courses c ON co.course_id = c.course_id
GROUP BY c.name;



-- Obtener la suma total de capacidad disponible en todas las
-- ofertas de curso que pertenecen a una facultad específica.
-- Tipo de JOIN: INNER
-- Agregación: SUM

SELECT
    f.name AS faculty,
    SUM(co.capacity) AS total_capacity
FROM university.course_offerings co
JOIN university.courses c ON co.course_id = c.course_id
JOIN university.programs_courses pc ON c.course_id = pc.course_id
JOIN university.programs p ON pc.program_id = p.program_id
JOIN university.faculties f ON p.faculty_id = f.faculty_id
WHERE f.name = 'Facultad de Ingeniería'
GROUP BY f.name;  


-- Obtener el promedio de capacidad de todas las ofertas de curso
-- que se dictan los días lunes.
-- Tipo de JOIN: INNER
-- Agregación: AVG

SELECT
    AVG(co.capacity) AS average_capacity
FROM university.course_offerings co
WHERE co.day_of_week = 'Monday'; 


-- Obtener cuántas ofertas de curso tiene asignadas en total
-- un profesor específico, mostrando su nombre completo.
-- Tipo de JOIN: INNER
-- Agregación: COUNT

SELECT
    u.first_name || ' ' || u.last_name AS full_name,
    COUNT(*) AS total_offerings
FROM university.users u
JOIN university.course_offerings co ON u.user_id = co.professor_id
WHERE u.role_id = (SELECT role_id FROM university.roles WHERE name = 'Professor')
GROUP BY u.first_name, u.last_name;


-- Obtener el número total de cursos que pertenecen al plan
-- de estudios de un programa académico específico,
-- incluyendo los semestres en los que aparecen.
-- Tipo de JOIN: INNER
-- Agregación: COUNT

SELECT
    p.name AS program,
    COUNT(*) AS total_courses
FROM university.programs p
JOIN university.programs_courses pc ON p.program_id = pc.program_id
WHERE p.name = 'Ingeniería de Sistemas'
GROUP BY p.name;

-- Obtener la cantidad de estudiantes inscritos en una
-- oferta de curso específica, mostrando el nombre del curso
-- y el nombre completo del profesor que la dicta.
-- Tipo de JOIN: INNER
-- Agregación: COUNT

SELECT
    c.name AS course,
    u.first_name || ' ' || u.last_name AS professor,
    COUNT(ps.user_id) AS total_students
FROM university.course_offerings co
JOIN university.courses c ON co.course_id = c.course_id
JOIN university.users u ON co.professor_id = u.user_id
JOIN university.programs_courses pc ON c.course_id = pc.course_id
JOIN university.programs_students ps ON pc.program_id = ps.program_id
WHERE co.course_offering_id = 1
GROUP BY c.name, u.first_name, u.last_name;