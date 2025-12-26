
import java.io.IOException;
import java.sql.*;
import java.util.ArrayList;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/deleteProfile")
public class DeleteProfileServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String studentID = request.getParameter("studentID");
        if(studentID != null && !studentID.isEmpty()) {
            try {
                Connection conn = DriverManager.getConnection(
                        "jdbc:derby://localhost:1527/profileInfo", "app", "app");

                PreparedStatement ps = conn.prepareStatement("DELETE FROM profiles WHERE studentID = ?");
                ps.setString(1, studentID);
                ps.executeUpdate();

                conn.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        response.sendRedirect("viewProfiles"); // redirect back to profiles page
    }
}
