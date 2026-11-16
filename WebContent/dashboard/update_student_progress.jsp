<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%-- Unhandled JSP exceptions are forwarded internally to this common error page. --%>
<%@ page import="balletnet.models.User, balletnet.models.Teacher, balletnet.models.Student, balletnet.models.StudentProgress, balletnet.models.CourseGroup, java.util.List" %>
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
                        <input type="hidden" name="action" value="updateExamReadiness">
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
                                    int counter = 0;
                                    for (StudentProgress stProgress : studentsProgress) {
                                        counter++;
                                %>
                                    <tr>
                                        <td class="ps-3">
                                            <div class="d-flex align-items-center gap-3">
                                                <div class="student-avatar rounded-circle d-flex align-items-center justify-content-center fw-bold"><%=stProgress.getStudent().getFirstName().charAt(0) + "" + stProgress.getStudent().getLastName().charAt(0)%></div>
                                                <div>
                                                    <div class="fw-bold"><%=stProgress.getStudent().getFirstName() + " " + stProgress.getStudent().getLastName()%></div>
                                                    <span class="text-muted small">ID: #<%=stProgress.getStudent().getStudentID()%></span>
                                                </div>
                                            </div>
                                        </td>
                                        <td>
                                            <%
                                                int attendance = (stProgress.getAttendanceRate() != null) ? stProgress.getAttendanceRate().intValue() : 0;
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
                                                String text = "primary";

                                                if ("Αρχάρια".equals(readinessLevel)) {
                                                    text = "danger";
                                                } else if ("Υπό εξέλιξη".equals(readinessLevel)) {
                                                    text = "secondary";
                                                }
                                            %>
                                            <div class="d-flex align-items-center gap-2">
                                                <div class="progress attendance-bar">
                                                    <div class="progress-bar <%= bg %>" <%= "style=\"width: " + attendance + "%;\"" %>></div>
                                                </div>
                                                <span class="small fw-semibold <%= textColor %>">(<%= attendance %>%)</span>
                                            </div>
                                        </td>
                                        <td><span class="badge rounded-pill bg-<%= text %>-subtle text-<%= text %> border border-<%= text %>-subtle px-3 py-2"><%=readinessLevel%></span></td>
                                        <td>
                                            <%
                                                boolean isExamReady = stProgress.isExamReady();
                                                String textOutput = isExamReady ? "Exam Ready" : "Pending Review";
                                                String textClass = isExamReady ? "fw-semibold text-success" : "text-muted";
                                                String switchId = "readySwitch_" + counter;
                                            %>
                                            <div class="form-check form-switch">
                                                <input class="form-check-input" type="checkbox" name="areExamReady" value="<%= stProgress.getStudent().getStudentID() %>" role="switch" id="<%= switchId %>" <%= isExamReady ? "checked" : "" %> onchange="toggleReadyLabel(this)">
                                                <label class="form-check-label <%= textClass %>" for="<%= switchId %>"><%= textOutput %></label>
                                            </div>
                                        </td>
                                        <td class="text-center">
                                            <button type="button" class="btn btn-outline-ballet btn-sm rounded-circle"
                                                    data-student-id="<%= stProgress.getStudent().getStudentID() %>"
                                                    data-student-name="<%= stProgress.getStudent().getFirstName() %> <%= stProgress.getStudent().getLastName() %>"
                                                    data-attendance="(<%= attendance %>%)"
                                                    data-level="<%= readinessLevel %>"
                                                    data-notes="<%= (stProgress.getPersonalComments() != null) ? stProgress.getPersonalComments().replace("\"", "&quot;") : "" %>"
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
                        <div class="mt-4">
                            <button type="submit" class="btn btn-ballet rounded-pill px-4 fw-semibold shadow-sm">
                                <i class="bi bi-check2-circle me-1"></i> Αποθήκευση ετοιμότητας εξετάσεων
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
                                <%= "details".equals(success)
                                    ? "Η τεχνική επάρκεια και οι προσωπικές παρατηρήσεις της μαθήτριας αποθηκεύτηκαν!"
                                    : "Η λίστα ετοιμότητας εξετάσεων του τμήματος αποθηκεύτηκε!" %>
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
                <form action="<%=request.getContextPath()%>/servlet/balletnet.controllers.StudentProgressServlet" method="POST" class="m-0">
                    <input type="hidden" name="groupID" value="<%= (currentGroup != null) ? currentGroup.getGroupID() : "" %>">
                    <input type="hidden" name="action" value="updateStudentDetails">
                    <input type="hidden" name="studentID" id="modalHiddenStudentId">
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
                                <select class="form-select form-select-sm w-auto rounded-3 fw-semibold" id="modalStudentLevelSelect" name="readinessLevel">
                                    <option value="Αρχάρια">Αρχάρια</option>
                                    <option value="Υπό εξέλιξη">Υπό εξέλιξη</option>
                                    <option value="Προχωρημένη">Προχωρημένη</option>
                                </select>
                            </li>
                        </ul>

                        <div class="mb-3">
                            <label for="modalStudentNotes" class="form-label fw-semibold small text-muted">Προσωπικές παρατηρήσεις διδάσκουσας:</label>
                            <textarea class="form-control rounded-3 small" id="modalStudentNotes" name="personalComments" rows="3"></textarea>
                        </div>

                        <div class="d-grid">
                            <button type="submit" class="btn btn-ballet rounded-pill fw-semibold">
                                Αποθήκευση σημειώσεων
                            </button>
                        </div>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <!-- Bootstrap Bundle JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

    <script>
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
        }

        function updateReadyCount() {
            const checked = document.querySelectorAll('.form-switch input:checked').length;
            document.getElementById('readyCount').innerText = checked;
        }

        function openStudentModal(btn) {
            const id = btn.dataset.studentId;
            document.getElementById('modalHiddenStudentId').value = id;
            document.getElementById('modalStudentName').innerText = btn.dataset.studentName;
            document.getElementById('modalStudentId').innerText = 'ID: #' + id;
            document.getElementById('modalStudentAttendance').innerText = btn.dataset.attendance;

            const levelSelect = document.getElementById('modalStudentLevelSelect');
            if (levelSelect) {
                levelSelect.value = btn.dataset.level;
            }

            document.getElementById('modalStudentNotes').value = btn.dataset.notes || '';
            bootstrap.Modal.getOrCreateInstance(document.getElementById('studentDetailModal')).show();
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