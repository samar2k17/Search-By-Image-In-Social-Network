/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package org;

import java.io.*;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
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
@WebServlet(name = "MyAccount", urlPatterns = {"/myAccount"})
public class MyAccount extends HttpServlet {

    static Connection con = null;
    PreparedStatement pst = null;
    ResultSet rst = null;
    String fname = null;
    String lname = null;
  
    String gender = null;
    String email = null;
    String contno = null;
    String location = null;
    String city = null;
    String id = null;
    int i = 0;

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
        gender = request.getParameter("cmbgender");
       
        email = request.getParameter("txtemail");
        contno = request.getParameter("txtcontno");
        location = request.getParameter("txtlocation");
        city = request.getParameter("txtcity");
        id = request.getParameter("hidid");


        try {
            String sqlquery = "update tbluser set fname=?,lname=?,emailid=?,mobile_no=?,address=? where userid = '" + id + "'";
            pst = con.prepareStatement(sqlquery);
            pst.setString(1, fname);
            pst.setString(2, lname);          
           
            pst.setString(3, email);
            pst.setString(4, contno);
            pst.setString(5, location);
          


            i = pst.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
        }

        //success or failure message
        if (i > 0) {

            session.setAttribute("MSG", "Your profile has been successfully update.");
            response.sendRedirect("myaccount.jsp");
        } else {
            session.setAttribute("MSG", "Your profile has not been update.");
            response.sendRedirect("myaccount.jsp");
        }


    }
}
