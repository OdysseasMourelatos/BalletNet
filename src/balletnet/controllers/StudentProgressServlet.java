package balletnet.controllers;

import java.io.*;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import balletnet.dao.CourseGroupDAO;
import balletnet.dao.StudentProgressDAO;
import balletnet.models.CourseGroup;
import balletnet.models.StudentProgress;
import balletnet.models.Syllabus;
import balletnet.models.Teacher;

@WebServlet("/studentProgress")
public class StudentProgressServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private static final String APP_BASE = "/BalletNet/WebContent";

    @Override
    public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        
        HttpSession session = request.getSession();

        if (session == null || session.getAttribute("user") == null || !(session.getAttribute("user") instanceof Teacher)) {
            response.sendRedirect(request.getContextPath() + "/BalletNet/WebContent/login_form.jsp?message=login_required");
            return;
        }

        Teacher teacher = (Teacher) session.getAttribute("user");

        CourseGroupDAO courseGroupDAO = new CourseGroupDAO();
        List<CourseGroup> groups = courseGroupDAO.getCourseGroupsByTeacher(teacher);

        int totalStudents = courseGroupDAO.getTotalStudentsByTeacher(teacher);

        String groupID = request.getParameter("groupID");
        if (groups != null && !groups.isEmpty()) {
            if (groupID == null || groupID.trim().isEmpty()) {
                groupID = (String) session.getAttribute("selectedGroupId");
                if (groupID == null || groupID.trim().isEmpty()) {
                    groupID = groups.get(0).getGroupID();
                }
            }
        }

        CourseGroup courseGroup = null;
        List<StudentProgress> studentsProgress = new ArrayList<>();
        int totalStudentsReady = 0;

        if (groupID != null) {
            courseGroup = courseGroupDAO.getCourseGroupByGroupID(groupID);
            if (courseGroup != null) {
                StudentProgressDAO studentProgressDAO = new StudentProgressDAO();
                studentsProgress = studentProgressDAO.getStudentsProgressByCourse(courseGroup);
                totalStudentsReady = studentProgressDAO.getNumberOfStudentsReadyForExam(courseGroup);
            }
            session.setAttribute("selectedGroupId", groupID);
        }

        request.setAttribute("teacherGroups", groups);
        request.setAttribute("teacherGroupsSize", (groups != null) ? groups.size() : 0);
        request.setAttribute("totalStudents", totalStudents);
        request.setAttribute("currentGroup", courseGroup);
        request.setAttribute("studentsProgress", studentsProgress);
        request.setAttribute("totalStudentsReady", totalStudentsReady);
        request.setAttribute("student_data", true);

        request.getRequestDispatcher(APP_BASE + "/dashboard/update_student_progress.jsp").forward(request, response);
    }

    @Override
    public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        //Pass
    }
}