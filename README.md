# Ballet Net — Dance Studio Management Platform

**Ballet Net** is a **Vertical SaaS platform** for digitizing the daily academic and administrative operations of dance schools. It is designed around standardized international curricula (such as the **Royal Academy of Dance – RAD** and the **Imperial Society of Teachers of Dancing – ISTD**) and covers curriculum tracking, studio scheduling with conflict detection, and certification exam coordination.

The project includes a pilot instance based on real-world domain data from the **Ballet Arts** dance school in Glyfada, Athens.

> **Status (2nd deliverable):** This release delivers the core **Java Web Application** implementing the **MVC Model 2** architecture. The static UI prototype has been fully integrated into dynamic **JSP** views driven by **Java Servlets**, business domain models, and in-memory **DAO** persistence. Role-Based Access Control (RBAC), session management, and the Post-Redirect-Get (PRG) pattern are implemented across active modules.

---

## 🌐 Pilot Deployment & Credentials

- **Prototype URL (Static):** [https://ism.dmst.aueb.gr/ismgroup1/BalletNet/WebContent/index.html](https://ism.dmst.aueb.gr/ismgroup1/BalletNet/WebContent/index.html)
- **Application URL (Dynamic):** [https://ism.dmst.aueb.gr/ismgroup1/BalletNet/WebContent/home.jsp](https://ism.dmst.aueb.gr/ismgroup1/BalletNet/WebContent/home.jsp)


### Role-Based Access Control (RBAC) Accounts

Authentication is managed via HTTP Sessions (`login_form.jsp` / `LoginServlet`). For academic inspection and grading, the following in-memory seed accounts are available:

| Role | Username | Password | Notes / Scope |
|---|---|---|---|
| Secretary | `salexiou` | `1111` | Lead Administrator (`SEC-01`) |
| Secretary | `nkostopoulou` | `1112` | Assistant Administrator (`SEC-02`) |
| Teacher | `ekyriakidou` | `2222` | RAD Certified Instructor — 2 groups (`TEA-01`) |
| Teacher | `ddimitriou` | `2223` | Contemporary / Vaganova Instructor (`TEA-02`) |
| Teacher | `akara` | `2224` | Repertoire & Pointe — Shared Intermediate Group (`TEA-03`) |
| Student | `mgeorgiou` | `3333` | Exam Ready Candidate (`STU-01`) |
| Student | `ipapadopoulou` | `3334` | Advanced Foundation Student (`STU-02`) |

---

## 🏛️ Implemented System Architecture

The platform follows a clean 3-tier layered **MVC Model 2** architecture:

1. **Presentation Layer (View):** Dynamic JSP pages (`WebContent/dashboard/*.jsp`) styled with Bootstrap 5.3 and custom CSS. Forms leverage dynamic slider bindings, client-side real-time calculation, server-side data hydration, and flash-message dismissals.
2. **Application / Controller Layer:** 
   - **Java Servlets (`balletnet.controllers`):** Act as the system controllers handling routing, request parsing, session gatekeeping, and the **Post-Redirect-Get (PRG)** pattern to eliminate duplicate form submissions and recursion faults.
   - **Domain Model (`balletnet.models`):** Nine encapsulated domain classes (`User`, `Secretary`, `Teacher`, `Student`, `CourseGroup`, `ScheduledSession`, `Syllabus`, `StudentProgress`, `ExamSession`) handling business rules (e.g. syllabus metric updates, completion weighting).
3. **Data Access Layer (Model / Persistence):** 
   - Managed via DAO classes (`UserDAO`, `CourseGroupDAO`) using thread-safe, static in-memory collections for fast, consistent grading and evaluation without local database installation overhead.
   - Relational MySQL schema target is maintained in [`sql/sqlschema.sql`](sql/sqlschema.sql).

UML Class Diagrams, Sequence Diagrams, and Architecture Specifications are available in the [`Diagrams`](Diagrams) directory.

---

## 🎯 System Modules, Endpoints & Use Cases

| Role | Dynamic Endpoint (JSP / Servlet) | UI Prototype (`WebContent/dashboard/`) | Use Case & Implemented Logic |
|---|---|---|---|
| Teacher | `/classProgress` &rarr; `update_class_progress.jsp` | `update_class_progress.html` | **Update Class Progress:** Form submission via POST, syllabus metrics persistence (Barre, Centre, Allegro, Pointe), daily log updating, and PRG redirection. |
| Teacher | `/studentProgress` &rarr; `update_student_progress.jsp` | `update_student_progress.html` | **Update Personal Student Progress:** Per-student technical evaluations, attendance review, and exam-readiness qualification flag. |
| Secretary | `/manageSchedule` &rarr; `manage_schedule.jsp` | `manage_schedule.html` | **Manage Schedule:** Studio calendar allocations, teacher substitution logging, and schedule conflict validation. |
| Secretary | `/manageExams` &rarr; `manage_exam_sessions.jsp` | `manage_exam_sessions.html` | **Manage Exam Sessions:** Exam timetable orchestration and RAD/ISTD candidate roster consolidation. |
| Student | `/studentSchedule` &rarr; `view_student_schedule.jsp` | `view_student_schedule.html` | **View Personal Schedule:** Timetable inspection per enrolled course group. |
| Student | `/studentProgressView` &rarr; `view_student_progress.jsp` | `view_student_progress.html` | **View Syllabus & Progress:** Personal evaluation feedback and conditional upcoming exam view for eligible candidates. |

---

## 🔄 Scope Refactoring & Milestone Progress (Deliverable 2)

- **Authentication & RBAC:** Enforced session-based gatekeeping across all endpoints (`session.getAttribute("user")`) with redirect triggers to `/login_form.jsp`.
- **Controller Decoupling:** Separated class syllabus progression from individual student evaluation into dedicated Servlet controllers (`ClassProgressServlet`, `StudentProgressServlet`).
- **Post-Redirect-Get (PRG) Pattern:** Refactored form handlers to avoid dispatcher recursion (`StackOverflowError`) and browser re-submission warnings.
- **Multi-Instructor Assignment:** Seeded additional faculty accounts (`akara`) to validate collaborative multi-instructor group assignment.

---

## 👥 Development Team

Academic project developed for the course **"Development and Information Systems Architectures"** (5th Semester), Department of Management Science and Technology (**DMST**), **Athens University of Economics and Business (AUEB)**.

- **Supervising Professor:** Prof. Katerina Pramatari
