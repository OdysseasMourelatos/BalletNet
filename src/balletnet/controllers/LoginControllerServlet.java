package balletnet.controllers;

import java.io.*;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import balletnet.dao.UserDAO;
import balletnet.models.*;

@WebServlet("/loginController")
public class LoginControllerServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.sendRedirect("login_form.jsp");
    }

    @Override
    public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");

        String username = request.getParameter("username");
        String password = request.getParameter("password");
        
        try {
            UserDAO userDao = new UserDAO();
            User user = userDao.authenticate(username, password);
            
            HttpSession session = request.getSession();
            session.setAttribute("user", user);

            Role role = user.getRole();
            if (role == Role.SECRETARY) {
                response.sendRedirect(request.getContextPath() + "/dashboard/manage_schedule.jsp");
            } else if (role == Role.TEACHER) {
                response.sendRedirect(request.getContextPath() + "/dashboard/update_class_progress.jsp");
            } else if (role == Role.STUDENT) {
                response.sendRedirect(request.getContextPath() + "/dashboard/view_student_progress.jsp");
            } else {
                throw new Exception("Unknown role");
            }
        } catch (Exception e) {
            request.setAttribute("errorMessage", e.getMessage());
            RequestDispatcher dispatcher = request.getRequestDispatcher("login_form.jsp");
            dispatcher.forward(request, response);
        }

    }
}