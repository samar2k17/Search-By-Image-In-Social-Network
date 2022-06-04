

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
        <title>My Account </title>
        <link href="css/style.css" rel="stylesheet" type="text/css">
        <script type="text/javascript">
            function checkform(){
                var enrno = document.getElementById('txtfname');
                if(enrno.value.trim() == ""){
                    alert('Please enter your first name.');
                    enrno.focus();
                    return false;                    
                }
                var name = document.getElementById('txtlname');
                if(name.value.trim() == ""){
                    alert('Please enter your last name.');
                    name.focus();
                    return false;                    
                }
                
                var dob = document.getElementById('txtdob');
                if(dob.value.trim() == ""){
                    alert('Please enter your date of birth.');
                    dob.focus();
                    return false;                    
                }
                var gender = document.getElementById('cmbgender');
                if(gender.value.trim() == "na"){
                    alert('Please select your gender.');
                    gender.focus();
                    return false;                    
                }
                var email = document.getElementById('txtemail');
                if(email.value.trim() == ""){
                    alert('Please enter your email id.');
                    email.focus();
                    return false;                    
                }
                var contno = document.getElementById('txtcontno');
                if(contno.value.trim() == ""){
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
                                <h1>Feedback</h1>
                            </td>
                        </tr>
                        <tr>
                            <td valign="top">
                                <form action="feedback" method="post">
                                    <table cellpadding="5" cellspacing="5" width="50%">
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
                                        <%

                                            int i = 0;
                                           
                                                String userid=request.getParameter("fuserid");
                                               
                                        %>
                                        <input type="hidden" name="fuserid" value="<%=userid%>">
                                          
                                            <td width="20%">
                                                <b>Feedback</b>
                                            </td>
                                            <td width="20%">
                                                
                                                <textarea rows="5" cols="10" name="feedback" >
                                                    
                                                </textarea>
                                             
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                
                                            </td>
                                            <td>
                                                <input type="submit" value="Submit">
                                            </td>
                                        </tr>

                                       
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
<%    } else {
        session.setAttribute("MSG", "You must be login.");
        response.sendRedirect("login.jsp");
    }
%>

    