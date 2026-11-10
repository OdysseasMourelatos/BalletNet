<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%-- Unhandled JSP exceptions are forwarded internally to this common error page. --%>
<%@ page import="balletnet.models.User, balletnet.models.Teacher, balletnet.models.Syllabus" %>
<%@ page errorPage="../error.jsp" %>

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

if (request.getAttribute("course_data") == null) {
%>
	<jsp:forward page="/servlet/balletnet.controllers.ClassProgressServlet"/>
<%
	return;
}
%>

<!DOCTYPE html>
<html lang="el">

<head>
    <%@ include file="../includes/header.jsp" %>
    <title>Update Class Progress - Ballet Net</title>
</head>

<body>

    <%@ include file="../includes/teacher_details.jsp" %>
            <%
            if ((Integer) request.getAttribute("teacherGroupsSize") == 0) {
            %>
            <div class="empty-state text-center py-5 px-3 mx-auto">

                <!-- Εικονίδιο -->
                <div class="es-badge mb-5">
                    <i class="bi bi-journal-x" aria-hidden="true"></i>
                </div>

                <!-- Τίτλος & περιγραφή -->
                <h3 class="es-title fw-bold mb-3">Δεν βρέθηκαν ενεργά τμήματα</h3>
                <p class="es-text text-muted mb-4">
                    Δεν υπάρχουν τμήματα διδασκαλίας ανατεθειμένα στο προφίλ σας για την τρέχουσα περίοδο.
                    Μόλις γίνει η ανάθεση, θα ενεργοποιηθούν αυτόματα οι παρακάτω λειτουργίες.
                </p>

                <!-- Τι θα ενεργοποιηθεί -->
                <div class="row g-3 mb-4 text-start">
                    <div class="col-sm-6">
                        <div class="es-feature">
                            <span class="es-ico"><i class="bi bi-journal-check" aria-hidden="true"></i></span>
                            <div class="lh-sm">
                                <div class="fw-semibold small">Πρόοδος ύλης τμήματος</div>
                                <div class="text-muted" style="font-size: .78rem;">Κάλυψη ανά ενότητα RAD</div>
                            </div>
                            <i class="bi bi-lock-fill es-lock" aria-hidden="true"></i>
                        </div>
                    </div>
                    <div class="col-sm-6">
                        <div class="es-feature">
                            <span class="es-ico"><i class="bi bi-people-fill" aria-hidden="true"></i></span>
                            <div class="lh-sm">
                                <div class="fw-semibold small">Αξιολόγηση μαθητριών</div>
                                <div class="text-muted" style="font-size: .78rem;">Προσωπική πρόοδος</div>
                            </div>
                            <i class="bi bi-lock-fill es-lock" aria-hidden="true"></i>
                        </div>
                    </div>
                </div>

                <!-- Κατάσταση λογαριασμού -->
                <div class="d-inline-flex align-items-center gap-2 px-3 py-2 rounded-pill bg-light border border-secondary-subtle small text-muted mb-4 shadow-sm">
                    <span class="spinner-grow spinner-grow-sm text-ballet" style="width: .6rem; height: .6rem;" aria-hidden="true"></span>
                    <span>Κατάσταση λογαριασμού: <strong class="text-dark">RAD Certified Instructor</strong> · Αναμονή ανάθεσης</span>
                </div>

                <!-- Ενέργειες -->
                <div class="d-flex flex-wrap justify-content-center gap-3 pt-1">
                    <a href="mailto:secretariat@balletarts.gr?subject=Ανάθεση%20Τμημάτων%20Διδασκαλίας%20-%20BalletNet"
                    class="btn btn-ballet rounded-pill px-4 py-2 fw-semibold shadow-sm d-inline-flex align-items-center gap-2">
                        <i class="bi bi-envelope"></i>
                        <span>Επικοινωνία με Γραμματεία</span>
                    </a>

                    <a href="<%=request.getContextPath()%>/servlet/balletnet.controllers.ClassProgressServlet"
                    class="btn btn-outline-secondary rounded-pill px-4 py-2 fw-semibold d-inline-flex align-items-center gap-2">
                        <i class="bi bi-arrow-clockwise"></i>
                        <span>Ανανέωση δεδομένων</span>
                    </a>
                </div>
            </div>


            <% } else { %>
            <div class="card-body p-4 p-md-5">
                <!-- Tabs ανάμεσα στις δύο σελίδες της Δασκάλας -->
                <ul class="nav nav-pills pill-tabs gap-2 mb-4" id="teacherNav">
                    <li class="nav-item">
                        <a class="nav-link active" href="<%=request.getContextPath()%>/BalletNet/WebContent/dashboard/update_class_progress.jsp">
                            <i class="bi bi-journal-check me-2"></i>Πρόοδος ύλης τμήματος (Update Class Progress)
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="<%=request.getContextPath()%>/BalletNet/WebContent/dashboard/update_student_progress.jsp">
                            <i class="bi bi-people-fill me-2"></i>Αξιολόγηση μαθητριών (Update Personal Student Progress)
                        </a>
                    </li>
                </ul>

                <!-- ΠΕΡΙΕΧΟΜΕΝΟ: UPDATE CLASS PROGRESS -->
                <% Syllabus syllabus = (Syllabus) request.getAttribute("syllabus"); %>
                <div>
                    <div class="d-flex flex-wrap justify-content-between align-items-center mb-4 gap-2">
                        <div>
                            <%
                            CourseGroup currentGroup = (CourseGroup) request.getAttribute("currentGroup");
                            String rawLevel = (currentGroup != null) ? currentGroup.getLevel() : "Intermediate Foundation";
                            String displayLevel = rawLevel.replaceAll("\\s*\\(.*\\)", "").trim();
                            %>

                            <h4 class="fw-bold mb-1 text-ballet">Διδακτέα ύλη: <%= displayLevel %></h4>
                            <p class="text-muted small mb-0">Ενημερώστε το ποσοστό κάλυψης ανά ενότητα της επίσημης ύλης RAD.</p>
                        </div>
                        <span class="badge bg-light text-dark border px-3 py-2 rounded-pill fs-6 shadow-sm">
                            Συνολική κάλυψη: <strong class="text-ballet ms-1" id="overallProgress"><%= (int) syllabus.calculateCompletion()%></strong>
                        </span>
                    </div>

                    <form action="<%=request.getContextPath()%>/servlet/balletnet.controllers.ClassProgressServlet" method="POST" class="m-0">
                        <input type="hidden" name="groupID" value="<%= (currentGroup != null) ? currentGroup.getGroupID() : "" %>">
                        <div class="row g-4 mb-4">
                            <div class="col-md-6">
                                <div class="d-flex justify-content-between mb-1">
                                    <label for="barreRange" class="form-label fw-semibold mb-0">1. Barre Work <span class="text-muted fw-normal small d-block">Pliés, Battements</span></label>
                                    <span class="fw-bold text-ballet" id="valBarre" ><%= syllabus.getBarreProgress()%></span>
                                </div>
                                <input type="range" name="barreProgress" class="syllabus-slider" min="0" max="100" value="<%= (int) syllabus.getBarreProgress()%>" id="barreRange">
                            </div>

                            <div class="col-md-6">
                                <div class="d-flex justify-content-between mb-1">
                                    <label for="centreRange" class="form-label fw-semibold mb-0">2. Port de Bras & Centre <span class="text-muted fw-normal small d-block">Κέντρο & ισορροπίες</span></label>
                                    <span class="fw-bold text-ballet" id="valCentre"><%= syllabus.getCentreProgress()%></span>
                                </div>
                                <input type="range" name="centreProgress" class="syllabus-slider" min="0" max="100" value="<%= (int) syllabus.getCentreProgress()%>" id="centreRange">
                            </div>

                            <div class="col-md-6">
                                <div class="d-flex justify-content-between mb-1">
                                    <label for="allegroRange" class="form-label fw-semibold mb-0">3. Allegro & Pirouettes <span class="text-muted fw-normal small d-block">Άλματα, στροφές & enchaînements</span></label>
                                    <span class="fw-bold text-ballet" id="valAllegro"><%= syllabus.getAllegroProgress()%></span>
                                </div>
                                <input type="range" name="allegroProgress" class="syllabus-slider" min="0" max="100" value="<%= (int) syllabus.getAllegroProgress()%>" id="allegroRange">
                            </div>

                            <div class="col-md-6">
                                <div class="d-flex justify-content-between mb-1">
                                    <label for="pointeRange" class="form-label fw-semibold mb-0">4. Pointe Work <span class="text-muted fw-normal small d-block">Εισαγωγή στις πουέντ</span></label>
                                    <span class="fw-bold text-ballet" id="valPointe"><%= syllabus.getPointeProgress()%></span>
                                </div>
                                <input type="range" name = "pointeProgress" class="syllabus-slider" min="0" max="100" value="<%= (int) syllabus.getPointeProgress()%>" id="pointeRange">
                            </div>
                        </div>

                        <div class="mb-4">
                            <label for="classNotes" class="form-label fw-semibold">Ημερολόγιο διδασκαλίας / παρατηρήσεις τμήματος</label>
                            <textarea class="form-control rounded-3" id="classNotes" name = "dailyLog" rows="3" placeholder="π.χ. Ιδιαίτερη έμφαση στο échappé sur les pointes και στις ισορροπίες στο fondu."><%= (syllabus != null && syllabus.getDailyLog() != null) ? syllabus.getDailyLog() : "" %></textarea>
                        </div>

                        <% if (request.getParameter("success") != null) { %>
                            <div id="alertTab1" class="alert alert-success d-flex align-items-center rounded-3 py-2 px-3 mb-3 border-0 shadow-sm" role="alert">
                                <i class="bi bi-check-circle-fill me-2 fs-5"></i>
                                <span>Η πρόοδος της διδακτέας ύλης αποθηκεύτηκε επιτυχώς!</span>
                            </div>
                        <% } %>

                        <button type="submit" class="btn btn-ballet rounded-pill px-4 fw-semibold shadow-sm">
                            <i class="bi bi-cloud-arrow-up me-1"></i> Αποθήκευση προόδου ύλης
                        </button>
                    </form>
                </div>
            <% } %>
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
            s.el.style.background = 'linear-gradient(to right, #8B5A83 ' + v + '%, #dee2e6 ' + v + '%)';
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

        // Αυτόματη απόκρυψη του alert επιτυχίας μετά από 5 δευτερόλεπτα
        window.addEventListener('DOMContentLoaded', () => {
            const alertBox = document.getElementById('alertTab1');
            if (alertBox) {
                setTimeout(() => {
                    alertBox.style.transition = 'opacity 0.6s ease';
                    alertBox.style.opacity = '0';
                    setTimeout(() => alertBox.remove(), 600);
                }, 5000);
            }
        });
    </script>
</body>

</html>