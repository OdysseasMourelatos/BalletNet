<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%-- Unhandled JSP exceptions are forwarded internally to this common error page. --%>
<%@ page import="balletnet.models.User, balletnet.models.Teacher, balletnet.models.Student, balletnet.models.StudentProgress, java.util.List" %>
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
</head>

<body>

    <%@ include file="../includes/teacher_details.jsp" %>
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
                            <% List<StudentProgress> studentsProgress = request.setAttribute("studentsProgress");
                                if (studentsProgress.size() != 0) {
                                    for (StudentProgress stProgress : studentsProgress) {     
                                %>
                            <tbody>
                                <tr>
                                    <td class="ps-3">
                                        <div class="d-flex align-items-center gap-3">
                                            <div class="student-avatar rounded-circle d-flex align-items-center justify-content-center fw-bold">ΜΓ</div>
                                            <div>
                                                <div class="fw-bold"><%=stProgress.getStudent().getFirstName() + " " + stProgress.getStudent().getLastName()%></div>
                                                <span class="text-muted small"><%=stProgress.getStudent().getStudentID()%></span>
                                            </div>
                                        </div>
                                    </td>
                                    <td>
                                        <div class="d-flex align-items-center gap-2">
                                            <div class="progress attendance-bar"><div class="progress-bar bg-success" style="width: 92%"></div></div>
                                            <span class="small fw-semibold text-success">23/25 (92%)</span>
                                        </div>
                                    </td>
                                    <td><span class="badge rounded-pill bg-primary-subtle text-primary border border-primary-subtle px-3 py-2">Προχωρημένη</span></td>
                                    <td>
                                        <div class="form-check form-switch">
                                            <input class="form-check-input" type="checkbox" role="switch" id="readySwitch1" checked onchange="toggleReadyLabel(this)">
                                            <label class="form-check-label fw-semibold text-success" for="readySwitch1">Exam Ready</label>
                                        </div>
                                    </td>
                                    <td class="text-center">
                                        <button class="btn btn-outline-ballet btn-sm rounded-circle" onclick="openStudentModal('Μαρία Γεωργίου', '#ST-104', '23 από 25 μαθήματα (92%)', 'Προχωρημένη', 'Εξαιρετική τοποθέτηση κορμού, έτοιμη για την εξέταση.')" title="Προβολή καρτέλας">
                                            <i class="bi bi-pencil-square"></i>
                                        </button>
                                    </td>
                                </tr>
                            </tbody>
                        </table>
                    </div>

                    <div id="alertTab2" class="alert alert-success d-none align-items-center rounded-3 py-2 px-3 mt-4 mb-0 border-0 shadow-sm" role="alert">
                        <i class="bi bi-check-circle-fill me-2 fs-5"></i>
                        <span>Η ατομική αξιολόγηση και η λίστα ετοιμότητας εξετάσεων ενημερώθηκαν!</span>
                    </div>

                    <div class="mt-4">
                        <button type="button" class="btn btn-ballet rounded-pill px-4 fw-semibold shadow-sm" onclick="showInlineAlert('alertTab2');">
                            <i class="bi bi-check2-circle me-1"></i> Οριστικοποίηση αξιολόγησης
                        </button>
                    </div>
                </div>

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
                            <h5 class="fw-bold mb-0" id="modalStudentName">Μαρία Γεωργίου</h5>
                            <span class="text-muted small" id="modalStudentId">ID: #ST-104</span>
                        </div>
                    </div>

                    <ul class="list-group list-group-flush small mb-3">
                        <li class="list-group-item d-flex justify-content-between px-0">
                            <span class="text-muted">Παρουσίες μαθήτριας:</span>
                            <strong id="modalStudentAttendance">23 από 25 μαθήματα (92%)</strong>
                        </li>
                        <li class="list-group-item d-flex justify-content-between align-items-center px-0">
                            <span class="text-muted">Τεχνική επάρκεια:</span>
                            <select class="form-select form-select-sm w-auto rounded-3 fw-semibold" id="modalStudentLevelSelect">
                                <option value="Αρχάρια">Αρχάρια</option>
                                <option value="Υπό εξέλιξη">Υπό εξέλιξη</option>
                                <option value="Προχωρημένη">Προχωρημένη</option>
                            </select>
                        </li>
                    </ul>

                    <div class="mb-3">
                        <label for="modalStudentNotes" class="form-label fw-semibold small text-muted">Προσωπικές παρατηρήσεις διδάσκουσας:</label>
                        <textarea class="form-control rounded-3 small" id="modalStudentNotes" rows="3"></textarea>
                    </div>

                    <div class="d-grid">
                        <button type="button" class="btn btn-ballet rounded-pill fw-semibold" data-bs-dismiss="modal" onclick="showInlineAlert('alertTab2');">
                            Αποθήκευση σημειώσεων
                        </button>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Bootstrap Bundle JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

    <script>
        function showInlineAlert(alertId) {
            const box = document.getElementById(alertId);
            if (!box) return;
            box.classList.replace('d-none', 'd-flex');
            setTimeout(() => box.classList.replace('d-flex', 'd-none'), 3500);
        }

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

        function openStudentModal(name, id, attendance, level, notes) {
            document.getElementById('modalStudentName').innerText = name;
            document.getElementById('modalStudentId').innerText = 'ID: ' + id;
            document.getElementById('modalStudentAttendance').innerText = attendance;
            
            const levelSelect = document.getElementById('modalStudentLevelSelect');
            if (levelSelect) {
                levelSelect.value = level;
            }
            
            document.getElementById('modalStudentNotes').value = notes;
            bootstrap.Modal.getOrCreateInstance(document.getElementById('studentDetailModal')).show();
        }
    </script>
</body>

</html>