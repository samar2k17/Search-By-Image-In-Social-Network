<%-- 
    Document   : downloadfile
    Created on : Jan 27, 2013, 1:43:52 AM
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
        <script type="text/javascript">

            function Downloadfile(fileid) {

                var xmlHttpRequest = init();

                function init()
                {
                    if (window.XMLHttpRequest) {
                        return new XMLHttpRequest();
                    } else if (window.ActiveXObject) {
                        return new ActiveXObject("Microsoft.XMLHTTP");
                    }
                }

                var pwd = prompt("Enter your password here : ", "");
                if (pwd == "") {
                    return false;
                }

                xmlHttpRequest.open("POST", "decryption?fileid=" + escape(fileid) + "&pwd=" + escape(pwd), true);
                xmlHttpRequest.onreadystatechange = processRequest;
                xmlHttpRequest.send(null);

                function processRequest()
                {
                    if (xmlHttpRequest.readyState == 4)
                    {
                        if (xmlHttpRequest.status == 200)
                        {
                            processResponse();
                        }
                    }
                }

                function processResponse()
                {
                    var xmlMessage = xmlHttpRequest.responseXML;
                    var res = xmlMessage.getElementsByTagName("sname")[0].firstChild.nodeValue;
                    // alert(res);
                    if (res != "res") {
                        var value = "uploadfiles/" + res;
                        window.open(value, "_blank");
                    }

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
                    <table style="padding-left: 10px;" cellpadding="5" cellspacing="0" width="100%">
                        <tr>
                            <td>
                                <h1>Friend Lists</h1>
                            </td>
                        </tr>
                        <tr>
                            <td valign="top">
                                <div style="height: 500px; width: 100%;overflow: auto;">
                                    <form action="friendLists.jsp" method="post">
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
                                                    <input type="text" name="txtName" placeholder="Name/Email ID/Mobile No.">

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
                                                String query = "SELECT * from tbluser where  userid!='" + id + "' and usertype='user' and status='True'";
                                                String search = request.getParameter("txtName");
                                                if (search != null) {
                                                    query = "SELECT * from tbluser where  userid!='" + id + "' and usertype='user' and status='True' and ((fname like '%" + search + "%') or (emailid like '%" + search + "%') or (mobile_no like '%" + search + "%'))";

                                                }

                                                st = conn.prepareStatement(query);
                                                result = st.executeQuery(query);
                                                while (result.next()) {
                                                    String name = result.getString("fname") + " " + result.getString("lname");
                                                    String image = result.getString("image");

                                                    String fuserid = result.getString("userid");
                                                    String sql = "select fid,status,userid from tblfriends where status='Accepted' and ( (userid='" + id + "' and fuserid='" + fuserid + "') or (fuserid='" + id + "' and userid='" + fuserid + "'))";
                                                    st1 = conn.prepareStatement(sql);
                                                    ResultSet rs = st1.executeQuery(sql);
                                                    String status = "Not Friend";
                                                    String fid = "NA";
                                                    String senderid = "NA";
                                                    if (rs.next()) {
                                                        status = rs.getString("status");
                                                        senderid = rs.getString("userid");
                                                        fid = rs.getString("fid");

                                                        i++;
                                        %>
                                        <tr bgcolor="#f9f9f9">

                                            <td><%   out.print("<form action='useraccount.jsp' method=post> <input type=hidden name=fuserid value=" + fuserid + "><input type=submit  value='" + name + "'></form> ");
                                                %></td> 

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
                                        <%    }
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
