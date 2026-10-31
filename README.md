# Ballet Net — Dance Studio Management Platform

**Ballet Net** is an enterprise-grade, multi-tenant ready **Vertical SaaS platform** engineered to digitize and optimize daily academic and administrative operations in dance education. Designed in compliance with rigorous international curriculum frameworks (such as the **Royal Academy of Dance - RAD** and the **Imperial Society of Teachers of Dancing - ISTD**), the system streamlines curriculum tracking, studio room allocation, conflict detection, and certification examination workflows.

The project currently features a fully functional reference implementation (pilot instance) based on real-world domain data from the **Ballet Arts** dance academy in Glyfada.

---

## 🌐 Live Pilot Deployment

- **Production URL:** [https://ism.dmst.aueb.gr/ismgroup1/BalletNet/index.html](https://ism.dmst.aueb.gr/ismgroup1/BalletNet/index.html)
- **Evaluation Mechanism:** To provide zero-friction academic inspection without credential friction, the system implements an **Interactive Role-Switching Hub** on the landing page (`index.html`), directly modeling Role-Based Access Control (RBAC).

---

## 🏛️ System Architecture

The platform strictly follows the **3-Tier Layered Architectural Pattern (MVC)**:

1. **Presentation Layer (Web / UI):**
   - Responsive, accessible interfaces developed with **HTML5**, **CSS3**, and **Bootstrap 5.3**.
   - Modular view structure separating administrative management from student progress tracking.
2. **Business Logic & Service Layer (Java Backend):**
   - Dedicated service components handling conflict resolution, timetable overlaps, and exam eligibility evaluations.
   - Core MVC routing utilizing **Java Servlets**.
3. **Data Persistence Layer:**
   - Fully normalized (3NF) relational database schema on **MySQL / MariaDB**.
   - Encapsulated Data Access Objects (DAO) ensuring data integrity and transaction control.

---

## 🎯 Key Modules & Use Cases

### 1. Operations & Scheduling Engine (`Manage_Schedule.html`)
- Multi-studio timeline visualization (`Room 1` / `Room 2`).
- Real-time slot management with awareness for instructor availability, substitution handling, and room capacity constraints.

### 2. Examination Session Coordination (`Manage_Exams.html`)
- Administrative scheduling of official certification sessions (RAD / ISTD).
- Management of examination venues, fee tracking, registration cutoff dates, and candidate confirmation.

### 3. Curriculum Tracking & Evaluation Module (`Update_Progress.html`)
- **Group Syllabus Tracking:** Dynamic milestone progress indicators for standardized syllabus sections (*Barre Work, Center Practice, Allegro, Pointe Work*).
- **Daily Journaling:** Shared instructional log visible across administrative staff and enrolled students.
- **Individual Assessment:** Direct interface for instructors to assess student competence and toggle certification readiness (`Exam Ready` flag).

### 4. Personalized Student Portal (`Personal_Schedule.html` & `Student_Progress.html`)
- **My Schedule:** Dedicated view of weekly assigned sessions, assigned rooms, and faculty contacts.
- **Syllabus & Personal Progress:** Individual grade progression metrics.
- **Conditional Examination Notification (`«extend»`):** Contextually unhides official exam details and payment parameters only when verified as eligible by the instructor.

---

## 🔄 Architectural Scope Refactoring

Reflecting advanced software engineering principles, this release underwent strategic architectural refactoring compared to initial exploratory prototypes:
- **Pruning Non-Core Subsystems:** De-scoped social media publishing workflows (UGC pipelines) to focus strictly on operational core efficiency and pedagogical consistency.
- **Precondition Security:** Excluded generic authentication from the Use Case Diagram, treating authentication and authorization as architectural preconditions enforced via RBAC.
- **Interface Decoupling:** Split aggregated student dashboards into two focused, single-responsibility views.

---

## 👥 Development Team

Academic project developed for the course **"Development and Information Systems Architectures"** (5th Semester), Department of Management Science and Technology (**DMST**), **Athens University of Economics and Business (AUEB)**.

- **Supervising Professor:** Prof. Katerina Pramatari
