/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package org;

import DB.SMSSender;
import DB.SimpleEmail;
import java.io.*;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.*;
import java.util.logging.Level;
import java.util.logging.Logger;
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
@WebServlet(name = "friendRequest", urlPatterns = {"/friendRequest"})
public class friendRequest extends HttpServlet {

    static Connection con = null;
    PreparedStatement pst = null;
    ResultSet rst = null;
    String userid;
    int i = 0;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String id = request.getParameter("id");
        String status = request.getParameter("status");
        HttpSession session = request.getSession(true);
        userid = session.getAttribute("ID").toString();
        String msg = "";
        
        System.out.println("id"+id+" status="+status);
        if (status.equals("new")) {
            try {
                String query = "insert into  tblfriends (userid,fuserid,status,rdate)values(?,?,?,NOW()) ";

                con = DB.Connect.openConnection();
             

                pst = con.prepareStatement(query);
                  
                pst.setString(1, userid);
                pst.setString(2, id);
                pst.setString(3, "Pending");
                i = pst.executeUpdate();
                if (i > 0) {
                    msg = "Friend Request sent successfully";
                } else {
                    msg = "Failed to send Request";
                }
            } catch (SQLException ex) {
                Logger.getLogger(friendRequest.class.getName()).log(Level.SEVERE, null, ex);
            }

        } else if (status.equals("cancel") || status.equals("remove")) {
            try {
                con = DB.Connect.openConnection();
                String query = "delete from tblfriends where fid= '" + id + "' ";
                pst = con.prepareStatement(query);
                i = pst.executeUpdate();
                if (i > 0) {
                    msg = "Friend Request " + status + " successfully";
                } else {
                    msg = "Failed to " + status + " Request";
                }
            } catch (Exception e) {
            }
        } else if (status.equals("accept")) {
            try {
                con = DB.Connect.openConnection();
                String query = "UPDATE tblfriends SET status='Accepted' WHERE fid= '" + id + "' ";
                pst = con.prepareStatement(query);
                i = pst.executeUpdate();
                if (i > 0) {
                    msg = "Friend Request accepted successfully";
                } else {
                    msg = "Failed to accept Request";
                }
            } catch (Exception e) {
            }
        }

        if (i > 0) {
            session.setAttribute("MSG", msg);
            response.sendRedirect("searchfriends.jsp");
        } else {
            session.setAttribute("MSG", msg);
            response.sendRedirect("searchfriends.jsp");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

    }
}
