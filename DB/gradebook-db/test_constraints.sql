-- Constraint tests (not part of the hand-in dump): each statement must FAIL
INSERT INTO grades (student_id, subject_id, grade, graded_on) VALUES (1, 1, 7, '2026-10-26');
INSERT INTO grades (student_id, subject_id, grade, graded_on) VALUES (1, 1, 1, '2026-10-26');
INSERT INTO grades (student_id, subject_id, grade, graded_on) VALUES (999, 1, 5, '2026-10-26');
INSERT INTO grades (student_id, subject_id, grade, graded_on) VALUES (1, 999, 5, '2026-10-26');
INSERT INTO grades (student_id, subject_id, grade, graded_on) VALUES (1, 1, NULL, '2026-10-26');
