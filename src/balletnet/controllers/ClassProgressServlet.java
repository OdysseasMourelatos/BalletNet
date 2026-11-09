package balletnet.controllers;

import java.io.*;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/classProgress")
public class ClassProgressServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private static final String APP_BASE = "/BalletNet/WebContent";

    @Override
    public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // For now, we will just redirect to the update_class_progress.jsp page
        response.sendRedirect(APP_BASE + "/dashboard/update_class_progress.jsp");
    }

    @Override
    public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // For now, we will just redirect to the update_class_progress.jsp page
        response.sendRedirect(APP_BASE + "/dashboard/update_class_progress.jsp");
    }
}