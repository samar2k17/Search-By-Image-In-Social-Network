<%-- 
    Document   : download
    Created on : Feb 3, 2013, 1:14:40 PM
    Author     : KamalKant
--%>

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
        <title>Download Files - Secure Data Storage in Cloud</title>
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
                                <h1>Download Files</h1>
                            </td>
                        </tr>
                        <tr>
                            <td valign="top">
                                <div style="height: 500px; width: 100%;overflow: auto;">
                                    <table cellpadding="3" cellspacing="3" width="100%">
                                        <%
                                            String download = request.getParameter("download");
                                            if (download.equals("true")) {
                                        %>

                                        <tr bgcolor="#f9f9f9">                                           
                                            <td align="center">
                                                <a href="uploadfiles/download.doc" class="cursor">Download</a>
                                            </td>
                                        </tr>
                                        <%}%>
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
