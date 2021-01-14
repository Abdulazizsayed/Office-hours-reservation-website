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
import java.security.SecureRandom;
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
@WebServlet(urlPatterns = {"/sendMessageToSubject"})
public class sendMessageToSubject extends HttpServlet {

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
                
                Queries q = new Queries(con, "subject_messages");
                int rows = q.insert("`from`, `to`, content", session.getAttribute("id") + ", " + to + ", '" + content + "'");
                
                if (rows > 0) {
                    Queries q1 = new Queries(con, "user_subject");
                    ResultSet res = q1.selectWithMultipleTables("user_subject.*, users.*", "subject_id = " + to + " AND user_id = users.id AND user_id != " + session.getAttribute("id"), "users");
                    
                    while (res.next()) {
                        Queries q2 = new Queries(con, "notifications");
                        int rows2 = q2.insert("`from`, `to`, content", session.getAttribute("id") + ", " + res.getString("user_id") + ", '" + session.getAttribute("name") + " sent a message to the subject " + toName + "'");
                        if (rows2 > 0) {
                            JavaMailUtil.sendMail(res.getString("email"), "Message sent to your subject " + toName, content);
                        }
                    }
                    
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
