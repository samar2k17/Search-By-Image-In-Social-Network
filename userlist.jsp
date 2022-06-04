

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.ResultSet"%>
<!DOCTYPE html>
<%
    Connection conn = null;
    Statement st = null;
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
        <title>User List - </title>
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
                                <h1>User List</h1>
                            </td>
                        </tr>
                        <tr>
                            <td valign="top">
                                <div style="height: 500px; width: 100%;overflow: auto;">
                                    <table cellpadding="3" cellspacing="3" width="100%">
                                        <%
                                            String msg = null;
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
                                        <tr class="heading_lable">
                                            <td align="center">S.No</td>                                            
                                            <td align="center">Name</td>
                                           
                                            <td align="center">Contact&nbsp;No.</td>
                                            <td align="center">Email&nbsp;ID</td>
                                            <td align="center">User type</td>
                                            <td align="center">Status</td>
                                            <td align="center">Delete</td>                                            
                                            <td align="center">Activate</td>                                            
                                        </tr>
                                        <%

                                            int i = 0;
                                            try {
                                                conn = DB.Connect.openConnection();
                                                String query = "SELECT userid,fname,lname,mobile_no,emailid,usertype,status FROM tbluser WHERE  usertype NOT IN ('admin')";
                                                st = conn.prepareStatement(query);
                                                result = st.executeQuery(query);
                                                while (result.next()) {
                                                    String sid = result.getString(1);
                                                    String fname = result.getString(2);
                                                    String lname = result.getString(3);
                                                  
                                                    String contno = result.getString(4);
                                                    String email = result.getString(5);
                                                    String usertype = result.getString("usertype");
                                                    String status = result.getString("status");
                                                    i++;
                                        %>
                                        <tr bgcolor="#f9f9f9">
                                            <td align="center"><%=i%>.</td>
                                            
                                            <td>
                                                <%
                                                if(usertype.equalsIgnoreCase("ca")){
                                                out.print("<a href='ca_feedback.jsp?fuserid="+sid+"' title='View Feedback'>"+fname + " " + lname+"</a>");                                    
                                         
                                                }else{
                                                      out.print(fname + " " + lname);                              
                                         
                                                }
                                                %>
                                              </td>           
                                            <td align="center"><%=contno%></td>
                                            <td align="center"><%=email%></td>
                                            <td align="center"><%=usertype.toUpperCase()%></td>
                                            <td align="center"><%=status.toUpperCase()%></td>
                                            <td align="center">
                                                <a href="register_ca?id=<%=sid%>&status=False" class="cursor">Delete</a>
                                            </td>
                                            <td align="center">
                                                <a href="register_ca?id=<%=sid%>&status=True" class="cursor">Activate</a>
                                            </td>
                                        </tr>
                                        <%    }

                                            } catch (Exception e) {
                                                e.printStackTrace();
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