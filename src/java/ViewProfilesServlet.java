import com.profile.bean.ProfileBean;
import java.io.IOException;
import java.sql.*;
import java.util.ArrayList;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/viewProfiles")
public class ViewProfilesServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        ArrayList<ProfileBean> list = new ArrayList<>();

        // Get search and filter parameters
        String queryParam = request.getParameter("query"); 
        String programFilter = request.getParameter("programFilter");
        String hobbyFilter = request.getParameter("hobbyFilter");

        try {
            Connection conn = DriverManager.getConnection(
                "jdbc:derby://localhost:1527/profileInfo", "app", "app");

            // Build dynamic SQL
            StringBuilder sql = new StringBuilder("SELECT * FROM profiles WHERE 1=1");
            ArrayList<String> params = new ArrayList<>();

            if (queryParam != null && !queryParam.trim().isEmpty()) {
                sql.append(" AND (LOWER(name) LIKE ? OR studentID LIKE ?)");
                params.add("%" + queryParam.toLowerCase() + "%");
                params.add("%" + queryParam + "%");
            }

            if (programFilter != null && !programFilter.isEmpty()) {
                sql.append(" AND program = ?");
                params.add(programFilter);
            }

            if (hobbyFilter != null && !hobbyFilter.isEmpty()) {
                sql.append(" AND hobbies = ?");
                params.add(hobbyFilter);
            }

            PreparedStatement ps = conn.prepareStatement(sql.toString());

            // Set parameters
            for (int i = 0; i < params.size(); i++) {
                ps.setString(i + 1, params.get(i));
            }

            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                ProfileBean p = new ProfileBean();
                p.setName(rs.getString("name"));
                p.setStudentID(rs.getString("studentID"));
                p.setProgram(rs.getString("program"));
                p.setEmail(rs.getString("email"));
                p.setHobbies(rs.getString("hobbies"));
                p.setIntro(rs.getString("intro"));
                list.add(p);
            }
            conn.close();
        } catch (Exception e) {
            e.printStackTrace();
        }

        // Set attributes to preserve input values
        request.setAttribute("profiles", list);
        request.setAttribute("query", queryParam);
        request.setAttribute("programFilter", programFilter);
        request.setAttribute("hobbyFilter", hobbyFilter);

        request.getRequestDispatcher("viewProfiles.jsp").forward(request, response);
    }
}
