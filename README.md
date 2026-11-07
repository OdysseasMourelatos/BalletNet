# Ballet Net — Dance Studio Management Platform

**Ballet Net** is a **Vertical SaaS platform** for digitizing the daily academic and administrative operations of dance schools. It is designed around standardized international curricula (such as the **Royal Academy of Dance – RAD** and the **Imperial Society of Teachers of Dancing – ISTD**) and covers curriculum tracking, studio scheduling with conflict detection, and certification exam coordination.

The project includes a pilot instance based on real-world domain data from the **Ballet Arts** dance school in Glyfada, Athens.

> **Status (1st deliverable):** this release contains the design documentation and a **static front-end prototype** (HTML/CSS/JavaScript). The Java backend (Servlets/JSP, Active Record, JDBC) shown in the architecture diagrams is the design target of the 2nd deliverable and is not yet implemented in this repository.

---

## 🌐 Pilot Deployment

- **Prototype URL:** [https://ism.dmst.aueb.gr/ismgroup1/BalletNet/WebContent/index.html](https://ism.dmst.aueb.gr/ismgroup1/BalletNet/WebContent/index.html)
- **Role switching instead of login:** for easy academic inspection, the landing page (`index.html`) provides a role selector (Secretary / Teacher / Student) that opens the corresponding screens without credentials. Full authentication with Role-Based Access Control (RBAC) is planned for the 2nd deliverable.

---

## 🏛️ Target Architecture (design)

The platform is designed as a 3-tier layered system following **MVC Model 2**:

1. **Presentation Layer:** JSP pages (HTML5, CSS3, Bootstrap 5.3). In this release, the screens exist as static HTML pages.
2. **Application Layer:** Java Servlets as controllers and nine domain classes (`User`, `Secretary`, `Teacher`, `Student`, `CourseGroup`, `ScheduledSession`, `Syllabus`, `StudentProgress`, `ExamSession`) implementing the business logic, including room and teacher conflict detection.
3. **Database Layer:** relational schema on **MySQL**, accessed through the **Active Record** pattern with a central `DatabaseConnection` class (JDBC). The schema is in [`sql/sqlschema.sql`](sql/sqlschema.sql).

UML and architecture diagrams are in the [`Diagrams`](Diagrams) folder.

---

## 🎯 Prototype Screens and Use Cases

| Role | Screen (`WebContent/dashboard/`) | Use case |
|---|---|---|
| Secretary | `manage_schedule.html` | Manage Schedule: weekly timetable per studio (Room 1 / Room 2), substitution flag, room conflict check (demo logic) |
| Secretary | `manage_exam_sessions.html` | Manage Exam Sessions: schedule RAD/ISTD exams, exam status, eligible candidates |
| Teacher | `update_class_progress.html` | Update Class Progress: syllabus coverage sliders (Barre, Centre, Allegro, Pointe) and a teaching log |
| Teacher | `update_student_progress.html` | Update Personal Student Progress: individual assessment, comments and the `Exam Ready` flag |
| Student | `view_student_schedule.html` | View Personal Schedule |
| Student | `view_student_progress.html` | View Syllabus & Personal Progress, with the conditional extension View Upcoming Exams & Status (shown only for `Exam Ready` students) |

Authentication is treated as a precondition of the system (RBAC) and not as a standalone use case. Account creation and class enrollment are performed by the Secretary at administrative level.

---

## 🔄 Scope Refactoring

Compared to earlier exploratory work, the scope was refined:
- Social media content workflows (UGC) were removed to focus on operational efficiency and educational consistency.
- Authentication was excluded from the Use Case Diagram and is treated as an RBAC precondition.
- The student portal is split into two single-purpose views (schedule, and syllabus & progress).

---

## 👥 Development Team

Academic project developed for the course **"Development and Information Systems Architectures"** (5th Semester), Department of Management Science and Technology (**DMST**), **Athens University of Economics and Business (AUEB)**.

- **Supervising Professor:** Prof. Katerina Pramatari