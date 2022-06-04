/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package org;

import java.io.*;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.*;
import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;


/**
 *
 * 
 */
@WebServlet(name = "RegisterCA", urlPatterns = {"/register_ca"})
public class RegisterCA extends HttpServlet {

    static Connection con = null;
    PreparedStatement pst = null;
    ResultSet rst = null;
    String fname = null;
    String lname = null;
    String dob = null;
    String username = null;
    String email = null;
    String contno = null;
    String location = null;
    String city = null;
    String pwd = null;
    int i = 0;

     @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String id = request.getParameter("id");
        String status = request.getParameter("status");
        HttpSession session = request.getSession(true);

        try {
            con = DB.Connect.openConnection();
            String query = "UPDATE tbluser SET status='"+status+"' WHERE userid= '" + id + "' ";
            System.out.println(query);
            pst = con.prepareStatement(query);
            i = pst.executeUpdate();

        } catch (Exception e) {
        }

        if (i > 0) {
            session.setAttribute("MSG", "User statuc has been successfuly changed !!");
            response.sendRedirect("userlist.jsp");
        } else {
            session.setAttribute("MSG", "User statuc has not been changed !!");
            response.sendRedirect("userlist.jsp");
        }
    }
    
    
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(true);
        PrintWriter out = response.getWriter();
        response.setContentType("text/html");
        ServletConfig config = getServletConfig();
        String context = config.getServletContext().getRealPath("/");

        //connection from database
        try {
            con = DB.Connect.openConnection();
        } catch (Exception e) {
        }


        fname = request.getParameter("txtfname");
        lname = request.getParameter("txtlname");
        username = request.getParameter("txtusername");
        dob = request.getParameter("txtdob");
        email = request.getParameter("txtemail");
        contno = request.getParameter("txtcontno");
        location = request.getParameter("txtlocation");
        city = request.getParameter("txtcity");
        pwd = request.getParameter("txtpwd");


        try {
            i=DB.Connect.saveUsers(fname, lname, username, email, location, "True", "ca", pwd, contno);

        } catch (Exception e) {
            e.printStackTrace();;
        }

        //success or failure message
        if (i > 0) {

            session.setAttribute("MSG", "Your register form has been successfully submited.");
            response.sendRedirect("register_ca.jsp");
        } else {
            session.setAttribute("MSG", "Your register form has not been submited.");
            response.sendRedirect("register_ca.jsp");
        } 


    }
}
