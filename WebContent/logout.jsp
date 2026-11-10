<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page errorPage="error.jsp" %>
<%
    if (session != null) {
        session.invalidate();
    }
%>

<!DOCTYPE html>
<html lang="el">
<head>
    <%@ include file="includes/header.jsp" %>
    <title>Αποσύνδεση - Ballet Net</title>
</head>
<body>

    <!-- Minimal Navbar -->
    <nav class="navbar navbar-light bg-light mb-4 shadow-sm py-2">
        <div class="container-fluid px-3 px-md-5 d-flex justify-content-between align-items-center">
            <a class="navbar-brand fs-3 fw-bold d-flex align-items-center text-ballet m-0" href="home.jsp">
                <img src="photos/BalletArts.png" alt="Ballet Arts Logo" height="48" class="me-2 me-md-3">
                Ballet Net
            </a>
            <a href="home.jsp" class="btn btn-outline-ballet rounded-pill px-3 py-1 fw-semibold">
                <i class="bi bi-house-door me-1"></i> <span data-el="Αρχική Σελίδα" data-en="Home">Αρχική Σελίδα</span>
            </a>
        </div>
    </nav>

    <!-- Logout Card -->
    <div class="container d-flex flex-column justify-content-center align-items-center" role="main" style="min-height: calc(100vh - 140px);">
        <div class="row justify-content-center w-100">
            <div class="col-12 col-sm-10 col-md-7 col-lg-5 col-xl-4">
                <div class="card border-0 rounded-4 p-4 p-md-5 auth-card text-center shadow-sm">

                    <div class="auth-icon rounded-circle d-inline-flex align-items-center justify-content-center mb-3 text-success bg-success bg-opacity-10" style="width: 70px; height: 70px; margin: 0 auto;">
                        <i class="bi bi-check2-circle fs-1"></i>
                    </div>

                    <h3 class="fw-bold mb-2 auth-title" data-el="Επιτυχής Αποσύνδεση" data-en="Logged Out Successfully">Επιτυχής Αποσύνδεση</h3>
                    <div class="auth-divider mx-auto my-3"></div>
                    
                    <p class="text-muted small mb-4" data-el="Έχετε αποσυνδεθεί με ασφάλεια από το Ballet Net." data-en="You have safely logged out of Ballet Net.">
                        Έχετε αποσυνδεθεί με ασφάλεια από το Ballet Net.
                    </p>

                    <div class="d-grid gap-2">
                        <a href="login_form.jsp" class="btn btn-ballet btn-lg rounded-pill fw-semibold shadow-sm">
                            <i class="bi bi-box-arrow-in-right me-2"></i>
                            <span data-el="Επανασύνδεση" data-en="Sign in again">Επανασύνδεση</span>
                        </a>
                        <a href="home.jsp" class="btn btn-outline-secondary rounded-pill fw-semibold">
                            <span data-el="Επιστροφή στην Αρχική" data-en="Back to Home">Επιστροφή στην Αρχική</span>
                        </a>
                    </div>

                    <p class="text-muted small mt-4 mb-0">
                        <span data-el="Αυτόματη μεταφορά σε " data-en="Redirecting in ">Αυτόματη μεταφορά σε </span>
                        <span id="countdown" class="fw-bold">5</span>...
                    </p>

                </div>
            </div>
        </div>
    </div>

    <script>
        // Αυτόματο redirect μετά από 5 δευτερόλεπτα
        let seconds = 5;
        const countdownEl = document.getElementById("countdown");
        const timer = setInterval(() => {
            seconds--;
            if (countdownEl) countdownEl.textContent = seconds;
            if (seconds <= 0) {
                clearInterval(timer);
                window.location.href = "login_form.jsp";
            }
        }, 1000);
    </script>

    <%@ include file="includes/footer.jsp" %>
</body>
</html>