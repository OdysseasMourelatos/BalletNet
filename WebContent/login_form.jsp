<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%-- Unhandled JSP exceptions are forwarded internally to the common error page. --%>
<%@ page errorPage="error.jsp" %>

<%!
    // Απλό HTML escape για το μήνυμα σφάλματος
    private static String esc(String s) {
        if (s == null) return "";
        return s.replace("&", "&amp;")
                .replace("<", "&lt;")
                .replace(">", "&gt;")
                .replace("\"", "&quot;")
                .replace("'", "&#39;");
    }
%>

<!DOCTYPE html>
<html lang="el">

<head>
    <%@ include file="includes/header.jsp" %>
    <title>Σύνδεση - Ballet Net</title>
</head>

<body>

    <!-- Minimal Navbar -->
    <nav class="navbar navbar-light bg-light mb-4 shadow-sm py-2">
        <div class="container-fluid px-3 px-md-5 d-flex justify-content-between align-items-center flex-nowrap">
            <a class="navbar-brand fs-3 fw-bold d-flex align-items-center text-ballet m-0" href="index.jsp">
                <img src="photos/BalletArts.png" alt="Ballet Arts Logo" height="48" class="me-2 me-md-3">
                Ballet Net
            </a>
            <a href="index.jsp" class="btn btn-outline-ballet rounded-pill px-3 py-1 fw-semibold">
                <i class="bi bi-house-door me-1"></i> <span data-el="Αρχική Σελίδα" data-en="Home">Αρχική Σελίδα</span>
            </a>
        </div>
    </nav>

    <!-- Login Container -->
    <div class="container d-flex flex-column justify-content-center align-items-center" role="main" style="min-height: calc(100vh - 120px);">
        <div class="row justify-content-center w-100">
            <div class="col-12 col-sm-10 col-md-7 col-lg-5 col-xl-4">
                <div class="card border-0 rounded-4 p-4 p-md-5 auth-card">

                    <!-- Heading -->
                    <div class="text-center mb-4">
                        <div class="auth-icon rounded-circle d-inline-flex align-items-center justify-content-center mb-3">
                            <i class="bi bi-person-heart fs-2"></i>
                        </div>
                        <h2 class="fw-bold mb-2 auth-title" data-el="Σύνδεση" data-en="Sign in">Σύνδεση</h2>
                        <div class="auth-divider"></div>
                        <p class="text-muted small mb-0" data-el="Συνδεθείτε για να συνεχίσετε στο Ballet Net." data-en="Sign in to continue to Ballet Net.">
                            Συνδεθείτε για να συνεχίσετε στο Ballet Net.
                        </p>
                    </div>

                    <!-- Error message from the controller (escaped) -->
                    <% if (request.getAttribute("message") != null) { %>
                        <div class="alert alert-danger d-flex align-items-center rounded-3 small py-2" role="alert">
                            <i class="bi bi-exclamation-circle me-2"></i>
                            <div><%= esc(String.valueOf(request.getAttribute("message"))) %></div>
                        </div>
                    <% } %>

                    <!-- Login Form -->
                    <form method="post" action="loginController.jsp">

                        <div class="mb-3">
                            <label for="inputusername" class="form-label fw-semibold small" data-el="Όνομα χρήστη" data-en="Username">Όνομα χρήστη</label>
                            <div class="input-group auth-input">
                                <span class="input-group-text"><i class="bi bi-person"></i></span>
                                <input type="text" name="username" id="inputusername" class="form-control form-control-lg"
                                       autocomplete="username" required autofocus>
                            </div>
                        </div>

                        <div class="mb-4">
                            <label for="inputpassword" class="form-label fw-semibold small" data-el="Κωδικός" data-en="Password">Κωδικός</label>
                            <div class="input-group auth-input">
                                <span class="input-group-text"><i class="bi bi-lock"></i></span>
                                <input type="password" name="password" id="inputpassword" class="form-control form-control-lg"
                                       autocomplete="current-password" required>
                                <button type="button" class="btn btn-toggle-pass" id="togglePassword" aria-label="Show / hide password">
                                    <i class="bi bi-eye"></i>
                                </button>
                            </div>
                        </div>

                        <div class="d-grid">
                            <button type="submit" class="btn btn-ballet btn-lg rounded-pill fw-semibold shadow-sm">
                                <i class="bi bi-box-arrow-in-right me-2"></i>
                                <span data-el="Είσοδος" data-en="Sign in">Είσοδος</span>
                            </button>
                        </div>
                    </form>

                    <div class="mt-4 text-center">
                        <a class="small text-muted text-decoration-none error-details-toggle collapsed"
                           data-bs-toggle="collapse" href="#demoAccounts" role="button"
                           aria-expanded="false" aria-controls="demoAccounts">
                            <i class="bi bi-chevron-down me-1"></i>
                            <span data-el="Δοκιμαστικοί λογαριασμοί" data-en="Demo accounts">Δοκιμαστικοί λογαριασμοί</span>
                        </a>
                    </div>
                    <div class="collapse" id="demoAccounts">
                        <div class="auth-help rounded-3 p-3 mt-3 small">
                            <ul class="list-unstyled mb-0">
                                <li><strong>John Doe:</strong> <code>jdoe</code> / <code>1111</code></li>
                                <li><strong>Mary Smith:</strong> <code>msmith</code> / <code>2222</code></li>
                                <li><strong>Bob Jakson:</strong> <code>bjakson</code> / <code>3333</code></li>
                            </ul>
                        </div>
                    </div>

                </div>
            </div>
        </div>
    </div>

    <!-- Scripts -->
    <script>
        // Εμφάνιση / απόκρυψη κωδικού
        const passInput = document.getElementById('inputpassword');
        const toggleBtn = document.getElementById('togglePassword');
        toggleBtn.addEventListener('click', function () {
            const show = passInput.type === 'password';
            passInput.type = show ? 'text' : 'password';
            toggleBtn.querySelector('i').className = show ? 'bi bi-eye-slash' : 'bi bi-eye';
        });

        // Γλώσσα
        const language = navigator.language || navigator.userLanguage;
        const selectedLanguage = language.startsWith("el") ? "el" : "en";
        document.documentElement.lang = selectedLanguage;
        document.querySelectorAll("[data-el]").forEach(function (element) {
            element.textContent = element.getAttribute("data-" + selectedLanguage);
        });
    </script>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>

</html>