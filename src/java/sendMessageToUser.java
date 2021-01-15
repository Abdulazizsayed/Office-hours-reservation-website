/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

import com.database.DatabaseConnection;
import com.database.Queries;
import com.mail.JavaMailUtil;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.ResultSet;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author DELL
 */
@WebServlet(urlPatterns = {"/sendMessageToUser"})
public class sendMessageToUser extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            try {
                DatabaseConnection dbConnection = new DatabaseConnection();
                Connection con = dbConnection.connect();
                String to = request.getParameter("to");
                String toName = request.getParameter("toName");
                String content = request.getParameter("content");
                HttpSession session = request.getSession(false);
                
                Queries q = new Queries(con, "messages");
                int rows = q.insert("`from`, `to`, content", session.getAttribute("id") + ", " + to + ", '" + content + "'");
                
                if (rows > 0) {
                    Queries q1 = new Queries(con, "notifications");
                    int rows2 = q1.insert("`from`, `to`, content, link", session.getAttribute("id") + ", " + to + ", '" + session.getAttribute("username") + " sent a message to you', 'member.jsp?id=" + to + "'");
                    out.print(" dummy ");
                } else {
                    out.print("");
                }
            } catch (Exception ex) {
                ex.printStackTrace();
            }
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
