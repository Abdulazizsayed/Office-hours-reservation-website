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
import java.util.Date;
import java.sql.ResultSet;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.time.Month;
import java.util.Calendar;
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
@WebServlet(urlPatterns = {"/reserve"})
public class reserve extends HttpServlet {

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
                String id = request.getParameter("id");
                String date = request.getParameter("date"); 
                
                if (id.equals("") || date.equals("")) {
                    response.sendRedirect("failure.jsp?page=index.jsp&reason=Id-or-date-is-empty");
                } else {
                    Date date1 = Calendar.getInstance().getTime();  
                    DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");  
                    String strDate = dateFormat.format(date1); 
                    LocalDate currentDate = LocalDate.parse(strDate);

                    // Get an instance of LocalTime 
                    // from date 
                    LocalDate inputDate = LocalDate.parse(date); 

                    if (inputDate.getYear() < currentDate.getYear()) {
                        response.sendRedirect("failure.jsp?page=index.jsp&reason=Date-is-in-past");

                    } else if (inputDate.getYear() == currentDate.getYear() && inputDate.getMonthValue() < currentDate.getMonthValue()) {
                        response.sendRedirect("failure.jsp?page=index.jsp&reason=Date-is-in-past");

                    } else if (inputDate.getYear() == currentDate.getYear() && inputDate.getMonthValue() == currentDate.getMonthValue() && inputDate.getDayOfMonth() < currentDate.getDayOfMonth()) {
                        response.sendRedirect("failure.jsp?page=index.jsp&reason=Date-is-in-past");

                    } else {
                        Date converted = new SimpleDateFormat("yyyy-MM-dd").parse(date);  

                        Calendar cal = Calendar.getInstance();
                        cal.setTime(converted);

                        Queries q = new Queries(con, "office_hours");
                        ResultSet res = q.select("*", "id=" + id);

                        if (res.next()) {
                            if (res.getInt("day") != cal.get(Calendar.DAY_OF_WEEK)) {
                                response.sendRedirect("failure.jsp?page=index.jsp&reason=Day-not-matching-office-hour-day");

                            } else {
                                Queries q1 = new Queries(con, "reservations");
                                ResultSet res1 = q1.select("*", "office_hour_id=" + id + " AND `date`='" + date + "'");

                                if (res1.next()) {
                                    response.sendRedirect("failure.jsp?page=index.jsp&reason=This-slot-with-date-entered-already-reserved-before");

                                } else {
                                    HttpSession session = request.getSession(false);
                                    int rows = q1.insert("office_hour_id, student_id, date", id + ", " + session.getAttribute("id") + ", '" + date + "'");
                                    if (rows > 0) {
                                        Queries q2 = new Queries(con, "notifications");
                                        int rows2 = q2.insert("`from`, `to`, content, link", session.getAttribute("id") + ", " + res.getString("instructor_id") + ", '" + session.getAttribute("username") + " reserved an appointment with you', 'reservations.jsp?id="+res.getString("instructor_id") + "'");
                                        Queries userQ = new Queries(con, "users");
                                        ResultSet email = userQ.select("email", "id="+res.getString("instructor_id"));
                                        if (rows2 > 0 && email.next()) {
                                            JavaMailUtil.sendMail(email.getString("email"), "A student reserved an appointment with you with the following date: " + date, session.getAttribute("username") + " reserved an appointment with you");
                                            response.sendRedirect("success.jsp?page=index.jsp&content=You-reserved-the-slot-successfuly");
                                        } else {
                                            response.sendRedirect("failure.jsp?page=index.jsp&reason=Error-in-the-system");
                                        }
                                    } else {
                                        response.sendRedirect("failure.jsp?page=index.jsp&reason=Error-in-the-system");
                                    }
                                }
                            }
                        } else {
                            response.sendRedirect("failure.jsp?page=index.jsp&reason=Office-hour-id-is'nt-valid");
                        }
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
