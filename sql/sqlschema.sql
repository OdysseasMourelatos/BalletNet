-- 1. Υπερκλάση Χρηστών
CREATE TABLE users (
    user_id VARCHAR(50) PRIMARY KEY,
    username VARCHAR(50) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    role ENUM('SECRETARY', 'TEACHER', 'STUDENT') NOT NULL
);

-- 2. Εξειδικευμένοι Ρόλοι (Joined-Table 1:1)
CREATE TABLE secretaries (
    secretary_id VARCHAR(50) PRIMARY KEY,
    user_id VARCHAR(50) NOT NULL UNIQUE,
    CONSTRAINT fk_sec_user FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE
);

CREATE TABLE students (
    student_id VARCHAR(50) PRIMARY KEY,
    user_id VARCHAR(50) NOT NULL UNIQUE,
    age INT,
    CONSTRAINT fk_stud_user FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE
);

CREATE TABLE teachers (
    teacher_id VARCHAR(50) PRIMARY KEY,
    user_id VARCHAR(50) NOT NULL UNIQUE,
    specialization VARCHAR(100),
    CONSTRAINT fk_teach_user FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE
);

-- 3. Τμήματα
CREATE TABLE course_groups (
    group_id VARCHAR(50) PRIMARY KEY,
    level VARCHAR(100) NOT NULL,
    capacity INT NOT NULL
);

-- 4. Πίνακες Σύνδεσης M:N
CREATE TABLE student_enrollments (
    student_id VARCHAR(50) NOT NULL,
    group_id VARCHAR(50) NOT NULL,
    PRIMARY KEY (student_id, group_id),
    CONSTRAINT fk_enr_stud FOREIGN KEY (student_id) REFERENCES students(student_id) ON DELETE CASCADE,
    CONSTRAINT fk_enr_grp FOREIGN KEY (group_id) REFERENCES course_groups(group_id) ON DELETE CASCADE
);

CREATE TABLE teacher_course_groups (
    teacher_id VARCHAR(50) NOT NULL,
    group_id VARCHAR(50) NOT NULL,
    PRIMARY KEY (teacher_id, group_id),
    CONSTRAINT fk_tcg_teach FOREIGN KEY (teacher_id) REFERENCES teachers(teacher_id) ON DELETE CASCADE,
    CONSTRAINT fk_tcg_grp FOREIGN KEY (group_id) REFERENCES course_groups(group_id) ON DELETE CASCADE
);

-- 5. Επίσημο Πρόγραμμα Σπουδών Τμήματος (1:1 με CourseGroup)
CREATE TABLE syllabuses (
    syllabus_id VARCHAR(50) PRIMARY KEY,
    group_id VARCHAR(50) NOT NULL UNIQUE,
    title VARCHAR(100) NOT NULL,
    barre_progress DOUBLE DEFAULT 0.0,
    centre_progress DOUBLE DEFAULT 0.0,
    allegro_progress DOUBLE DEFAULT 0.0,
    pointe_progress DOUBLE DEFAULT 0.0,
    completion_percentage DOUBLE DEFAULT 0.0,
    daily_log TEXT,
    CONSTRAINT fk_syl_grp FOREIGN KEY (group_id) REFERENCES course_groups(group_id) ON DELETE CASCADE
);

-- 6. Προγραμματισμένες Συνεδρίες
CREATE TABLE scheduled_sessions (
    session_id VARCHAR(50) PRIMARY KEY,
    group_id VARCHAR(50) NOT NULL,
    teacher_id VARCHAR(50) NOT NULL,
    secretary_id VARCHAR(50) NOT NULL,
    day VARCHAR(20) NOT NULL,
    time VARCHAR(30) NOT NULL,
    room_name VARCHAR(50) NOT NULL,
    is_substitution BOOLEAN NOT NULL DEFAULT FALSE,
    CONSTRAINT fk_sess_grp FOREIGN KEY (group_id) REFERENCES course_groups(group_id) ON DELETE CASCADE,
    CONSTRAINT fk_sess_teach FOREIGN KEY (teacher_id) REFERENCES teachers(teacher_id) ON DELETE RESTRICT,
    CONSTRAINT fk_sess_sec FOREIGN KEY (secretary_id) REFERENCES secretaries(secretary_id) ON DELETE RESTRICT
);

-- 7. Εξεταστικές Περίοδοι
CREATE TABLE exam_sessions (
    exam_id VARCHAR(50) PRIMARY KEY,
    group_id VARCHAR(50) NOT NULL,
    secretary_id VARCHAR(50) NOT NULL,
    exam_body VARCHAR(50) NOT NULL,
    exam_date DATE NOT NULL,
    time VARCHAR(30) NOT NULL,
    room_name VARCHAR(50) NOT NULL,
    exam_fee DECIMAL(8, 2),
    status VARCHAR(40) NOT NULL,
    CONSTRAINT fk_ex_grp FOREIGN KEY (group_id) REFERENCES course_groups(group_id) ON DELETE CASCADE,
    CONSTRAINT fk_ex_sec FOREIGN KEY (secretary_id) REFERENCES secretaries(secretary_id) ON DELETE RESTRICT
);

-- 8. Ατομική Αξιολόγηση & Πρόοδος Μαθήτριας
CREATE TABLE student_progress (
    progress_id VARCHAR(50) PRIMARY KEY,
    student_id VARCHAR(50) NOT NULL,
    group_id VARCHAR(50) NOT NULL,
    teacher_id VARCHAR(50) NOT NULL,
    exam_id VARCHAR(50) DEFAULT NULL,
    attendance_rate DOUBLE DEFAULT 0.0,
    readiness_level VARCHAR(50),
    personal_comments TEXT,
    is_exam_ready BOOLEAN NOT NULL DEFAULT FALSE,
    evaluation_date DATE NOT NULL,
    CONSTRAINT fk_prg_stud FOREIGN KEY (student_id) REFERENCES students(student_id) ON DELETE CASCADE,
    CONSTRAINT fk_prg_grp FOREIGN KEY (group_id) REFERENCES course_groups(group_id) ON DELETE CASCADE,
    CONSTRAINT fk_prg_teach FOREIGN KEY (teacher_id) REFERENCES teachers(teacher_id) ON DELETE RESTRICT,
    CONSTRAINT fk_prg_exam FOREIGN KEY (exam_id) REFERENCES exam_sessions(exam_id) ON DELETE SET NULL
);