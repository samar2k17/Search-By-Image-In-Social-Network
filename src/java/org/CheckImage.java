/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package org;

import DB.ImageComarator;
import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import javax.json.JsonArray;
import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileItemFactory;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.apache.commons.fileupload.servlet.ServletRequestContext;

/**
 *
 * @author riddhi
 */
@WebServlet(name = "CheckImage", urlPatterns = {"/CheckImage"})
public class CheckImage extends HttpServlet {
    
    String filename, uploadfile;
    Connection con;
    File file3;
    boolean flag = false;

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
        HttpSession session = request.getSession(true);
        String uid = (String) session.getAttribute("ID");
        PrintWriter out = response.getWriter();
        response.setContentType("text/html");
        ServletConfig config = getServletConfig();
        String context = config.getServletContext().getRealPath("/");

        //connection from database
        try {
            con = DB.Connect.openConnection();
        } catch (Exception e) {
        }
        
        String filePath = context + "uploadfiles";
        
        boolean status = false;
        
        java.util.Date d = new java.util.Date();
        long timestamp = d.getTime();
        
        try {
            File projectDir = new File(filePath);
            if (!projectDir.exists()) {
                projectDir.mkdirs();
                
            }
        } catch (Exception e) {
            System.out.println("kslkf: " + e);
            e.printStackTrace();
        }
        
        boolean isMultipart = ServletFileUpload.isMultipartContent(new ServletRequestContext(request));
        if (isMultipart) {
            FileItemFactory factory = new DiskFileItemFactory();
            ServletFileUpload upload = new ServletFileUpload(factory);
            try {
                List/*FileItem*/ items = upload.parseRequest(request);
                Iterator iter = items.iterator();
                while (iter.hasNext()) {
                    FileItem item = (FileItem) iter.next();
                    if (item.isFormField()) {

                        //file name
                        if (item.getFieldName().equalsIgnoreCase("txtfname")) {
                            filename = item.getString();
                        }
                        
                    } else {
                        // upload first image
                        if (item.getFieldName().equalsIgnoreCase("txtfile")) {
                            String filename = item.getName();
                            if (!filename.equalsIgnoreCase("")) {
                                uploadfile = "F" + timestamp + filename.substring(filename.lastIndexOf("."), filename.length());//full image path

                                String enc_filpath = filePath + File.separator + uploadfile;
                                file3 = new File(enc_filpath);
                                // file_name = DB.Connect.getFileDateTime()+filename.substring(filename.lastIndexOf("."));//full image path

                                //upload file path
                                System.out.println("enc " + enc_filpath);
                                System.out.println("upload: " + uploadfile);
                                
                                try {
                                    
                                    item.write(file3);
                                    flag = true;
                                } catch (Exception e1) {
                                    status = false;
                                }
                            }
                        }
                        
                    }
                }
            } catch (Exception e) {
                e.printStackTrace();
                status = false;
            }
        }
        
        try {
            String sql = "select * from tbluser where userid !='" + session.getAttribute("ID").toString() + "';";
            System.out.println("sql" + sql);
            PreparedStatement stat = con.prepareStatement(sql);
            ResultSet rs = stat.executeQuery();
            ArrayList<String> lstUsers = new ArrayList<String>();
            ArrayList<String> lstUsersID = new ArrayList<String>();
            while (rs.next()) {
                DB.ImageComarator image = new ImageComarator();
                
                File f = new File(filePath + "/" + rs.getString("image"));
                System.out.println("" + f.getName());
                float per = image.compareImage(file3, f);
                System.out.println("per=" + per);
                if (per == 100) {
                    lstUsersID.add(rs.getString("userid"));
                     System.out.println("per added" );
                }
            }
            session.setAttribute("image", lstUsersID);
            response.sendRedirect("searchfriendsByImage.jsp");
        } catch (Exception e) {
            e.printStackTrace();
            
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
