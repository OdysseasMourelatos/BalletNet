<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%-- Unhandled JSP exceptions are forwarded internally to this common error page. --%>
<%@ page errorPage="error.jsp" %>

<!DOCTYPE html>
<html lang="el">

<head>
    <%@ include file="includes/header.jsp" %>
    <title>Home Page - Ballet Net</title>
</head>

<body>
    
    <!-- Responsive Navbar -->
    <nav class="navbar navbar-light bg-light mb-4 shadow-sm py-2">
        <div class="container-fluid px-3 px-md-5 d-flex justify-content-between align-items-center flex-nowrap">
            <a class="navbar-brand fs-3 fs-md-2 fw-bold d-flex align-items-center text-ballet m-0" href="index.html">
                <img src="photos/BalletArts.png" alt="Ballet Arts Logo" height="48" class="me-2 me-md-3">
                Ballet Net
            </a>

            <div>
                <button type="button" class="btn btn-outline-ballet rounded-pill px-3 py-1 fw-semibold" data-bs-toggle="modal" data-bs-target="#loginModal">
                    <i class="bi bi-box-arrow-in-right me-1"></i> <span data-el="Είσοδος" data-en="Login">Είσοδος</span>
                </button>
            </div>
        </div>
    </nav>

    <!-- Main Container -->
    <div class="container mb-5 mt-4">
        <div class="bg-white p-4 p-md-5 shadow-sm rounded-4">

            <!-- Hero Header -->
            <div class="text-center mb-4 mb-md-5 pb-2">
                <h1 class="fw-bold mb-3 text-ballet display-5" data-el="Καλώς ήρθατε στο Ballet Net" data-en="Welcome to Ballet Net">
                    Καλώς ήρθατε στο Ballet Net
                </h1>
                <h4 class="text-muted fw-normal mt-3 fs-5 lh-base mx-auto" style="max-width: 700px;" 
                    data-el="Χορεύουμε με πειθαρχία, έκφραση και αγάπη για την τέχνη."
                    data-en="We dance with discipline, expression and love for the art.">
                    Χορεύουμε με πειθαρχία, έκφραση και αγάπη για την τέχνη.
                </h4>
            </div>

            <!-- Value Proposition Cards -->
            <div class="row g-4 mt-1">
                <!-- Card 1 -->
                <div class="col-md-4">
                    <div class="card h-100 shadow-sm feature-card p-4 border-0 rounded-3">
                        <div class="card-body text-center p-0">
                            <i class="bi bi-heart card-icon fs-1 text-ballet mb-3 d-inline-block"></i>
                            <h4 class="card-title fw-bold text-dark mb-3" data-el="Τα πιστεύω μας" data-en="Our Beliefs">Τα πιστεύω μας</h4>
                            <p class="card-text text-muted lh-base" 
                                data-el="Πιστεύουμε ότι ο χορός καλλιεργεί το σώμα, το μυαλό και την ψυχή. Μέσα από τη σωστή καθοδήγηση, κάθε μαθητής μπορεί να αναπτυχθεί με σεβασμό, αυτοπεποίθηση και δημιουργικότητα."
                                data-en="We believe that dance develops the body, mind and spirit. Through thoughtful guidance, every student can grow with respect, confidence and creativity.">
                                Πιστεύουμε ότι ο χορός καλλιεργεί το σώμα, το μυαλό και την ψυχή. Μέσα από τη σωστή καθοδήγηση, κάθε μαθητής μπορεί να αναπτυχθεί με σεβασμό, αυτοπεποίθηση και δημιουργικότητα.
                            </p>
                        </div>
                    </div>
                </div>

                <!-- Card 2 -->
                <div class="col-md-4">
                    <div class="card h-100 shadow-sm feature-card p-4 border-0 rounded-3">
                        <div class="card-body text-center p-0">
                            <i class="bi bi-eye card-icon fs-1 text-ballet mb-3 d-inline-block"></i>
                            <h4 class="card-title fw-bold text-dark mb-3" data-el="Το όραμά μας" data-en="Our Vision">Το όραμά μας</h4>
                            <p class="card-text text-muted lh-base" 
                                data-el="Το όραμά μας είναι να δημιουργούμε ένα ασφαλές, οργανωμένο και εμπνευσμένο περιβάλλον όπου οι μαθητές εξελίσσονται όχι μόνο ως χορευτές, αλλά και ως άνθρωποι."
                                data-en="Our vision is to create a safe, organised and inspiring environment where students grow not only as dancers, but also as individuals.">
                                Το όραμά μας είναι να δημιουργούμε ένα ασφαλές, οργανωμένο και εμπνευσμένο περιβάλλον όπου οι μαθητές εξελίσσονται όχι μόνο ως χορευτές, αλλά και ως άνθρωποι.
                            </p>
                        </div>
                    </div>
                </div>

                <!-- Card 3 -->
                <div class="col-md-4">
                    <div class="card h-100 shadow-sm feature-card p-4 border-0 rounded-3">
                        <div class="card-body text-center p-0">
                            <i class="bi bi-laptop card-icon fs-1 text-ballet mb-3 d-inline-block"></i>
                            <h4 class="card-title fw-bold text-dark mb-3" data-el="Η πλατφόρμα μας" data-en="Our Platform">Η πλατφόρμα μας</h4>
                            <p class="card-text text-muted lh-base" 
                                data-el="Το Ballet Net αποτελεί την ολοκληρωμένη πλατφόρμα διαχείρισης και εκπαιδευτικού συντονισμού. Παρέχει άμεση πρόσβαση στο ωρολόγιο πρόγραμμα, καταγραφή ύλης RAD/ISTD και παρακολούθηση εξετάσεων."
                                data-en="Ballet Net is the integrated management and educational platform. It provides direct access to schedules, RAD/ISTD syllabus tracking, and examination readiness monitoring.">
                                Το Ballet Net αποτελεί την ολοκληρωμένη πλατφόρμα διαχείρισης και εκπαιδευτικού συντονισμού. Παρέχει άμεση πρόσβαση στο ωρολόγιο πρόγραμμα, καταγραφή ύλης RAD/ISTD και παρακολούθηση εξετάσεων.
                            </p>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Single Call-To-Action (Είσοδος) -->
            <div class="mt-5 pt-4 border-top text-center">
                <button type="button" class="btn btn-ballet btn-lg px-5 rounded-pill shadow-sm" data-bs-toggle="modal" data-bs-target="#loginModal">
                    <i class="bi bi-box-arrow-in-right me-2"></i> <span data-el="Είσοδος στο Σύστημα" data-en="Enter System">Είσοδος στο Σύστημα</span>
                </button>
            </div>

        </div>
    </div>

    <!-- Login Modal (Role Selector) -->
    <div class="modal fade" id="loginModal" tabindex="-1" aria-labelledby="loginModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content rounded-4 border-0 shadow">
                <div class="modal-header border-0 pb-0">
                    <h4 class="modal-title fw-bold text-ballet" id="loginModalLabel" data-el="Είσοδος στο Ballet Net" data-en="Login to Ballet Net">Είσοδος στο Ballet Net</h4>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body p-4 pt-2">
                    <p class="text-muted small mb-4" data-el="Επιλέξτε ρόλο για να περιηγηθείτε στις λειτουργίες της πλατφόρμας:" data-en="Select a role to navigate the platform features:">
                        Επιλέξτε ρόλο για να περιηγηθείτε στις λειτουργίες της πλατφόρμας:
                    </p>
                    
                    <form id="roleSelectForm" onsubmit="event.preventDefault(); goToRole();">
                        <div class="mb-4">
                            <label for="userRoleSelect" class="form-label fw-semibold text-dark" data-el="Ρόλος Χρήστη" data-en="User Role">Ρόλος Χρήστη</label>
                            <select class="form-select form-select-lg rounded-3" id="userRoleSelect" required>
                                <option value="secretary" selected>Γραμματεία (Secretary)</option>
                                <option value="teacher">Διδακτικό Προσωπικό (Teacher)</option>
                                <option value="student">Μαθητής / Κηδεμόνας (Student)</option>
                            </select>
                        </div>

                        <div class="d-grid gap-2">
                            <button type="submit" class="btn btn-ballet btn-lg rounded-pill fw-semibold" data-el="Είσοδος" data-en="Login">
                                Είσοδος
                            </button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>

    <!-- Scripts -->
    <script>
        function goToRole() {
            const role = document.getElementById('userRoleSelect').value;
            if (role === 'secretary') {
                window.location.href = 'dashboard/manage_schedule.html';
            } else if (role === 'teacher') {
                window.location.href = 'dashboard/update_class_progress.html';
            } else if (role === 'student') {
                window.location.href = 'dashboard/view_student_schedule.html';
            }
        }

        const language = navigator.language || navigator.userLanguage;
        const selectedLanguage = language.startsWith("el") ? "el" : "en";

        document.documentElement.lang = selectedLanguage;

        document.querySelectorAll("[data-el]").forEach(element => {
            element.textContent = element.getAttribute("data-" + selectedLanguage);
        });

        const loginModal = document.getElementById('loginModal');
        if (loginModal) {
            loginModal.addEventListener('hidden.bs.modal', function () {
                if (document.activeElement) {
                    document.activeElement.blur();
                }
            });
        }
    </script>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>

</html>