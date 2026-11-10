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

        if (session == null || session.getAttribute("user") == null || !(session.getAttribute("user") instanceof Teacher)) {
            response.sendRedirect(request.getContextPath() + "/BalletNet/WebContent/login_form.jsp?message=login_required");
            return;
        }
        Teacher teacher = (Teacher) session.getAttribute("user");

        CourseGroupDAO courseGroupDAO = new CourseGroupDAO();
        List<CourseGroup> groups = courseGroupDAO.getCourseGroupsByTeacher(teacher);

        int totalStudents = 0;

        String groupID = request.getParameter("groupID");
        if (groupID == null || groupID.trim().isEmpty()) {
            groupID = (String) session.getAttribute("selectedGroupId");
        }

        if (groups != null && !groups.isEmpty()) {
            for (CourseGroup g : groups) {
                if (g.getStudents() != null) {
                    totalStudents += g.getStudents().size();
                }
            }

            if (groupID == null || groupID.trim().isEmpty()) {
                groupID = groups.get(0).getGroupID();
            }
        }

        CourseGroup courseGroup = null;
        Syllabus syllabus = null;

        if (groupID != null) {
            courseGroup = courseGroupDAO.getCourseGroupByGroupID(groupID);
            if (courseGroup != null) {
                syllabus = courseGroup.getSyllabus();
            }
            session.setAttribute("selectedGroupId", groupID);
        }

        request.setAttribute("teacherGroups", groups);
        request.setAttribute("teacherGroupsSize", (groups != null) ? groups.size() : 0);
        request.setAttribute("totalStudents", totalStudents);
        request.setAttribute("currentGroup", courseGroup);
        request.setAttribute("syllabus", syllabus);
        request.setAttribute("course_data", true);

        request.getRequestDispatcher(APP_BASE + "/dashboard/update_class_progress.jsp").forward(request, response);
    }

    @Override
    public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");

        HttpSession session = request.getSession();
        if (session == null || session.getAttribute("user") == null || !(session.getAttribute("user") instanceof Teacher)) {
            response.sendRedirect(request.getContextPath() + "/BalletNet/WebContent/login_form.jsp?message=login_required");
            return;
        }

        String groupID = request.getParameter("groupID");
        String barreProgress = request.getParameter("barreProgress");
        String centreProgress = request.getParameter("centreProgress");
        String allegroProgress = request.getParameter("allegroProgress");
        String pointeProgress = request.getParameter("pointeProgress");
        String dailyLog = request.getParameter("dailyLog");
        
        double bP = Double.parseDouble(barreProgress);
        double cP = Double.parseDouble(centreProgress);
        double aP = Double.parseDouble(allegroProgress);
        double pP = Double.parseDouble(pointeProgress);

        Teacher teacher = (Teacher) session.getAttribute("user");

        CourseGroupDAO courseGroupDAO = new CourseGroupDAO();
        CourseGroup courseGroup = courseGroupDAO.getCourseGroupByGroupID(groupID);

        if (courseGroup != null) {
            teacher.updateClassProgress(courseGroup, bP, cP, aP, pP, dailyLog);
        }

        response.sendRedirect(request.getContextPath() + "/servlet/balletnet.controllers.ClassProgressServlet?groupID=" + groupID + "&success=true");
    }
}