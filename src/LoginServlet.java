import java.io.*;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.sql.*;

public class LoginServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String user = request.getParameter("username");
        String pass = request.getParameter("password");

        try {
            // Load the driver
            Class.forName("com.mysql.cj.jdbc.Driver");

            // Establish connection - Ensure the hostname 'activity-db' matches your Render DB service name
Connection con = DriverManager.getConnection("jdbc:mysql://activity-db:3306/activitydb", "root", "password123");
            PreparedStatement ps = con.prepareStatement(
                    "SELECT * FROM users WHERE username=? AND password=?");

            ps.setString(1, user);
            ps.setString(2, pass);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                HttpSession session = request.getSession();
                session.setAttribute("user", user);

                // Ensure Dashboard.html exists in your 'web' folder (check case sensitivity!)
                response.sendRedirect("dashboard.html");
            } else {
                response.setContentType("text/html");
                response.getWriter().println(
                        "<script>alert('Invalid Login'); window.location='index.html';</script>");
            }

            con.close();

        } catch (Exception e) {
            // This will now print the error to the browser instead of a blank screen
            response.setContentType("text/html");
            PrintWriter out = response.getWriter();
            out.println("<h3 style='color:red;'>Database Error:</h3><pre>");
            e.printStackTrace(out); 
            out.println("</pre>");
            out.println("<a href='index.html'>Go Back</a>");
        }
    }
}
