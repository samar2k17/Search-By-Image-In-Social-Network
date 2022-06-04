<%@page import="java.sql.Connection"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="java.sql.ResultSet"%>
<%    Connection conn = null;

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
        <title>My Account </title>
        <link href="css/style.css" rel="stylesheet" type="text/css">
        <script type="text/javascript">
            function checkform() {
                var enrno = document.getElementById('txtfname');
                if (enrno.value.trim() == "") {
                    alert('Please enter your first name.');
                    enrno.focus();
                    return false;
                }
                var name = document.getElementById('txtlname');
                if (name.value.trim() == "") {
                    alert('Please enter your last name.');
                    name.focus();
                    return false;
                }

                var dob = document.getElementById('txtdob');
                if (dob.value.trim() == "") {
                    alert('Please enter your date of birth.');
                    dob.focus();
                    return false;
                }
                var gender = document.getElementById('cmbgender');
                if (gender.value.trim() == "na") {
                    alert('Please select your gender.');
                    gender.focus();
                    return false;
                }
                var email = document.getElementById('txtemail');
                if (email.value.trim() == "") {
                    alert('Please enter your email id.');
                    email.focus();
                    return false;
                }
                var contno = document.getElementById('txtcontno');
                if (contno.value.trim() == "") {
                    alert('Please select your contact no.');
                    contno.focus();
                    return false;
                }

            }
        </script>
        <script type="text/javascript" src="js/scw.js"></script>
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
                                <h1>Messages</h1>
                            </td>
                        </tr>

                        <table cellpadding="5" cellspacing="5" width="100%">
                            <%
                                String msg = null;
                                msg = (String) session.getAttribute("MSG");
                                if (msg != null) {
                            %>
                            <tr>
                                <td colspan="4" align="center">
                                    <div style="width:100%;color: #3278A3; font-size: 12px;font-weight: bold;" align="center"><%=msg%></div>
                                </td>
                            </tr>
                            <%
                                    session.removeAttribute("MSG");
                                } else {
                                    session.setAttribute("MSG", "");

                                }
                            %>
                        </table>
                        <div >
                            <form action="sendMesage" method="post" enctype="multipart/form-data">                           


                                <table>
                                    <%
                                        String fuserid = request.getParameter("fuserid");
                                       

                                        String query1 = "select * from tblmessages where (tblmessages.userid='" + id + "' and tblmessages.fuserid='" + fuserid + "') or (tblmessages.fuserid='" + id + "' and tblmessages.userid='" + fuserid + "') order by rdate";
                                        conn = DB.Connect.openConnection();
                                        PreparedStatement stat1 = conn.prepareStatement(query1);
                                        ResultSet rs1 = stat1.executeQuery(query1);

                                        while (rs1.next()) {
                                            String display_id, name = "", text;

                                            display_id = rs1.getString("fuserid");
                                            System.out.println(display_id);
                                            String query2 = "select fname,lname from tbluser where userid='" + display_id + "'";
                                            PreparedStatement stat2 = conn.prepareStatement(query2);
                                            ResultSet rs2 = stat2.executeQuery(query2);
                                            if (rs2.next()) {
                                                name = rs2.getString("fname") + " " + rs2.getString("lname");

                                            }

                                            text = rs1.getString("text");

                                            out.println("<tr>");
                                            out.print("<td>");
                                            out.print(name);
                                            out.print("</td>");
                                            out.print("<td>");
                                            // out.print("<a href='single_message.jsp?userid=" + display_id + "' title='Click to view details'>");
                                            if (rs1.getString("data_type").equals("text")) {
                                                out.println(text);
                                            } else if (rs1.getString("data_type").equals("document")) {
                                                out.println("<a target='new' href=uploadfiles/" + text + " title='Click here to download'>" + text + "</a>");
                                            }

                                            // out.print("</a>");
                                            out.print("</td>");
                                            out.println("</tr>");

                                        }
                                        rs1.close();

                                    %>



                                    <tr>
                                        <td>
                                            <input type="hidden" name="fuserid" value="<%=fuserid%>">
                                            Send Reply
                                        </td>
                                        <td>
                                            <textarea rows="3" cols="15" name="txtmessage"></textarea>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>Attach File</td>
                                        <td>
                                            <input type="file" name="txtfile">
                                        </td>
   <td>
                                            <input type="submit" value="Send">
                                        </td>
                                    </tr>
                                  
                                </table>

                            </form>
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

