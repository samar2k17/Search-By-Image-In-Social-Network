<%-- 
    Document   : downloadfile
    Created on : Jan 27, 2013, 1:43:52 AM
    Author     : KamalKant
--%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.lang.String"%>
<%@page import="java.util.ArrayList"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.ResultSet"%>
<!DOCTYPE html>
<%
    Connection conn = null;
    Statement st = null;
    Statement st1 = null;
    ResultSet result = null;
    response.setHeader("Cache-Control", "no-cache"); //HTTP 1.1
    response.setHeader("Pragma", "no-cache"); //HTTP 1.0
    response.setDateHeader("Expires", 0); //prevents caching at the proxy server
    response.setHeader("Cache-Control", "no-store"); //HTTP 1.1
    String id = null;
    id = (String) session.getAttribute("ID");
    if (id != null) {
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
    "http://www.w3.org/TR/html4/loose.dtd">

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" >        

        <link href="css/style.css" rel="stylesheet" type="text/css">  
      

      

    </head>
    <body>
        <table  cellspacing="0" cellpadding="0" align="center" border="0" class="body_content">          

            <%@include file="header.jsp" %>
            <tr>
                <td valign="top">
                    <%@include file="leftmenu.jsp" %> 
                </td>
                <td valign="top" style="border-left: dotted 1px darkgreen;height: 500px;width: 750px;">
                    <table style="padding-left: 10px;" cellpadding="5" cellspacing="0" width="100%">
                        <tr>
                            <td>
                                <h1>Search Friends</h1>
                            </td>
                        </tr>
                        <tr>
                            <td valign="top">
                                <div style="height: 500px; width: 100%;overflow: auto;">
                                    <form action="CheckImage" method="post" enctype="multipart/form-data">
                                        <table>
                                            <%                                            String msg = null;
                                                msg = (String) session.getAttribute("MSG");
                                                if (msg != null) {
                                            %>
                                            <tr>
                                                <td colspan="5" align="center">
                                                    <div style="width:100%;color: #3278A3; font-size: 12px;font-weight: bold;" align="center"><%=msg%></div>
                                                </td>
                                            </tr>
                                            <%
                                                    session.removeAttribute("MSG");
                                                } else {
                                                    session.setAttribute("MSG", "");

                                                }
                                            %>
                                            <tr>
                                                <td>
                                                    <input type="file" name="txtFile" accept="images/*">

                                                </td>
                                                <td>
                                                    <input type="submit" name="Search" class="button">

                                                </td>
                                            </tr>
                                        </table>
                                    </form>
                                    <table cellpadding="3" cellspacing="3" width="100%">


                                        <tr class="heading_lable">

                                            <td align="center">Name</td>
                                            <td align="center">Image</td>    
                                            <td align="center">Status</td>                                            
                                            <td align="center">Task</td>                                            

                                        </tr>
                                        <%
                                            int i = 0;
                                            try {
                                            
                                                conn = DB.Connect.openConnection();
                                              if(session.getAttribute("image")!=null){
                                              
                                                ArrayList<String>lstUsers=(ArrayList)session.getAttribute("image");
                                                int count=0;
                                               
                                                while (count<lstUsers.size()) {
                                                    String sql1="select * from tbluser where userid='"+lstUsers.get(count)+"'";
                                                    System.out.println("sql1"+sql1);
                                                    PreparedStatement stat=conn.prepareStatement(sql1);
                                                     result=stat.executeQuery();
                                                    if(result.next()){
                                                    
                                                    
                                                    
                                                    String name = result.getString("fname") + " " + result.getString("lname");
                                                    String image = result.getString("image");

                                                    String fuserid = result.getString("userid");
                                                    String sql = "select fid,status,userid from tblfriends where (userid='" + id + "' and fuserid='" + fuserid + "') or (fuserid='" + id + "' and userid='" + fuserid + "')";
                                                    st1 = conn.prepareStatement(sql);
                                                    ResultSet rs = st1.executeQuery(sql);
                                                    String status = "Not Friend";
                                                    String fid = "NA";
                                                    String senderid = "NA";
                                                    if (rs.next()) {
                                                        status = rs.getString("status");
                                                        senderid = rs.getString("userid");
                                                        fid = rs.getString("fid");
                                                    }

                                                    i++;
                                        %>
                                        <tr bgcolor="#f9f9f9">

                                            <td><%=name%></td> 

                                            <%
                                                if (!image.equalsIgnoreCase("NA")) {
                                            %>

                                            <td align="center"><img src="uploadfiles/<%=image%>" height="100px" width="100px"></td>
                                                <%
                                                    } else {
                                                        out.print("<td>No Image Found</td>");
                                                    }
                                                %>

                                            <td align="center"><%=status%>.</td>    
                                            <td align="center">
                                                <%
                                                    if (status.equals("Not Friend")) {
                                                %>
                                                <a href="friendRequest?id=<%=fuserid%>&status=new" class="cursor">Send Friend Request</a>
                                                <%
                                                } else if (status.equals("Pending") && senderid.equals(id)) {
                                                %>
                                                <a href="friendRequest?id=<%=fid%>&status=cancel" class="cursor">Cancel Pending Request</a>
                                                <%
                                                } else if (status.equals("Accepted")) {
                                                %>
                                                <a href="friendRequest?id=<%=fid%>&status=remove" class="cursor">Remove From Friend List</a>
                                                <%
                                                } else if (status.equals("Pending") && senderid.equals(fuserid)) {
                                                %>
                                                <a href="friendRequest?id=<%=fid%>&status=accept" class="cursor">Accept Request</a>
                                                <%
                                                    }
                                                %>


                                            </td>

                                        </tr>
                                        <% }
count++;  }
}
                                            } catch (Exception e) {
                                                e.printStackTrace();
                                            } finally {
                                                conn.close();
                                            }

                                        %>
                                    </table>
                                </div>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr> 
            <tr>
                <td colspan="3" width="100%" class="footer">
                    <%@include file="footer.html" %>
                </td>
            </tr>
        </table>

    </body>
</html>
<%    } else {
        session.setAttribute("MSG", "You must be login.");
        response.sendRedirect("login.jsp");
    }
%>
