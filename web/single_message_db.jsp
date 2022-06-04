<%@page import="java.io.FileOutputStream"%>
<%@page import="java.io.FileInputStream"%>
<%@page import="java.io.InputStream"%>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Iterator" %>
<%@ page import="java.io.File" %>
<%@ page import="org.apache.commons.fileupload.servlet.ServletFileUpload"%>
<%@ page import="org.apache.commons.fileupload.disk.DiskFileItemFactory"%>
<%@ page import="org.apache.commons.fileupload.*"%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
 

        <%
            System.out.println("here");
            boolean isMultipart = ServletFileUpload.isMultipartContent(request);
            String txtmessage = "", fileType = "", txtsenderid = "", txtuserid = "";
            System.out.println("here");
            String fileName = "";
            String context = config.getServletContext().getRealPath("/");
            String filePath = context + "uploadfiles";
            txtsenderid = session.getAttribute("id").toString();
           System.out.println("txtsenderid");
            int i = 0;
            File f = null;
            if (!isMultipart) {
            } else {
                FileItemFactory factory = new DiskFileItemFactory();
                ServletFileUpload upload = new ServletFileUpload(factory);
                List items = null;
                try {
                    items = upload.parseRequest(request);
                } catch (FileUploadException e) {
                    e.printStackTrace();
                }
                Iterator itr = items.iterator();
                while (itr.hasNext()) {
                    FileItem item = (FileItem) itr.next();
                    if (item.isFormField()) {
                        String name = item.getFieldName();
                        String value = item.getString();
                        if (name.equalsIgnoreCase("txtmessage")) {
                            txtmessage = value;
                        }

                        if (name.equalsIgnoreCase("fileType")) {
                            fileType = value;
                        }
                       
                        if (name.equalsIgnoreCase("userid")) {
                            txtuserid = value;
                        }

                        System.out.println("Parameters " + name + " value " + value);
                        if(!txtmessage.isEmpty()){
                                  i = DB.Connect.saveMessage(txtmessage, txtsenderid, txtuserid, "text");
                        }

                    } else {
                        try {
                            String itemName = item.getName();
                            // File root = File.listRoots()[0];
                            //  System.out.println("fILE pATH=" + root.getAbsolutePath());
                            System.out.println("fILE pATH=" + filePath + itemName);
                            f = new File(filePath + "\\" + itemName);
                            fileName = itemName;
                            f.setWritable(true);
                            f.setReadable(true);
                            item.write(f);
                            if(!itemName.isEmpty()){
                              i = DB.Connect.saveMessage(itemName, txtsenderid, txtuserid, "document");
                            }

                        } catch (Exception e) {
                            e.printStackTrace();
                        }
                    }


                }

            }

            // i = DB.Connect.Upload(username, fileName, fileType, branch, sem, shift, batch, is);

            if (i > 0) {
                response.sendRedirect("single_message.jsp?userid=" + txtuserid + "");
            } else {
                response.getWriter().print("Failed to upload");
            }

           
%>
  


