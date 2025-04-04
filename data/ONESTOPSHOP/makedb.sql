DROP TABLE grades;
DROP TABLE students;
DROP TABLE teachers;
DROP TABLE schedules;
DROP TABLE assignments;
DROP TABLE assignment_types;
DROP TABLE classes;
DROP TABLE rooms;
DROP TABLE courses;
DROP TABLE course_types;
DROP TABLE departments;

CREATE TABLE departments (
   id integer PRIMARY KEY,
   name varchar(255)
);

CREATE TABLE course_types (
   id integer PRIMARY KEY,
   name varchar(255)
);

CREATE TABLE courses (
    id integer PRIMARY KEY,
    type integer,
    name varchar(255),
    FOREIGN KEY (type) REFERENCES course_types(id)
);

CREATE TABLE rooms (
   id integer PRIMARY KEY,
   name varchar(255)
);

CREATE TABLE classes (
    id integer PRIMARY KEY,
    room_id integer,
    course_id integer,
    FOREIGN KEY (room_id) REFERENCES rooms(id),
    FOREIGN KEY (course_id) REFERENCES courses(id)
);

CREATE TABLE assignment_types (
   id integer PRIMARY KEY,
   name varchar(255)
);

CREATE TABLE assignments (
   id integer PRIMARY KEY,
   class_id integer,
   name varchar(255),
   type integer,
   FOREIGN KEY (class_id) REFERENCES classes(id),
   FOREIGN KEY (type) REFERENCES assignment_types(id)
);

CREATE TABLE schedules (
   id integer PRIMARY KEY,
   pd1 integer, pd2 integer, pd3 integer, pd4 integer, pd5 integer, pd6 integer, pd7 integer, pd8 integer, pd9 integer, pd10 integer,
   FOREIGN KEY (pd1) REFERENCES classes(id), FOREIGN KEY (pd2) REFERENCES classes(id), FOREIGN KEY (pd3) REFERENCES classes(id), FOREIGN KEY (pd4) REFERENCES classes(id), FOREIGN KEY (pd5) REFERENCES classes(id), FOREIGN KEY (pd6) REFERENCES classes(id), FOREIGN KEY (pd7) REFERENCES classes(id), FOREIGN KEY (pd8) REFERENCES classes(id), FOREIGN KEY (pd9) REFERENCES classes(id), FOREIGN KEY (pd10) REFERENCES classes(id)
);

CREATE TABLE teachers (
   id integer PRIMARY KEY,
   department_id integer,
   first_name varchar(255),
   last_name varchar(255),
   schedule_id integer,
   FOREIGN KEY (department_id) REFERENCES departments(id), FOREIGN KEY (schedule_id) REFERENCES schedules(id)
);

CREATE TABLE students (
   id integer PRIMARY KEY,
   first_name varchar(255),
   last_name varchar(255),
   schedule_id integer,
   FOREIGN KEY (schedule_id) REFERENCES schedules(id)
);

CREATE TABLE grades (
   assignment_id integer,
   student_id integer,
   grade integer,
   FOREIGN KEY (assignment_id) REFERENCES assignments(id),
   FOREIGN KEY (student_id) REFERENCES students(id)
);

INSERT INTO assignment_types (id,name) VALUES (1, 'Minor Assessment');
INSERT INTO assignment_types (id,name) VALUES (2, 'Major Assessment');

INSERT INTO course_types (id,name) VALUES (1, 'Elective');
INSERT INTO course_types (id,name) VALUES (2, 'Regents');
INSERT INTO course_types (id,name) VALUES (3, 'AP');

INSERT INTO courses (id, type, name) VALUES (1, 1, 'Anatomy');
INSERT INTO courses (id, type, name) VALUES (2, 3, 'Biology');
INSERT INTO courses (id, type, name) VALUES (3, 3, 'Environmental');
INSERT INTO courses (id, type, name) VALUES (4, 3, 'Psychology');
INSERT INTO courses (id, type, name) VALUES (5, 1, 'Bioorganic Chemistry');
INSERT INTO courses (id, type, name) VALUES (6, 1, 'Genetics');
INSERT INTO courses (id, type, name) VALUES (7, 1, 'Introduction to Neuroscience');
INSERT INTO courses (id, type, name) VALUES (8, 2, 'Living Environment');
INSERT INTO courses (id, type, name) VALUES (9, 2, 'Living Environment Lab');
INSERT INTO courses (id, type, name) VALUES (10, 1, 'Environmental Sustainability');
INSERT INTO courses (id, type, name) VALUES (11, 2, 'Chemistry');
INSERT INTO courses (id, type, name) VALUES (12, 2, 'Chemistry Lab');
INSERT INTO courses (id, type, name) VALUES (13, 3, 'Chemistry');
INSERT INTO courses (id, type, name) VALUES (14, 1, 'Chemical Engineering');
INSERT INTO courses (id, type, name) VALUES (15, 1, 'Organic Chemistry');
INSERT INTO courses (id, type, name) VALUES (16, 1, 'MICA');
INSERT INTO courses (id, type, name) VALUES (17, 1, 'Quantitative Analysis');
INSERT INTO courses (id, type, name) VALUES (18, 1, 'Forensics');
INSERT INTO courses (id, type, name) VALUES (19, 2, 'Physics');
INSERT INTO courses (id, type, name) VALUES (20, 2, 'Physics Lab');
INSERT INTO courses (id, type, name) VALUES (21, 3, 'Physics 1');
INSERT INTO courses (id, type, name) VALUES (22, 3, 'Physics 2');
INSERT INTO courses (id, type, name) VALUES (23, 3, 'Physics C (Mechanics)');
INSERT INTO courses (id, type, name) VALUES (24, 3, 'Physics C (E/M)');
INSERT INTO courses (id, type, name) VALUES (25, 1, 'Astronomy');
INSERT INTO courses (id, type, name) VALUES (26, 1, 'Modern Physics');
INSERT INTO courses (id, type, name) VALUES (27, 2, 'Common Core Algebra');
INSERT INTO courses (id, type, name) VALUES (28, 2, 'Common Core Geometry');
INSERT INTO courses (id, type, name) VALUES (29, 2, 'Common Core Algebra II');
INSERT INTO courses (id, type, name) VALUES (30, 1, 'Pre-Calculus');
INSERT INTO courses (id, type, name) VALUES (31, 1, 'Calculus');
INSERT INTO courses (id, type, name) VALUES (32, 3, 'Calculus AB');
INSERT INTO courses (id, type, name) VALUES (33, 3, 'Calculus BC');
INSERT INTO courses (id, type, name) VALUES (34, 3, 'Statistics');
INSERT INTO courses (id, type, name) VALUES (35, 1, 'Multivariable Calculus');
INSERT INTO courses (id, type, name) VALUES (36, 1, 'Math Research');
INSERT INTO courses (id, type, name) VALUES (37, 1, 'Linear Algebra');
INSERT INTO courses (id, type, name) VALUES (38, 3, 'Computer Science Principles');
INSERT INTO courses (id, type, name) VALUES (39, 3, 'Computer Science A');
INSERT INTO courses (id, type, name) VALUES (40, 1, 'Big Data: Warehousing & Analytics');
INSERT INTO courses (id, type, name) VALUES (41, 1, 'Cyber Security');
INSERT INTO courses (id, type, name) VALUES (42, 1, 'PLTW Digital Electronics');
INSERT INTO courses (id, type, name) VALUES (43, 1, 'Digital Systems Design');
INSERT INTO courses (id, type, name) VALUES (44, 1, 'Fundamentals of IT Infrastructure');
INSERT INTO courses (id, type, name) VALUES (45, 1, 'Green Building Construction');
INSERT INTO courses (id, type, name) VALUES (46, 1, 'PLTW EDD');
INSERT INTO courses (id, type, name) VALUES (47, 1, 'Physical Education');
INSERT INTO courses (id, type, name) VALUES (48, 1, 'Health Education');
INSERT INTO courses (id, type, name) VALUES (49, 1, '9th Grade English');
INSERT INTO courses (id, type, name) VALUES (50, 1, '10th Grade English');
INSERT INTO courses (id, type, name) VALUES (51, 3, 'Capstone Seminar');
INSERT INTO courses (id, type, name) VALUES (52, 2, '11th Grade English');
INSERT INTO courses (id, type, name) VALUES (53, 3, 'English Language & Composition');
INSERT INTO courses (id, type, name) VALUES (54, 3, 'Capstone Research');
INSERT INTO courses (id, type, name) VALUES (55, 3, 'English Literature & Composition');
INSERT INTO courses (id, type, name) VALUES (56, 1, 'Creative Writing');
INSERT INTO courses (id, type, name) VALUES (57, 1, 'Drama');
INSERT INTO courses (id, type, name) VALUES (58, 1, 'Film & Literature');
INSERT INTO courses (id, type, name) VALUES (59, 1, 'Journalism');
INSERT INTO courses (id, type, name) VALUES (60, 1, 'Life, Love & Death');
INSERT INTO courses (id, type, name) VALUES (61, 1, 'Mystery, Horror & the Supernatural');
INSERT INTO courses (id, type, name) VALUES (62, 1, 'Science Fiction & Fantasy');
INSERT INTO courses (id, type, name) VALUES (63, 1, 'Yearbook');
INSERT INTO courses (id, type, name) VALUES (64, 1, 'The Survey');
INSERT INTO courses (id, type, name) VALUES (65, 1, '9th Grade Global');
INSERT INTO courses (id, type, name) VALUES (66, 2, 'Global History');
INSERT INTO courses (id, type, name) VALUES (67, 3, 'World History');
INSERT INTO courses (id, type, name) VALUES (68, 3, 'European History');
INSERT INTO courses (id, type, name) VALUES (69, 2, 'American History');
INSERT INTO courses (id, type, name) VALUES (70, 3, 'American History');
INSERT INTO courses (id, type, name) VALUES (71, 1, 'Participation in Government');
INSERT INTO courses (id, type, name) VALUES (72, 3, 'US Government');
INSERT INTO courses (id, type, name) VALUES (73, 1, 'Economics');
INSERT INTO courses (id, type, name) VALUES (74, 3, 'Macroeconomics');
INSERT INTO courses (id, type, name) VALUES (75, 3, 'Microeconomics');
INSERT INTO courses (id, type, name) VALUES (76, 3, 'Comparative Government');
INSERT INTO courses (id, type, name) VALUES (77, 3, 'Psychology');
INSERT INTO courses (id, type, name) VALUES (78, 3, 'Human Geography');
INSERT INTO courses (id, type, name) VALUES (79, 1, 'Sociology');
INSERT INTO courses (id, type, name) VALUES (80, 1, 'Cultural Anthropology');
INSERT INTO courses (id, type, name) VALUES (81, 1, 'Physical Anthropology');
INSERT INTO courses (id, type, name) VALUES (82, 2, 'Chinese');
INSERT INTO courses (id, type, name) VALUES (83, 3, 'Chinese Language and Culture');
INSERT INTO courses (id, type, name) VALUES (84, 2, 'French');
INSERT INTO courses (id, type, name) VALUES (85, 3, 'French Language and Culture');
INSERT INTO courses (id, type, name) VALUES (86, 2, 'German');
INSERT INTO courses (id, type, name) VALUES (87, 3, 'German Language and Culture');
INSERT INTO courses (id, type, name) VALUES (88, 2, 'Italian');
INSERT INTO courses (id, type, name) VALUES (89, 3, 'Italian Language and Culture');
INSERT INTO courses (id, type, name) VALUES (90, 2, 'Spanish');
INSERT INTO courses (id, type, name) VALUES (91, 1, 'Spanish IV');
INSERT INTO courses (id, type, name) VALUES (92, 3, 'Spanish Language and Culture');
INSERT INTO courses (id, type, name) VALUES (93, 3, 'Spanish Literature and Culture');
INSERT INTO courses (id, type, name) VALUES (94, 1, 'Adobe Digital Video');
INSERT INTO courses (id, type, name) VALUES (95, 1, 'Adobe Visual Design');
INSERT INTO courses (id, type, name) VALUES (96, 1, 'Architectural Drawing w/CAD');
INSERT INTO courses (id, type, name) VALUES (97, 1, 'Digital Animation');
INSERT INTO courses (id, type, name) VALUES (98, 1, 'PLTW CEA');
INSERT INTO courses (id, type, name) VALUES (99, 1, 'PLTW DDP (9th Grade)');

INSERT INTO departments (id,name) VALUES (1, 'Biology');
INSERT INTO departments (id,name) VALUES (2, 'Chemistry');
INSERT INTO departments (id,name) VALUES (3, 'CTE, Computer Science & Engineering');
INSERT INTO departments (id,name) VALUES (4, 'English');
INSERT INTO departments (id,name) VALUES (5, 'Health & PE');
INSERT INTO departments (id,name) VALUES (6, 'Mathematics');
INSERT INTO departments (id,name) VALUES (7, 'Physics');
INSERT INTO departments (id,name) VALUES (8, 'Social Studies');
INSERT INTO departments (id,name) VALUES (9, 'Special Education');
INSERT INTO departments (id,name) VALUES (10, 'Visual & Performing Arts');
INSERT INTO departments (id,name) VALUES (11, 'World Languages & ENL');
