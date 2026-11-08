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
Teacher teacher = (Teacher) user;
%>

<!DOCTYPE html>
<html lang="el">

<head>
    <%@ include file="../includes/header.jsp" %>
    <title>Update Class Progress - Ballet Net</title>
</head>

<body>

    <%@ include file="../includes/teacher_details.jsp" %>
            <div class="card-body p-4 p-md-5">
                <!-- Tabs ανάμεσα στις δύο σελίδες της Δασκάλας -->
                <ul class="nav nav-pills pill-tabs gap-2 mb-4" id="teacherNav">
                    <li class="nav-item">
                        <a class="nav-link active" href="update_class_progress.jsp">
                            <i class="bi bi-journal-check me-2"></i>Πρόοδος ύλης τμήματος (Update Class Progress)
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="update_student_progress.jsp">
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