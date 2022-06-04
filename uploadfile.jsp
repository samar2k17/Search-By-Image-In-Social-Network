

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

        <link href="css/style.css" rel="stylesheet" type="text/css">
        <script type="text/javascript">
            function checkform() {

                var password = document.getElementById('txtpassword');
                if (password.value.trim() == "") {
                    alert('Please enter your file password.');
                    password.focus();
                    return false;
                }

                var filename = document.getElementById('txtfname');
                if (filename.value.trim() == "") {
                    alert('Please enter your file name.');
                    filename.focus();
                    return false;
                }
                var path = document.getElementById('txtfile');
                if (path.value.trim() == "") {
                    alert('Please select your file.');
                    path.focus();
                    return false;
                }

            }
        </script>

    </head>
    <body>
        <table  cellspacing="0" cellpadding="0" align="center" border="0" class="body_content">          

            <%@include file="header.jsp" %>
            <tr>
                <td valign="top">
                    <%@include file="leftmenu.jsp" %> 
                </td>


                <td valign="top" style="border-left: dotted 1px darkgreen;height: 500px;width: 750px;">
                    <form action="uploadFile" method="post" enctype="multipart/form-data">
                        <table style="padding-left: 10px;" cellpadding="5" cellspacing="0" width="100%">
                            <tr>
                                <td>
                                    <h1>Update Status</h1>
                                </td>
                            </tr>
                            <%                                            String msg = null;
                                msg = (String) session.getAttribute("MSG");
                                if (msg != null) {
                            %>
                            <tr>
                                <td>
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
                                    <textarea rows="5" cols="50" name="txtfname" id="txtfname"  placeholder="Status" style="width: 95%" required=""></textarea>

                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <b>Select Image:</b>
                                    <input type="file" name="txtfile" id="txtfile" accept="image/*" />

                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <input type="submit" name="btnsubmit" id="btnsubmit" value="Update Status" onclick="return checkform();" class="button"/>
                                    <input type="reset" name="btnreset" id="btnreset" value="Reset" class="button"/>

                                </td>
                            </tr>


                            </td>
                            </tr>

                        </table>
                    </form>
                    <div style="height: 500px; width: 100%;overflow: auto;">
                        <table cellpadding="3" cellspacing="3" width="100%">
                            <%
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

                                <td align="center">Status</td>

                                <td align="center">Image</td>

                                <td align="center">Delete</td>                                            

                            </tr>
                            <%
                                int i = 0;
                                try {
                                    conn = DB.Connect.openConnection();
                                    String query = "SELECT * FROM tblstatus WHERE  userid=" + id + "";
                                    st = conn.prepareStatement(query);
                                    result = st.executeQuery(query);
                                    while (result.next()) {
                                        String sid = result.getString(1);
                                        String status = result.getString(2);
                                        String image = result.getString(3);
System.out.println("image="+image);
                                        i++;
                            %>
                            <tr bgcolor="#f9f9f9">

                                <td align="center"><%=status%></td>

                                <%
                                    if (!image.equalsIgnoreCase("NA")) {
                                %>

                                <td align="center"><img src="uploadfiles/<%=image%>" height="100px" width="100px"></td>
                                    <%
                                        } else {
                                            out.print("<td></td>");
                                        }
                                    %>

                                <td align="center">
                                    <a href="uploadFile?id=<%=sid%>&filename=<%=image%>" class="cursor">Delete</a>
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