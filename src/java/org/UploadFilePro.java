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
import static org.Register.con;
import org.apache.commons.fileupload.*;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.*;

/**
 *
 *
 */
@WebServlet(name = "UploadFilePro", urlPatterns = {"/UploadFilePro"})
public class UploadFilePro extends HttpServlet {

    static Connection con = null;
    PreparedStatement pst = null;
    ResultSet rst = null;
    String filename = null;

    String file_name = null;

    String fullImagepath = null;
    String count = null;
    String upload_filepath = null;
    String uploadfile = "NA";
    boolean flag;
    int i = 0;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String id = request.getParameter("id");
        String filename = request.getParameter("filename");
        HttpSession session = request.getSession(true);

        try {
            con = DB.Connect.openConnection();
            String queryname = "DELETE FROM `tblbanned` WHERE filename =?";
            PreparedStatement st = con.prepareStatement(queryname);
            st.setString(1, filename);
         i=st.executeUpdate();
          ServletConfig config = getServletConfig();
        String context = config.getServletContext().getRealPath("/");
          String filePath = context + "uploadfilespro" + File.separator + filename;

                File f = new File(filePath);
                f.delete();
                System.out.println("file deleted");
         
        } catch (Exception e) {
        }

        if (i > 0) {
            session.setAttribute("MSG", "File Deleted !!");
            response.sendRedirect("adfilelists.jsp");
        } else {
            session.setAttribute("MSG", "File has not been deleted !!");
            response.sendRedirect("adfilelists.jsp");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
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

        String filePath = context + "uploadfilespro";

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
                      

                    } else {
                        // upload first image
                        if (item.getFieldName().equalsIgnoreCase("txtfile")) {
                            String filename = item.getName();
                            if (!filename.equalsIgnoreCase("")) {
                                uploadfile = "F" + timestamp + filename.substring(filename.lastIndexOf("."), filename.length());//full image path

                                String enc_filpath = filePath + File.separator + uploadfile;
                                File file3 = new File(enc_filpath);
                                // file_name = DB.Connect.getFileDateTime()+filename.substring(filename.lastIndexOf("."));//full image path

                                //upload file path
                                System.out.println("enc " + enc_filpath);
                                System.out.println("upload: " + uploadfile);
                                System.out.println("upload file path: " + upload_filepath);

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
                String sqlquery = "INSERT INTO tblbanned(filename) VALUES(?)";
                pst = con.prepareStatement(sqlquery);
              
                pst.setString(1, uploadfile);
           
              

                i = pst.executeUpdate();

            } catch (Exception e) {
                e.printStackTrace();
                ;
            }

            //success or failure message
            if (i > 0) {

                session.setAttribute("MSG", "File Uploaded.");
                response.sendRedirect("uploadfile_pro.jsp");
            } else {
                session.setAttribute("MSG", "Failed to upload file");
                response.sendRedirect("uploadfile_pro.jsp");
            }
        

    }
}
