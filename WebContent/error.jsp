<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page isErrorPage="true" %>

<%!
    // Απλό HTML escape (χωρίς εξάρτηση από JSTL)
    private static String esc(String s) {
        if (s == null) return "";
        return s.replace("&", "&amp;")
                .replace("<", "&lt;")
                .replace(">", "&gt;")
                .replace("\"", "&quot;")
                .replace("'", "&#39;");
    }
%>
<%
    // Τεχνικό μήνυμα (υποστηρίζει Tomcat 9 - javax και Tomcat 10+ - jakarta)
    String errorDetails = null;
    if (exception != null) {
        errorDetails = exception.getMessage() != null ? exception.getMessage() : exception.toString();
    } else {
        Object msg = request.getAttribute("javax.servlet.error.message");
        if (msg == null) msg = request.getAttribute("jakarta.servlet.error.message");
        if (msg != null) errorDetails = msg.toString();
    }
%>

<!DOCTYPE html>
<html lang="el">

<head>
    <%@ include file="includes/header.jsp"%>
    <title>Σφάλμα Συστήματος - Ballet Net</title>
</head>

<body>

    <!-- Minimal Navbar -->
    <nav class="navbar navbar-light bg-light mb-4 shadow-sm py-2">
        <div class="container-fluid px-3 px-md-5 d-flex justify-content-between align-items-center">
            <a class="navbar-brand fs-3 fw-bold d-flex align-items-center text-ballet m-0" href="<%=request.getContextPath()%>/BalletNet/WebContent/home.jsp">
                <img src="<%=request.getContextPath()%>/BalletNet/WebContent/photos/BalletArts.png" alt="Ballet Arts Logo" height="48" class="me-2 me-md-3">
                Ballet Net
            </a>
            <a href="<%=request.getContextPath()%>/BalletNet/WebContent/home.jsp" class="btn btn-outline-ballet rounded-pill px-3 py-1 fw-semibold">
                <i class="bi bi-house-door me-1"></i> Αρχική Σελίδα
            </a>
        </div>
    </nav>

    <!-- Error Content Container -->
    <div class="container d-flex flex-column justify-content-center align-items-center" style="min-height: calc(100vh - 120px);">
        <div class="row justify-content-center w-100">
            <div class="col-12 col-md-10 col-lg-8 col-xl-7">
                <div class="card border-0 rounded-4 p-4 p-md-5 text-center error-card">

                    <!-- Icon -->
                    <div class="mb-4">
                        <div class="error-icon rounded-circle d-inline-flex align-items-center justify-content-center">
                            <i class="bi bi-flower1 fs-1"></i>
                        </div>
                    </div>

                    <!-- Heading -->
                    <h2 class="fw-bold mb-2 error-title">Κάτι πήγε στραβά</h2>
                    <div class="error-divider"></div>

                    <p class="text-muted mb-4 mx-auto error-text">
                        Παρουσιάστηκε ένα απρόβλεπτο σφάλμα κατά την επεξεργασία του αιτήματός σας.
                        Παρακαλούμε δοκιμάστε ξανά ή επιστρέψτε στην αρχική σελίδα.
                    </p>

                    <!-- Technical Details (collapsible, escaped) -->
                    <% if (errorDetails != null) { %>
                        <p class="mb-3">
                            <a class="small text-muted text-decoration-none error-details-toggle collapsed"
                               data-bs-toggle="collapse" href="#errDetails" role="button"
                               aria-expanded="false" aria-controls="errDetails">
                                <i class="bi bi-chevron-down me-1"></i> Τεχνικές λεπτομέρειες
                            </a>
                        </p>
                        <div class="collapse" id="errDetails">
                            <div class="text-start error-details rounded-3 p-3 mb-4 mx-auto w-100">
                                <span class="small fw-bold text-muted d-block mb-1">
                                    <i class="bi bi-bug me-1 text-danger"></i> Τεχνική Περιγραφή Σφάλματος:
                                </span>
                                <div class="small font-monospace text-danger text-break mb-0">
                                    <%= esc(errorDetails) %>
                                </div>
                            </div>
                        </div>
                    <% } %>

                    <!-- Actions -->
                    <div class="d-flex flex-wrap justify-content-center gap-3">
                        <button type="button" class="btn btn-outline-secondary rounded-pill px-4 py-2 fw-semibold" onclick="window.history.back();">
                            <i class="bi bi-arrow-left me-1"></i> Πίσω
                        </button>
                        <a href="<%=request.getContextPath()%>/BalletNet/WebContent/home.jsp" class="btn btn-ballet rounded-pill px-4 py-2 fw-semibold shadow-sm">
                            <i class="bi bi-house-door me-1"></i> Επιστροφή στην Αρχική
                        </a>
                    </div>

                </div>
            </div>
        </div>
    </div>

    <!-- Bootstrap Bundle JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>

</html>