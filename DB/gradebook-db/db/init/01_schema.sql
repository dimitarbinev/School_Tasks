-- Electronic gradebook: structure + sample data
-- Runs automatically on the first start of the container (database gradebook is created by POSTGRES_DB)

CREATE TABLE students (
    id         SERIAL PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name  VARCHAR(50) NOT NULL
);

CREATE TABLE subjects (
    id   SERIAL PRIMARY KEY,
    name VARCHAR(50) NOT NULL UNIQUE
);

CREATE TABLE grades (
    id         SERIAL PRIMARY KEY,
    student_id INTEGER  NOT NULL REFERENCES students(id),
    subject_id INTEGER  NOT NULL REFERENCES subjects(id),
    grade      SMALLINT NOT NULL CHECK (grade BETWEEN 2 AND 6),
    graded_on  DATE     NOT NULL
);
