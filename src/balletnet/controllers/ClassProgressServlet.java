package balletnet.controllers;

import java.io.*;
import java.util.List;

import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import balletnet.dao.CourseGroupDAO;
import balletnet.models.CourseGroup;
import balletnet.models.Syllabus;
import balletnet.models.Teacher;

@WebServlet("/classProgress")
public class ClassProgressServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private static final String APP_BASE = "/BalletNet/WebContent";

    @Override
    public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        Teacher teacher = (Teacher) session.getAttribute("user");

        CourseGroupDAO courseGroupDAO = new CourseGroupDAO();
        List<CourseGroup> groups = courseGroupDAO.getCourseGroupsByTeacher(teacher);

        int totalStudents = 0;
        for (CourseGroup g: groups) {
            totalStudents += g.getStudents().size();
        }
        Syllabus syllabus = groups.get(0).getSyllabus();
        
        request.setAttribute("teacherGroups", groups);
        request.setAttribute("totalStudents", totalStudents);
        request.setAttribute("currentGroup", groups.isEmpty() ? null : groups.get(0));
        request.setAttribute("syllabus", syllabus);
        request.setAttribute("course_data", true);

        request.getRequestDispatcher("/dashboard/update_class_progress.jsp").forward(request, response);
    }

    @Override
    public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // For now, we will just redirect to the update_class_progress.jsp page
        response.sendRedirect(APP_BASE + "/dashboard/update_class_progress.jsp");
    }
}