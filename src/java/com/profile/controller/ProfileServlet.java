package com.profile.controller;

import com.profile.bean.ProfileBean;
import java.io.IOException;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/ProfileServlet")
public class ProfileServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Create JavaBean
        ProfileBean profile = new ProfileBean();
        profile.setName(request.getParameter("name"));
        profile.setStudentID(request.getParameter("studentID"));
        profile.setProgram(request.getParameter("program"));
        profile.setEmail(request.getParameter("email"));
        profile.setHobbies(request.getParameter("hobbies"));
        profile.setIntro(request.getParameter("intro"));

        try {
            Connection conn = DriverManager.getConnection(
                "jdbc:derby://localhost:1527/profileInfo", "app", "app");

            String sql = "INSERT INTO profiles (name, studentID, program, email, hobbies, intro) "
                       + "VALUES (?, ?, ?, ?, ?, ?)";

            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, profile.getName());
            ps.setString(2, profile.getStudentID());
            ps.setString(3, profile.getProgram());
            ps.setString(4, profile.getEmail());
            ps.setString(5, profile.getHobbies());
            ps.setString(6, profile.getIntro());

            ps.executeUpdate();
            conn.close();

        } catch (SQLException e) {
            e.printStackTrace();
        }

        // Send bean to JSP
        request.setAttribute("profile", profile);
        request.getRequestDispatcher("ProfileDisplay.jsp").forward(request, response);
    }
}
