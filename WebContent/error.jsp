<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page isErrorPage="true" %>

<!DOCTYPE html>
<html lang="el">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Σφάλμα Συστήματος - Ballet Net</title>
    
    <link rel="icon" type="image/png" href="photos/BalletArts.png">
    
    <!-- Bootstrap 5.3 CSS & Icons -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">

    <!-- Google Fonts -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@400;500;600&family=Playfair+Display:ital,wght@0,600;0,700;1,600&display=swap" rel="stylesheet">

    <!-- Custom CSS -->
    <link rel="stylesheet" type="text/css" href="css/background_style.css">
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
                <i class="bi bi-house-door me-1"></i> Αρχική Σελίδα
            </a>
        </div>
    </nav>

    <!-- Error Content Container -->
    <div class="container my-5">
        <div class="row justify-content-center">
            <div class="col-12 col-md-8 col-lg-6">
                <div class="card border-0 shadow-sm rounded-4 p-4 p-md-5 text-center bg-white">
                    
                    <!-- Icon -->
                    <div class="mb-3">
                        <div class="bg-danger-subtle text-danger rounded-circle d-inline-flex align-items-center justify-content-center" style="width: 76px; height: 76px;">
                            <i class="bi bi-exclamation-octagon fs-1"></i>
                        </div>
                    </div>

                    <!-- Heading -->
                    <h2 class="fw-bold text-dark mb-2" style="font-family: 'Playfair Display', serif;">
                        Κάτι πήγε στραβά
                    </h2>
                    <p class="text-muted mb-4 small">
                        Παρουσιάστηκε ένα απρόβλεπτο σφάλμα κατά την επεξεργασία του αιτήματός σας. Παρακαλούμε δοκιμάστε ξανά ή επιστρέψτε στην αρχική σελίδα.
                    </p>

                    <!-- Technical Details (Εμφανίζονται δυναμικά αν υπάρχει Exception) -->
                    <% if (exception != null || request.getAttribute("javax.servlet.error.message") != null) { %>
                        <div class="text-start bg-light border rounded-3 p-3 mb-4">
                            <span class="small fw-bold text-muted d-block mb-1">
                                <i class="bi bi-bug me-1 text-danger"></i> Τεχνική Περιγραφή Σφάλματος:
                            </span>
                            <div class="small font-monospace text-danger text-break mb-0" style="font-size: 0.85rem;">
                                <% if (exception != null) { %>
                                    <%= exception.getMessage() != null ? exception.getMessage() : exception.toString() %>
                                <% } else { %>
                                    <%= request.getAttribute("javax.servlet.error.message") %>
                                <% } %>
                            </div>
                        </div>
                    <% } %>

                    <!-- Actions -->
                    <div class="d-flex justify-content-center gap-2">
                        <button type="button" class="btn btn-outline-secondary rounded-pill px-4 fw-semibold" onclick="window.history.back();">
                            <i class="bi bi-arrow-left me-1"></i> Πίσω
                        </button>
                        <a href="home.jsp" class="btn btn-ballet rounded-pill px-4 fw-semibold shadow-sm">
                            <i class="bi bi-box-arrow-in-right me-1"></i> Σύνδεση στο Σύστημα
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