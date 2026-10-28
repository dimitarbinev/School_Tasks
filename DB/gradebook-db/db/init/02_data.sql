-- Sample data (6 students, 4 subjects, 31 grades)

INSERT INTO students (first_name, last_name) VALUES
    ('Ivan',   'Petrov'),
    ('Maria',  'Georgieva'),
    ('Georgi', 'Dimitrov'),
    ('Elena',  'Koleva'),
    ('Nikolay','Stoyanov'),
    ('Sofia',  'Ivanova');

INSERT INTO subjects (name) VALUES
    ('Mathematics'),
    ('Bulgarian Language'),
    ('Informatics'),
    ('Physics');

-- student_id, subject_id, grade, date
INSERT INTO grades (student_id, subject_id, grade, graded_on) VALUES
    -- Ivan (1): 4 grades in Mathematics, trending up, plus others
    (1, 1, 3, '2026-09-18'),
    (1, 1, 4, '2026-10-02'),
    (1, 1, 5, '2026-10-16'),
    (1, 1, 6, '2026-10-23'),
    (1, 2, 4, '2026-09-22'),
    (1, 3, 6, '2026-10-01'),
    -- Maria (2)
    (2, 1, 6, '2026-09-18'),
    (2, 1, 5, '2026-10-02'),
    (2, 1, 6, '2026-10-16'),
    (2, 2, 6, '2026-09-22'),
    (2, 3, 5, '2026-10-01'),
    (2, 4, 6, '2026-10-08'),
    -- Georgi (3): struggles
    (3, 1, 2, '2026-09-18'),
    (3, 1, 3, '2026-10-02'),
    (3, 1, 2, '2026-10-16'),
    (3, 2, 3, '2026-09-22'),
    (3, 3, 4, '2026-10-01'),
    (3, 4, 3, '2026-10-08'),
    -- Elena (4)
    (4, 1, 4, '2026-09-18'),
    (4, 2, 5, '2026-09-22'),
    (4, 2, 6, '2026-10-13'),
    (4, 3, 5, '2026-10-01'),
    (4, 4, 4, '2026-10-08'),
    -- Nikolay (5): has no grades in Physics
    (5, 1, 5, '2026-10-02'),
    (5, 2, 4, '2026-09-22'),
    (5, 3, 3, '2026-10-01'),
    (5, 3, 4, '2026-10-15'),
    -- Sofia (6)
    (6, 1, 5, '2026-09-18'),
    (6, 2, 5, '2026-09-22'),
    (6, 4, 5, '2026-10-08'),
    (6, 4, 6, '2026-10-22');
