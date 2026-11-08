<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%-- Unhandled JSP exceptions are forwarded internally to this common error page. --%>
<%@ page import="balletnet.models.User, balletnet.models.Teacher" %>
<%@ page errorPage="error.jsp" %>

<%
if (session.getAttribute("user") == null) {
	request.setAttribute("message", "login_required");
%>
	<jsp:forward page="../login_form.jsp"/>
<%
	return;
}

User user = (User) session.getAttribute("user");
if (!(user instanceof Teacher)) {
    request.setAttribute("message", "forbidden_role");
%>
	<jsp:forward page="../login_form.jsp"/>
<%
}
%>

<!DOCTYPE html>
<html lang="el">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Update Class Progress - Ballet Net</title>

    <link rel="icon" type="image/png" href="../photos/BalletArts.png">

    <!-- Bootstrap 5.3 CSS & Icons -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">

    <!-- Google Fonts -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@400;500;600&family=Playfair+Display:ital,wght@0,600;0,700;1,600&display=swap" rel="stylesheet">

    <!-- Custom CSS -->
    <link rel="stylesheet" type="text/css" href="../css/background_style.css">
</head>

<body>

    <!-- Responsive Navbar -->
    <nav class="navbar navbar-light bg-light mb-4 shadow-sm py-2">
        <div class="container-fluid px-3 px-md-5 d-flex justify-content-between align-items-center flex-nowrap">
            <a class="navbar-brand fs-3 fs-md-2 fw-bold d-flex align-items-center text-ballet m-0" href="../index.html">
                <img src="../photos/BalletArts.png" alt="Ballet Arts Logo" height="48" class="me-2 me-md-3">
                Ballet Net
            </a>

            <div class="d-flex align-items-center gap-2">
                <!-- Profile Trigger -->
                <button type="button" class="profile-trigger d-flex align-items-center" data-bs-toggle="offcanvas" data-bs-target="#profileOffcanvas" aria-controls="profileOffcanvas" title="Προβολή προφίλ">
                    <div class="d-none d-md-block text-end me-2">
                        <span class="d-block fw-bold text-dark lh-sm">Ελένη Κυριακίδου</span>
                        <span class="badge bg-ballet px-2 py-1" style="font-size: 0.75rem;">RAD Certified Instructor</span>
                    </div>
                    <div class="bg-ballet rounded-circle text-white d-flex align-items-center justify-content-center fw-bold shadow-sm" style="width: 44px; height: 44px; font-size: 1.1rem;">
                        ΕΚ
                    </div>
                </button>

                <!-- Κουμπί Εξόδου -->
                <a href="../index.html" class="btn btn-outline-danger rounded-pill px-3 py-1 fw-semibold ms-1" title="Αποσύνδεση">
                    <i class="bi bi-box-arrow-right me-md-1"></i> <span class="d-none d-sm-inline">Έξοδος</span>
                </a>
            </div>
        </div>
    </nav>

    <!-- Profile Offcanvas -->
    <div class="offcanvas offcanvas-end" tabindex="-1" id="profileOffcanvas" aria-labelledby="profileOffcanvasLabel">
        <div class="offcanvas-header">
            <h5 class="offcanvas-title fw-bold text-ballet" id="profileOffcanvasLabel">Το προφίλ μου</h5>
            <button type="button" class="btn-close" data-bs-dismiss="offcanvas" aria-label="Close"></button>
        </div>
        <div class="offcanvas-body">
            <div class="text-center mb-4">
                <div class="bg-ballet rounded-circle text-white d-flex align-items-center justify-content-center mx-auto mb-3 fw-bold avatar-lg">ΕΚ</div>
                <h5 class="fw-bold mb-1">Ελένη Κυριακίδου</h5>
                <p class="text-muted small mb-0">eleni.kyr@balletarts.gr</p>
            </div>

            <ul class="list-group list-group-flush small">
                <li class="list-group-item px-0 d-flex align-items-center">
                    <i class="bi bi-award text-ballet fs-5 me-3"></i>
                    <div>
                        <span class="text-muted d-block">Ειδικότητα</span>
                        <span class="fw-semibold">RAD Classical Ballet</span>
                    </div>
                </li>
                <li class="list-group-item px-0 d-flex align-items-center">
                    <i class="bi bi-door-open text-ballet fs-5 me-3"></i>
                    <div>
                        <span class="text-muted d-block">Ανάθεση αιθουσών</span>
                        <span class="fw-semibold">Room 1 (Studio A)</span>
                    </div>
                </li>
                <li class="list-group-item px-0 d-flex align-items-center">
                    <i class="bi bi-collection text-ballet fs-5 me-3"></i>
                    <div>
                        <span class="text-muted d-block">Ενεργά τμήματα</span>
                        <span class="fw-semibold">2 τμήματα (17 μαθήτριες)</span>
                    </div>
                </li>
            </ul>
        </div>
    </div>

    <!-- Main Workspace -->
    <div class="container mb-5">
        <div class="card border-0 shadow-sm rounded-4 overflow-hidden">

            <!-- Profile band -->
            <div class="profile-band p-4 p-md-4">
                <div class="d-flex flex-column flex-lg-row align-items-lg-center gap-4">

                    <div class="d-flex align-items-center gap-3 flex-grow-1">
                        <div class="bg-ballet rounded-circle text-white d-flex align-items-center justify-content-center fw-bold flex-shrink-0 avatar-lg">
                            ΕΚ
                        </div>
                        <div>
                            <h4 class="fw-bold mb-1" style="font-family: 'Playfair Display', serif;">Ελένη Κυριακίδου</h4>
                            <div class="d-flex flex-wrap gap-2 mt-2">
                                <span class="stat-chip"><i class="bi bi-door-open me-1 text-ballet"></i><strong>Room 1</strong> (Studio A)</span>
                                <span class="stat-chip"><i class="bi bi-collection me-1 text-ballet"></i><strong>2</strong> τμήματα</span>
                                <span class="stat-chip"><i class="bi bi-people me-1 text-ballet"></i><strong>17</strong> μαθήτριες (Σύνολο)</span>
                            </div>
                        </div>
                    </div>

                    <!-- Επιλογή τμήματος -->
                    <div class="flex-shrink-0" style="min-width: 260px;">
                        <label for="classSelect" class="form-label small fw-semibold text-muted mb-1">
                            <i class="bi bi-collection-play me-1 text-ballet"></i>Ενεργό τμήμα
                        </label>
                        <select class="form-select rounded-pill fw-semibold border-secondary-subtle" id="classSelect">
                            <option value="1" selected>Intermediate Foundation (RAD)</option>
                            <option value="2">Grade 3 Ballet (RAD)</option>
                        </select>
                    </div>
                </div>
            </div>

            <div class="card-body p-4 p-md-5">

                <!-- Tabs ανάμεσα στις δύο σελίδες της Δασκάλας -->
                <ul class="nav nav-pills pill-tabs gap-2 mb-4" id="teacherNav">
                    <li class="nav-item">
                        <a class="nav-link active" href="update_class_progress.html">
                            <i class="bi bi-journal-check me-2"></i>Πρόοδος ύλης τμήματος (Update Class Progress)
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="update_student_progress.html">
                            <i class="bi bi-people-fill me-2"></i>Αξιολόγηση μαθητριών (Update Personal Student Progress)
                        </a>
                    </li>
                </ul>

                <!-- ΠΕΡΙΕΧΟΜΕΝΟ: UPDATE CLASS PROGRESS -->
                <div>
                    <div class="d-flex flex-wrap justify-content-between align-items-center mb-4 gap-2">
                        <div>
                            <h4 class="fw-bold mb-1 text-ballet">Διδακτέα ύλη: Intermediate Foundation</h4>
                            <p class="text-muted small mb-0">Ενημερώστε το ποσοστό κάλυψης ανά ενότητα της επίσημης ύλης RAD.</p>
                        </div>
                        <span class="badge bg-light text-dark border px-3 py-2 rounded-pill fs-6 shadow-sm">
                            Συνολική κάλυψη: <strong class="text-ballet ms-1" id="overallProgress">56%</strong>
                        </span>
                    </div>

                    <form id="formClassProgress" onsubmit="event.preventDefault(); showInlineAlert('alertTab1');">
                        <div class="row g-4 mb-4">
                            <div class="col-md-6">
                                <div class="d-flex justify-content-between mb-1">
                                    <label for="barreRange" class="form-label fw-semibold mb-0">1. Barre Work <span class="text-muted fw-normal small d-block">Pliés, Battements</span></label>
                                    <span class="fw-bold text-ballet" id="valBarre">75%</span>
                                </div>
                                <input type="range" class="syllabus-slider" min="0" max="100" value="75" id="barreRange">
                            </div>

                            <div class="col-md-6">
                                <div class="d-flex justify-content-between mb-1">
                                    <label for="centreRange" class="form-label fw-semibold mb-0">2. Port de Bras & Centre <span class="text-muted fw-normal small d-block">Κέντρο & ισορροπίες</span></label>
                                    <span class="fw-bold text-ballet" id="valCentre">60%</span>
                                </div>
                                <input type="range" class="syllabus-slider" min="0" max="100" value="60" id="centreRange">
                            </div>

                            <div class="col-md-6">
                                <div class="d-flex justify-content-between mb-1">
                                    <label for="allegroRange" class="form-label fw-semibold mb-0">3. Allegro & Pirouettes <span class="text-muted fw-normal small d-block">Άλματα, στροφές & enchaînements</span></label>
                                    <span class="fw-bold text-ballet" id="valAllegro">50%</span>
                                </div>
                                <input type="range" class="syllabus-slider" min="0" max="100" value="50" id="allegroRange">
                            </div>

                            <div class="col-md-6">
                                <div class="d-flex justify-content-between mb-1">
                                    <label for="pointeRange" class="form-label fw-semibold mb-0">4. Pointe Work <span class="text-muted fw-normal small d-block">Εισαγωγή στις πουέντ</span></label>
                                    <span class="fw-bold text-ballet" id="valPointe">40%</span>
                                </div>
                                <input type="range" class="syllabus-slider" min="0" max="100" value="40" id="pointeRange">
                            </div>
                        </div>

                        <div class="mb-4">
                            <label for="classNotes" class="form-label fw-semibold">Ημερολόγιο διδασκαλίας / παρατηρήσεις τμήματος</label>
                            <textarea class="form-control rounded-3" id="classNotes" rows="3" placeholder="π.χ. Ιδιαίτερη έμφαση στο échappé sur les pointes και στις ισορροπίες στο fondu."></textarea>
                        </div>

                        <div id="alertTab1" class="alert alert-success d-none align-items-center rounded-3 py-2 px-3 mb-3 border-0 shadow-sm" role="alert">
                            <i class="bi bi-check-circle-fill me-2 fs-5"></i>
                            <span>Η πρόοδος της διδακτέας ύλης αποθηκεύτηκε επιτυχώς!</span>
                        </div>

                        <button type="submit" class="btn btn-ballet rounded-pill px-4 fw-semibold shadow-sm">
                            <i class="bi bi-cloud-arrow-up me-1"></i> Αποθήκευση προόδου ύλης
                        </button>
                    </form>
                </div>

            </div>
        </div>
    </div>

    <!-- Bootstrap Bundle JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

    <script>
        // Sliders με δυναμικό μωβ γέμισμα
        const sliders = ['barre:valBarre', 'centre:valCentre', 'allegro:valAllegro', 'pointe:valPointe'].map(pair => {
            const [name, valId] = pair.split(':');
            return { el: document.getElementById(name + 'Range'), val: document.getElementById(valId) };
        });

        function updateSlider(s) {
            const v = s.el.value;
            s.val.innerText = v + '%';
            s.el.style.background = `linear-gradient(to right, #8B5A83 ${v}%, #dee2e6 ${v}%)`;
            calculateOverall();
        }

        function calculateOverall() {
            const total = sliders.reduce((sum, s) => sum + parseInt(s.el.value), 0);
            document.getElementById('overallProgress').innerText = Math.round(total / sliders.length) + '%';
        }

        sliders.forEach(s => {
            updateSlider(s);
            s.el.addEventListener('input', () => updateSlider(s));
        });

        function showInlineAlert(alertId) {
            const box = document.getElementById(alertId);
            if (!box) return;
            box.classList.replace('d-none', 'd-flex');
            setTimeout(() => box.classList.replace('d-flex', 'd-none'), 3500);
        }
    </script>
</body>

</html>