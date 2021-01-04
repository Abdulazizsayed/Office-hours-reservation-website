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
import java.nio.charset.Charset;
import java.security.SecureRandom;
import java.sql.Connection;
import java.sql.ResultSet;
import java.util.Random;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author DELL
 */
@WebServlet(urlPatterns = {"/signup"})
public class signup extends HttpServlet {

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
                String username = request.getParameter("username");
                String email = request.getParameter("email");
                
                if (username.equals("") || email.equals("")) {
                    response.sendRedirect("failure.jsp?page=signup.jsp&reason=You-didn't-entered-email-or-password");
                }
                
                
                String role = request.getParameter("role");
                
                Queries q = new Queries(con, "users");
                ResultSet res = q.select("id", "username = '" + username + "' OR email = '" + email + "'");
                out.println("Hello before error");

                if (res.next()) {
                    response.sendRedirect("failure.jsp?page=signup.jsp&reason=Username-or-email-used-before"); 
                } else {
                    // Generating random password
                    // ASCII range - alphanumeric (0-9, a-z, A-Z)
                    final String chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789";

                    SecureRandom random = new SecureRandom();
                    StringBuilder sb = new StringBuilder();

                    // each iteration of loop choose a character randomly from the given ASCII range
                    // and append it to StringBuilder instance

                    for (int i = 0; i < 8; i++) { // password length is 8
                        int randomIndex = random.nextInt(chars.length());
                        sb.append(chars.charAt(randomIndex));
                    }
                    
                    String password = sb.toString();
                    
                    int rows = q.insert("username, email, role, password", "'" + username + "', '" + email + "', " + role + ", '" + password + "'");
                    JavaMailUtil.sendMail(email, "Your automatically generated password", "Hello user!\n your password to join our system is: " + password);
                    if (rows > 0) {
                        response.sendRedirect("success.jsp?page=index.jsp&content=You-registered-successfully-Check-your-email-to-get-your-password");
                    } else {
                        response.sendRedirect("failure.jsp?page=signup.jsp&reason=Error-in-the-system!-Try-again-later");
                    }
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
