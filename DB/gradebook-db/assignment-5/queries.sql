-- Question 1: all grades of a given student in a given subject, by date.
-- Here: student Ivan Petrov, subject Mathematics.
-- Returns: one row per grade (date, grade), oldest first.
SELECT g.graded_on, g.grade
FROM grades g
JOIN students st ON st.id = g.student_id
JOIN subjects su ON su.id = g.subject_id
WHERE st.first_name = 'Ivan'
  AND st.last_name  = 'Petrov'
  AND su.name       = 'Mathematics'
ORDER BY g.graded_on;

-- Question 2: the class average grade in each subject (2 decimal places)
-- and the number of grades.
-- Returns: one row per subject (subject, average, grades_count).
SELECT su.name                      AS subject,
       ROUND(AVG(g.grade), 2)       AS average_grade,
       COUNT(*)                     AS grades_count
FROM grades g
JOIN subjects su ON su.id = g.subject_id
GROUP BY su.id, su.name
ORDER BY su.name;
