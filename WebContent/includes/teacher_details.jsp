<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="balletnet.models.CourseGroup, java.util.List"%>

<!-- Responsive Navbar -->
<nav class="navbar navbar-light bg-light mb-4 shadow-sm py-2">
    <div class="container-fluid px-3 px-md-5 d-flex justify-content-between align-items-center flex-nowrap">
        <a class="navbar-brand fs-3 fs-md-2 fw-bold d-flex align-items-center text-ballet m-0" href="<%=request.getContextPath()%>/BalletNet/WebContent/home.jsp">
            <img src="<%=request.getContextPath()%>/BalletNet/WebContent/photos/BalletArts.png" alt="Ballet Arts Logo" height="48" class="me-2 me-md-3">
            Ballet Net
        </a>

        <div class="d-flex align-items-center gap-2">
            <!-- Profile Trigger -->
            <button type="button" class="profile-trigger d-flex align-items-center" data-bs-toggle="offcanvas" data-bs-target="#profileOffcanvas" aria-controls="profileOffcanvas" title="Προβολή προφίλ">
                <div class="d-none d-md-block text-end me-2">
                    <span class="d-block fw-bold text-dark lh-sm"><%= teacher.getFirstName() + " " + teacher.getLastName()%></span>
                    <span class="badge bg-ballet px-2 py-1" style="font-size: 0.75rem;">RAD Certified Instructor</span>
                </div>
                <div class="bg-ballet rounded-circle text-white d-flex align-items-center justify-content-center fw-bold shadow-sm" style="width: 44px; height: 44px; font-size: 1.1rem;">
                    <%= teacher.getFirstName().charAt(0) + "" + teacher.getLastName().charAt(0)%>
                </div>
            </button>

            <!-- Κουμπί Εξόδου -->
            <a href="<%=request.getContextPath()%>/BalletNet/WebContent/logout.jsp" class="btn btn-outline-danger rounded-pill px-3 py-1 fw-semibold ms-1" title="Αποσύνδεση">
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
            <div class="bg-ballet rounded-circle text-white d-flex align-items-center justify-content-center mx-auto mb-3 fw-bold avatar-lg"><%= teacher.getFirstName().charAt(0) + "" + teacher.getLastName().charAt(0)%></div>
            <h5 class="fw-bold mb-1"><%= teacher.getFirstName() + " " + teacher.getLastName()%></h5>
            <p class="text-muted small mb-0"><%= teacher.getEmail()%></p>
        </div>

        <ul class="list-group list-group-flush small">
            <li class="list-group-item px-0 d-flex align-items-center">
                <i class="bi bi-award text-ballet fs-5 me-3"></i>
                <div>
                    <span class="text-muted d-block">Ειδικότητα</span>
                    <span class="fw-semibold"><%= teacher.getSpecialization()%></span>
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
                    <% 
                    Integer size = (Integer) request.getAttribute("teacherGroupsSize");
                    String classes = (size != null && size == 1) ? "τμήμα" : "τμήματα";
                    
                    Integer stSize = (Integer) request.getAttribute("totalStudents");
                    String students = (stSize != null && stSize == 1) ? "μαθήτρια" : "μαθήτριες";
                    %> 
                    <span class="fw-semibold"><%= request.getAttribute("teacherGroupsSize")%> <%=classes%> (<%= request.getAttribute("totalStudents")%> <%=students%>)</span>
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
                        <%= teacher.getFirstName().charAt(0) + "" + teacher.getLastName().charAt(0)%>
                    </div>
                    <div>
                        <h4 class="fw-bold mb-1" style="font-family: 'Playfair Display', serif;"><%= teacher.getFirstName() + " " + teacher.getLastName()%></h4>
                        <div class="d-flex flex-wrap gap-2 mt-2">
                            <span class="stat-chip"><i class="bi bi-door-open me-1 text-ballet"></i><strong>Room 1</strong> (Studio A)</span>
                            <span class="stat-chip"><i class="bi bi-collection me-1 text-ballet"></i><strong><%= request.getAttribute("teacherGroupsSize")%></strong> <%=classes%></span>
                            <span class="stat-chip"><i class="bi bi-people me-1 text-ballet"></i><strong><%= request.getAttribute("totalStudents")%></strong> <%=students%> (Σύνολο)</span>
                        </div>
                    </div>
                </div>
                <%
                if ((Integer) request.getAttribute("teacherGroupsSize") != 0) {
                    String currentGroupID = (String) session.getAttribute("selectedGroupId");
                
                String targetEndpoint = (request.getAttribute("student_data") != null) ? "StudentProgressServlet" : "ClassProgressServlet";
                %>
                <!-- Επιλογή τμήματος -->
                <div class="flex-shrink-0" style="min-width: 260px;">
                    <form action="<%=request.getContextPath()%>/servlet/balletnet.controllers.<%=targetEndpoint%>" method="GET" class="m-0">
                        <label for="classSelect" class="form-label small fw-semibold text-muted mb-1">
                            <i class="bi bi-collection-play me-1 text-ballet"></i>Ενεργό τμήμα
                        </label>
                        <select class="form-select rounded-pill fw-semibold border-secondary-subtle" 
                                id="classSelect" 
                                name="groupID" 
                                onchange="this.form.submit();">
                            <%
                            List<CourseGroup> groups = (List<CourseGroup>) request.getAttribute("teacherGroups");
                            int i = 0;
                            for (CourseGroup group : groups) {
                                i++;
                                boolean isSelected = (currentGroupID != null && currentGroupID.equals(group.getGroupID())) 
                                    || (currentGroupID == null && i == 1);
                                if (isSelected) {
                                %>
                                    <option value="<%= group.getGroupID() %>" selected><%=group.getLevel()%></option>        
                                <% } else { %>
                                    <option value="<%= group.getGroupID() %>"><%=group.getLevel()%></option>
                                <%
                                }
                            }
                            %>
                        </select>
                    </form>
                </div>
                <% } %>
            </div>
        </div>