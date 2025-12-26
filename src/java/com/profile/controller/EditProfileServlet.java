package com.profile.servlet;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


@WebServlet("/editProfile")
public class EditProfileServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String studentID = request.getParameter("studentID");
        String name = request.getParameter("name");
        String program = request.getParameter("program");
        String email = request.getParameter("email");
        String hobbies = request.getParameter("hobbies");
        String intro = request.getParameter("intro");

        try {
            Connection conn = DriverManager.getConnection("jdbc:derby://localhost:1527/profileInfo","app","app");
            String sql = "UPDATE profiles SET name=?, program=?, email=?, hobbies=?, intro=? WHERE studentID=?";
            PreparedStatement pst = conn.prepareStatement(sql);
            pst.setString(1, name);
            pst.setString(2, program);
            pst.setString(3, email);
            pst.setString(4, hobbies);
            pst.setString(5, intro);
            pst.setString(6, studentID);

            int updated = pst.executeUpdate();
            conn.close();

            if(updated > 0){
                // Use session or request attribute to show SweetAlert
                request.getSession().setAttribute("successMessage", "Profile updated successfully!");
            } else {
                request.getSession().setAttribute("successMessage", "No changes were made.");
            }

        } catch(Exception e){
            e.printStackTrace();
            request.getSession().setAttribute("successMessage", "Error updating profile.");
        }

        // Redirect back to viewProfiles.jsp
        response.sendRedirect("viewProfiles");
    }
}
