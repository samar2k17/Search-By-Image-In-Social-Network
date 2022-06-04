<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="java.sql.ResultSet"%>
<!DOCTYPE html>
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


                        <table>
                            <tr>
                            <form action="single_message.jsp" method="get">
                                <%
                                %>
                                <tr>
                                    <td>
                                        Select User
                                    </td>
                                    <td>
                                        <select name="fuserid">
                                            

                                            <%                                                    conn = DB.Connect.openConnection();
                                                String query = "select fuserid,userid from tblfriends where status='Accepted' and  (userid='" + id + "' or fuserid='" + id + "')";
                                                System.out.println("query=" + query);
                                                PreparedStatement st = conn.prepareStatement(query);
                                                ResultSet result = st.executeQuery(query);
                                                while (result.next()) {
                                                    String search_userid = result.getString("fuserid");
                                                    if (search_userid.equals(id)) {
                                                        search_userid = result.getString("userid");
                                                    }

                                                    String sql = "select * from tbluser where userid=" + search_userid;
                                                    PreparedStatement stat = conn.prepareStatement(sql);
                                                    ResultSet rs = stat.executeQuery();
                                                    if (rs.next()) {
                                                        out.println("<option value='" + rs.getString("userid") + "'>" + rs.getString("fname") + " " + rs.getString("lname") + "</option>");

                                                    }
                                                }
                                                conn.close();

                                            %>
                                        </select>
                                    </td>
                                    <td>
                                        <input type="submit" value="Create New Messages">
                                    </td>
                                </tr>

                            </form>
                            </tr>
                            <%    }
                            %>
                            <tr>
                                <td bgcolor="#356066">User</td>
                                <td  bgcolor="#356066">Name</td>
                            </tr>
                            <%
                                List lstDisplayIds = new ArrayList();
                                String query1 = "select * from tblmessages where tblmessages.userid='" + id + "' or tblmessages.fuserid='" + id + "' order by rdate desc";
                                conn = DB.Connect.openConnection();
                                PreparedStatement stat = conn.prepareStatement(query1);
                                ResultSet rs1 = stat.executeQuery(query1);

                                while (rs1.next()) {
                                    String display_id, name = "", text;

                                    if (rs1.getString("userid").equals(id)) {
                                        display_id = rs1.getString("fuserid");
                                    } else {
                                        display_id = rs1.getString("userid");
                                    }
                                    System.out.println("displayid" + display_id);
                                    String query2 = "select fname,lname from tbluser where userid='" + display_id + "'";
                                    PreparedStatement stat1 = conn.prepareStatement(query2);
                                    ResultSet rs2 = stat1.executeQuery(query2);
                                    if (rs2.next()) {
                                        name = rs2.getString("fname") + " " + rs2.getString("lname");

                                    }

                                    if (!lstDisplayIds.contains(display_id)) {
                                        text = rs1.getString("text");
                                        System.out.println(text + " name=" + name);
                                        out.println("<tr>");
                                        out.print("<td>");
                                        out.print("<form action='useraccount.jsp' method=post> <input type=hidden name=fuserid value="+display_id+"><input type=submit  value="+name+"></form> ");
                                        out.print("</td>");
                                        out.print("<td>");
                                            out.print("<form action='single_message.jsp' method=post> <input type=hidden name=fuserid value="+display_id+"><input type=submit class='arrowgreen' value="+text+"></form> ");
                                    
                                       // out.print("<a href='single_message.jsp?fuserid=" + display_id + "' title='Click to view details'>");
                                       // out.println(text);
                                       // out.print("</a>");
                                        out.print("</td>");
                                        out.println("</tr>");
                                        lstDisplayIds.add(display_id);
                                    }

                                }
                                rs1.close();
                                conn.close();

                            %>

                        </table>

                        </form>
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
<%
%>

