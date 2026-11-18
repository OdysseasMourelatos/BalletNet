<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%-- Unhandled JSP exceptions are forwarded internally to this common error page. --%>
<%@ page import="balletnet.models.User, balletnet.models.Teacher, balletnet.models.Student, balletnet.models.StudentProgress, balletnet.models.CourseGroup, java.util.List, java.text.SimpleDateFormat" %>
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
    return;
}
Teacher teacher = (Teacher) user;

if (request.getAttribute("student_data") == null) {
%>
    <jsp:forward page="/servlet/balletnet.controllers.StudentProgressServlet"/>
<%
    return;
}
%>

<!DOCTYPE html>
<html lang="el">

<head>
    <%@ include file="../includes/header.jsp" %>
    <title>Update Student Progress - Ballet Net</title>
    <link rel="stylesheet" href="<%=request.getContextPath()%>/BalletNet/WebContent/css/teacher.css">
</head>

<body>

    <%@ include file="../includes/teacher_details.jsp" %>
            <% CourseGroup currentGroup = (CourseGroup) request.getAttribute("currentGroup"); %>
            <%
            if ((Integer) request.getAttribute("teacherGroupsSize") == 0) {
            %>
                <%@ include file="../includes/teacher_no_classes.jsp" %>

            <% } else { %>
            <div class="card-body p-4 p-md-5">

                <!-- Tabs ανάμεσα στις δύο σελίδες της Δασκάλας -->
                <ul class="nav nav-pills pill-tabs gap-2 mb-4" id="teacherNav">
                    <li class="nav-item">
                        <a class="nav-link" href="<%=request.getContextPath()%>/BalletNet/WebContent/dashboard/update_class_progress.jsp">
                            <i class="bi bi-journal-check me-2"></i>Πρόοδος ύλης τμήματος (Update Class Progress)
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link active" href="<%=request.getContextPath()%>/BalletNet/WebContent/dashboard/update_student_progress.jsp">
                            <i class="bi bi-people-fill me-2"></i>Αξιολόγηση μαθητριών (Update Personal Student Progress)
                        </a>
                    </li>
                </ul>

                <!-- ΠΕΡΙΕΧΟΜΕΝΟ: UPDATE PERSONAL STUDENT PROGRESS -->
                <div>
                    <div class="d-flex flex-wrap justify-content-between align-items-center mb-4 gap-2">
                        <div>
                            <h4 class="fw-bold mb-1 text-ballet">Αξιολόγηση μαθητριών & ετοιμότητα εξετάσεων</h4>
                            <p class="text-muted small mb-0">Ορίστε ποιες μαθήτριες πληρούν τα κριτήρια για τις εξετάσεις RAD.</p>
                        </div>
                        <span class="badge bg-light text-dark border px-3 py-2 rounded-pill shadow-sm">
                            <i class="bi bi-patch-check text-success me-1"></i>
                            <strong id="readyCount"><%=request.getAttribute("totalStudentsReady")%></strong> / <%= request.getAttribute("totalStudentsOfCourseGroup")%> έτοιμες
                        </span>
                    </div>

                    <% List<StudentProgress> studentsProgress = (List<StudentProgress>) request.getAttribute("studentsProgress"); %>

                    <form action="<%=request.getContextPath()%>/servlet/balletnet.controllers.StudentProgressServlet" method="POST" class="m-0">
                        <input type="hidden" name="groupID" value="<%= (currentGroup != null) ? currentGroup.getGroupID() : "" %>">
                        <div class="table-responsive border rounded-3">
                            <table class="table table-hover align-middle mb-0">
                                <thead class="table-light">
                                    <tr>
                                        <th class="ps-3">Μαθήτρια</th>
                                        <th>Παρουσίες</th>
                                        <th>Τεχνική επάρκεια</th>
                                        <th>Ετοιμότητα εξετάσεων</th>
                                        <th class="text-center">Ενέργεια</th>
                                    </tr>
                                </thead>
                                <tbody>
                                <%
                                if (studentsProgress != null && !studentsProgress.isEmpty()) {
                                    SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
                                    int counter = 0;
                                    for (StudentProgress stProgress : studentsProgress) {
                                        counter++;
                                        Student st = stProgress.getStudent();
                                        String studentId = st.getStudentID();
                                        String firstName = st.getFirstName();
                                        String lastName = st.getLastName();
                                        String fullName = firstName + " " + lastName;
                                        String initials = "" + firstName.charAt(0) + lastName.charAt(0);

                                        Double attendanceRate = stProgress.getAttendanceRate();
                                        int attendance = (attendanceRate != null) ? attendanceRate.intValue() : 0;
                                        String attendanceDisplay = (attendanceRate != null) ? "(" + attendance + "%)" : "—";
                                        String bg = "bg-success";
                                        String textColor = "text-success";
                                        if (attendance < 50) {
                                            bg = "bg-danger";
                                            textColor = "text-danger";
                                        } else if (attendance < 75) {
                                            bg = "bg-warning";
                                            textColor = "text-warning-emphasis";
                                        }

                                        String readinessLevel = stProgress.getReadinessLevel();
                                        boolean isAssessed = (readinessLevel != null && !readinessLevel.isEmpty());
                                        String hiddenLevelValue = isAssessed ? readinessLevel : "";
                                        String badgeColor = "primary";
                                        if ("Αρχάρια".equals(readinessLevel)) {
                                            badgeColor = "danger";
                                        } else if ("Υπό εξέλιξη".equals(readinessLevel)) {
                                            badgeColor = "secondary";
                                        }

                                        String rawNotes = (stProgress.getPersonalComments() != null) ? stProgress.getPersonalComments() : "";
                                        String escapedNotes = rawNotes.replace("&", "&amp;")
                                                                    .replace("\"", "&quot;")
                                                                    .replace("<", "&lt;")
                                                                    .replace(">", "&gt;");

                                        Teacher evalTeacher = stProgress.getTeacher();
                                        java.sql.Date evalDate = stProgress.getEvaluationDate();
                                        String evalMeta = (evalTeacher != null && evalDate != null)
                                                ? "(" + evalTeacher.getFirstName() + " " + evalTeacher.getLastName() + " • " + sdf.format(evalDate) + ")"
                                                : "(Δεν έχει αξιολογηθεί ακόμα)";

                                        boolean isExamReady = stProgress.isExamReady();
                                        String textOutput = isExamReady ? "Exam Ready" : "Pending Review";
                                        String textClass = isExamReady ? "fw-semibold text-success" : "text-muted";
                                        String switchId = "readySwitch_" + counter;
                                %>
                                    <tr>
                                        <td class="ps-3">
                                            <input type="hidden" name="studentIDs" value="<%= studentId %>">
                                            <input type="hidden" name="readinessLevel_<%= studentId %>" id="hiddenLevel_<%= studentId %>" value="<%= hiddenLevelValue %>">
                                            <input type="hidden" name="personalComments_<%= studentId %>" id="hiddenNotes_<%= studentId %>" value="<%= escapedNotes %>">
                                            <div class="d-flex align-items-center gap-3">
                                                <div class="student-avatar rounded-circle d-flex align-items-center justify-content-center fw-bold"><%= initials %></div>
                                                <div>
                                                    <div class="fw-bold"><%= fullName %></div>
                                                    <span class="text-muted small">ID: #<%= studentId %></span>
                                                </div>
                                            </div>
                                        </td>
                                        <td>
                                            <% if (attendanceRate != null) { %>
                                                <div class="d-flex align-items-center gap-2">
                                                    <div class="progress attendance-bar">
                                                        <div class="progress-bar <%= bg %>" <%= "style=\"width: " + attendance + "%;\"" %>></div>
                                                    </div>
                                                    <span class="small fw-semibold <%= textColor %>">(<%= attendance %>%)</span>
                                                </div>
                                            <% } else { %>
                                                <span class="text-muted">—</span>
                                            <% } %>
                                        </td>
                                        <td>
                                            <% if (isAssessed) { %>
                                                <span id="badgeLevel_<%= studentId %>" class="badge rounded-pill bg-<%= badgeColor %>-subtle text-<%= badgeColor %> border border-<%= badgeColor %>-subtle px-3 py-2"><%= readinessLevel %></span>
                                            <% } else { %>
                                                <span id="badgeLevel_<%= studentId %>" class="text-muted">—</span>
                                            <% } %>
                                        </td>
                                        <td>
                                            <div class="form-check form-switch">
                                                <input class="form-check-input" type="checkbox" name="areExamReady" value="<%= studentId %>" role="switch" id="<%= switchId %>" <%= isExamReady ? "checked" : "" %> onchange="toggleReadyLabel(this)">
                                                <label class="form-check-label <%= textClass %>" for="<%= switchId %>"><%= textOutput %></label>
                                            </div>
                                        </td>
                                        <td class="text-center">
                                            <button type="button" class="btn btn-outline-ballet btn-sm rounded-circle"
                                                    id="editBtn_<%= studentId %>"
                                                    data-student-id="<%= studentId %>"
                                                    data-student-name="<%= fullName %>"
                                                    data-attendance="<%= attendanceDisplay %>"
                                                    data-eval-meta="<%= evalMeta %>"
                                                    onclick="openStudentModal(this)"
                                                    title="Προβολή καρτέλας">
                                                <i class="bi bi-pencil-square"></i>
                                            </button>
                                        </td>
                                    </tr>
                                <%
                                    }
                                }
                                %>
                                </tbody>
                                                            </table>
                        </div>

                        <% if (studentsProgress != null && !studentsProgress.isEmpty()) { %>
                        <div id="stagingAlert" class="alert alert-info d-none align-items-center rounded-3 py-2 px-3 mt-3 mb-0 border-0 shadow-sm" role="alert">
                            <i class="bi bi-info-circle-fill me-2 fs-5"></i>
                            <span id="stagingAlertText"></span>
                        </div>
                        <div class="mt-4">
                            <button type="submit" class="btn btn-ballet rounded-pill px-4 fw-semibold shadow-sm">
                                <i class="bi bi-check2-circle me-1"></i> Οριστικοποίηση αξιολόγησης
                            </button>
                        </div>
                        <% } %>
                    </form>

                    <% if (studentsProgress == null || studentsProgress.isEmpty()) { %>
                        <div class="alert alert-light border d-flex align-items-center rounded-3 py-3 px-4 mt-3 mb-0 shadow-sm" role="alert">
                            <i class="bi bi-info-circle-fill text-ballet me-3 fs-5"></i>
                            <span class="text-muted fw-medium">Δεν υπάρχουν εγγεγραμμένοι μαθητές στο συγκεκριμένο τμήμα.</span>
                        </div>
                    <% } %>

                    <% String success = request.getParameter("success");
                    if (success != null) { %>
                        <div id="alertTab2" class="alert alert-success d-flex align-items-center rounded-3 py-2 px-3 mt-4 mb-0 border-0 shadow-sm" role="alert">
                            <i class="bi bi-check-circle-fill me-2 fs-5"></i>
                            <span>
                                Η ατομική αξιολόγηση και η λίστα ετοιμότητας εξετάσεων ενημερώθηκαν!
                            </span>
                        </div>
                    <% } %>
                </div>
            <% } %>
            </div>
        </div>
    </div>

    <!-- Student Detail Modal -->
    <div class="modal fade" id="studentDetailModal" tabindex="-1" aria-labelledby="studentDetailModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content rounded-4 border-0 shadow">
                <div class="modal-header border-0 pb-0">
                    <h5 class="modal-title fw-bold text-ballet" id="studentDetailModalLabel">Καρτέλα προόδου μαθήτριας</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body p-4">
                    <div class="d-flex align-items-center mb-3">
                        <div class="bg-ballet rounded-circle text-white d-flex align-items-center justify-content-center fw-bold me-3" style="width: 50px; height: 50px; font-size: 1.2rem;">
                            <i class="bi bi-person"></i>
                        </div>
                        <div>
                            <h5 class="fw-bold mb-0" id="modalStudentName">—</h5>
                            <span class="text-muted small" id="modalStudentId">ID: —</span>
                        </div>
                    </div>
                    <ul class="list-group list-group-flush small mb-3">
                        <li class="list-group-item d-flex justify-content-between px-0">
                            <span class="text-muted">Παρουσίες μαθήτριας:</span>
                            <strong id="modalStudentAttendance">—</strong>
                        </li>
                        <li class="list-group-item d-flex justify-content-between align-items-center px-0">
                        <span class="text-muted">Τεχνική επάρκεια:</span>
                        <select class="form-select form-select-sm w-auto rounded-3 fw-semibold" id="modalStudentLevelSelect">
                            <option value="" disabled selected>Επιλέξτε επίπεδο...</option>
                            <option value="Αρχάρια">Αρχάρια</option>
                            <option value="Υπό εξέλιξη">Υπό εξέλιξη</option>
                            <option value="Προχωρημένη">Προχωρημένη</option>
                        </select>
                    </li>
                    </ul>

                    <div class="mb-3">
                        <label for="modalStudentNotes" class="form-label fw-semibold small text-muted">
                            Προσωπικές παρατηρήσεις διδάσκουσας:
                            <span class="fw-normal text-muted ms-1" id="modalEvalMeta"></span>
                        </label>
                        <textarea class="form-control rounded-3 small" id="modalStudentNotes" rows="3" placeholder="Καταχωρίστε τεχνικές παρατηρήσεις..."></textarea>
                    </div>

                    <div class="d-grid">
                        <button type="button" class="btn btn-ballet rounded-pill fw-semibold" onclick="applyStudentModalChanges()">
                            Εφαρμογή αλλαγών
                        </button>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Bootstrap Bundle JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

    <script>
        let activeStudentId = null;
        const modifiedStudents = new Set();
        const loggedInTeacherName = "<%= teacher.getFirstName() + " " + teacher.getLastName() %>";

        function toggleReadyLabel(checkbox) {
            const label = checkbox.nextElementSibling;
            if (checkbox.checked) {
                label.innerText = 'Exam Ready';
                label.className = 'form-check-label fw-semibold text-success';
            } else {
                label.innerText = 'Pending Review';
                label.className = 'form-check-label text-muted';
            }
            updateReadyCount();
            showStagingAlert(checkbox.value);
        }

        function updateReadyCount() {
            const checked = document.querySelectorAll('.form-switch input:checked').length;
            document.getElementById('readyCount').innerText = checked;
        }

        function openStudentModal(btn) {
            activeStudentId = btn.dataset.studentId;
            document.getElementById('modalStudentName').innerText = btn.dataset.studentName;
            document.getElementById('modalStudentId').innerText = 'ID: #' + activeStudentId;
            document.getElementById('modalStudentAttendance').innerText = btn.dataset.attendance;
            document.getElementById('modalEvalMeta').innerText = btn.dataset.evalMeta || '';

            const currentLevel = document.getElementById('hiddenLevel_' + activeStudentId).value;
            const currentNotes = document.getElementById('hiddenNotes_' + activeStudentId).value;

            const levelSelect = document.getElementById('modalStudentLevelSelect');
            if (levelSelect) {
                levelSelect.value = currentLevel;
            }

            document.getElementById('modalStudentNotes').value = currentNotes;
            bootstrap.Modal.getOrCreateInstance(document.getElementById('studentDetailModal')).show();
        }

        function applyStudentModalChanges() {
            if (!activeStudentId) return;

            const levelSelect = document.getElementById('modalStudentLevelSelect');
            const selectedLevel = levelSelect.value;
            const enteredNotes = document.getElementById('modalStudentNotes').value;

            // Αν η μαθήτρια δεν έχει αξιολογηθεί ακόμα, απαιτείται επιλογή επιπέδου
            if (!selectedLevel) {
                levelSelect.focus();
                return;
            }

            // 1. Ενημέρωση των hidden inputs της φόρμας
            document.getElementById('hiddenLevel_' + activeStudentId).value = selectedLevel;
            document.getElementById('hiddenNotes_' + activeStudentId).value = enteredNotes;

            // 2. Ζωντανή ενημέρωση του badge «Τεχνική επάρκεια» στον πίνακα (μετατρέπει και το «—» σε κανονικό badge)
            const badge = document.getElementById('badgeLevel_' + activeStudentId);
            if (badge) {
                let badgeColor = 'primary';
                if (selectedLevel === 'Αρχάρια') {
                    badgeColor = 'danger';
                } else if (selectedLevel === 'Υπό εξέλιξη') {
                    badgeColor = 'secondary';
                }
                badge.innerText = selectedLevel;
                badge.className = 'badge rounded-pill bg-' + badgeColor + '-subtle text-' + badgeColor + ' border border-' + badgeColor + '-subtle px-3 py-2';
            }

            // 3. Ενημέρωση των μεταδεδομένων (συνδεδεμένη διδάσκουσα + σημερινή ημερομηνία) στο κουμπί της γραμμής
            const today = new Date();
            const formattedDate = String(today.getDate()).padStart(2, '0') + '/'
                                + String(today.getMonth() + 1).padStart(2, '0') + '/'
                                + today.getFullYear();
            const editBtn = document.getElementById('editBtn_' + activeStudentId);
            if (editBtn) {
                editBtn.dataset.evalMeta = '(' + loggedInTeacherName + ' • ' + formattedDate + ')';
            }

            // 4. Εμφάνιση/ανανέωση του μηνύματος προσωρινής αποθήκευσης
            showStagingAlert(activeStudentId);

            // 5. Κλείσιμο του modal
            const modalEl = document.getElementById('studentDetailModal');
            const modalInstance = bootstrap.Modal.getInstance(modalEl);
            if (modalInstance) {
                modalInstance.hide();
            }
        }

        function showStagingAlert(studentId) {
            if (studentId) {
                modifiedStudents.add(studentId);
            }

            const stagingAlert = document.getElementById('stagingAlert');
            const stagingText = document.getElementById('stagingAlertText');
            if (!stagingAlert || !stagingText) return;

            const count = modifiedStudents.size;
            const label = (count === 1) ? '1 μαθήτρια' : count + ' μαθήτριες';
            stagingText.innerHTML = 'Αποθηκεύτηκαν προσωρινά αλλαγές για <strong>' + label + '</strong>. Πατήστε <strong>«Οριστικοποίηση αξιολόγησης»</strong> για οριστική καταχώριση στη βάση.';

            stagingAlert.classList.remove('d-none');
            stagingAlert.classList.add('d-flex');

            // Διακριτικό οπτικό refresh σε κάθε νέα αλλαγή
            stagingAlert.style.transition = 'none';
            stagingAlert.style.opacity = '0.35';
            requestAnimationFrame(() => {
                stagingAlert.style.transition = 'opacity 0.35s ease';
                stagingAlert.style.opacity = '1';
            });
        }

        // Αυτόματη απόκρυψη του alert επιτυχίας μετά από 5 δευτερόλεπτα
        window.addEventListener('DOMContentLoaded', () => {
            const alertBox = document.getElementById('alertTab2');
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