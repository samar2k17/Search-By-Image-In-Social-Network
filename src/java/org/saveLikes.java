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
@WebServlet(name = "saveLikes", urlPatterns = {"/saveLikes"})
public class saveLikes extends HttpServlet {

    static Connection con = null;
    PreparedStatement pst = null;
    ResultSet rst = null;
    String userid;
    int i = 0;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

      
        String id = request.getParameter("id");
        HttpSession session = request.getSession(true);
String msg="";
            try {
                String query = "delete from tbllikes where lid='"+id+"' ";

                con = DB.Connect.openConnection();
             

                pst = con.prepareStatement(query);
                  
               
                i = pst.executeUpdate();
                if (i > 0) {
                    msg = "Like deleted successfully";
                } else {
                    msg = "Failed to delete like";
                }
            } catch (SQLException ex) {
                Logger.getLogger(saveLikes.class.getName()).log(Level.SEVERE, null, ex);
            }

        

        if (i > 0) {
            session.setAttribute("MSG", msg);
            response.sendRedirect("likes.jsp");
        } else {
            session.setAttribute("MSG", msg);
            response.sendRedirect("likes.jsp");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

       
        try {
            HttpSession session = request.getSession(true);
            userid = session.getAttribute("ID").toString();
            String msg = "";
            Enumeration enume=request.getParameterNames();
            con = DB.Connect.openConnection();
            
            while(enume.hasMoreElements()){
                String like=enume.nextElement().toString();
                System.out.println(like);
                try {
                    String query = "insert into  tbllikes (userid,likes,rdate)values(?,?,NOW()) ";
                    
                    
                    pst = con.prepareStatement(query);
                    
                    pst.setString(1, userid);
                    pst.setString(2, request.getParameter(like));
                    
                    i = pst.executeUpdate();
                    
                } catch (SQLException ex) {
                    Logger.getLogger(saveLikes.class.getName()).log(Level.SEVERE, null, ex);
                }
                
            }
            
            con.close();
            
            
            
            if (i > 0) {
                session.setAttribute("MSG", "Likes saved successfully");
                response.sendRedirect("likes.jsp");
            } else {
                session.setAttribute("MSG", "Failed to save like");
                response.sendRedirect("likes.jsp");
            }
        } catch (SQLException ex) {
            Logger.getLogger(saveLikes.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
}
