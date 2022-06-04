
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
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
        <title>Calculator - Secure Data Storage in Cloud</title>
        <link href="css/style.css" rel="stylesheet" type="text/css">       
        <script type="text/javascript">
            function Calculator(val)
            {
                //alert('called');
                var xmlHttpRequest=init();

                function init()
                {
                    if (window.XMLHttpRequest){
                        return new XMLHttpRequest();
                    }
                    else if (window.ActiveXObject){
                        return new ActiveXObject("Microsoft.XMLHTTP");
                    }
                }

                var fno = document.getElementById('txtfno');
                if(fno.value.trim() == ""){
                    alert('Please enter your first number.');
                    fno.focus();
                    return false;                    
                }
                var sno = document.getElementById('txtsno');
                if(sno.value.trim() == ""){
                    alert('Please enter your second number');
                    sno.focus();
                    return false;                    
                }
                if(val == 1){
                    document.getElementById('txtresult').value = parseFloat(fno.value.trim()) + parseFloat(sno.value.trim());
                }else if(val == 2){
                    document.getElementById('txtresult').value = parseFloat(fno.value.trim()) - parseFloat(sno.value.trim());
                }else if(val == 3){
                    document.getElementById('txtresult').value = parseFloat(fno.value.trim()) * parseFloat(sno.value.trim());
                }else if(val == 4){
                    document.getElementById('txtresult').value = parseFloat(fno.value.trim()) % parseFloat(sno.value.trim());
                }

                xmlHttpRequest.open("POST", "calculator?fno="+escape(fno.value.trim())+"&sno="+escape(sno.value.trim())+"&val="+escape(val),true);
                xmlHttpRequest.onreadystatechange=processRequest;
                xmlHttpRequest.send(null);

                function processRequest()
                {
                    if(xmlHttpRequest.readyState==4)
                    {
                        if(xmlHttpRequest.status==200)
                        {
                            processResponse();
                        }
                    }
                }

                function processResponse()
                {
                    var xmlMessage=xmlHttpRequest.responseXML;
                    var pwd=xmlMessage.getElementsByTagName("sname")[0].firstChild.nodeValue;
                    //alert(pwd);                  

                }
            }

            function CheckForFloat(i)
            {
                if(i.value.length>0)
                {
                    i.value = i.value.replace(/[^\d\.]+/g, '');
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
                                <h1>Calculator</h1>
                            </td>
                        </tr>
                        <tr>
                            <td valign="top">
                                <form action="changePwd" method="post" name="change password">
                                    <table cellpadding="5" cellspacing="5" width="100%">

                                        <tr>
                                            <td>
                                                <b>First Number:</b>
                                            </td>
                                            <td>
                                                <input type="text" name="txtfno" id="txtfno"  class="inputbox" onkeyup="CheckForFloat(this)"/>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <b>Second Number:</b>
                                            </td>
                                            <td>
                                                <input type="text" name="txtsno" id="txtsno"  class="inputbox" onkeyup="CheckForFloat(this)"/>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <b>Result:</b>
                                            </td>
                                            <td>
                                                <input type="text" name="txtresult" id="txtresult"  class="inputbox" readonly=""/>
                                            </td> 
                                        </tr>
                                        <tr>                                            
                                            <td colspan="2" align="right">
                                                <input type="button" name="addition" id="addition" value="+" style="font-size: 32px;width: 50px;height: 50px;" onclick="return Calculator('1');" class="button"/>
                                                <input type="button" name="substraction" id="substraction" value="-" style="font-size: 32px;width: 50px;height: 50px;" onclick="return Calculator('2');" class="button"/>
                                                <input type="button" name="multiplication" id="multiplication" value="x" style="font-size: 32px;width: 50px;height: 50px;" onclick="return Calculator('3');" class="button"/>
                                                <input type="button" name="division" id="division" value="%" style="font-size: 32px;width: 50px;height: 50px;" onclick="return Calculator('4');" class="button"/>
                                            </td>
                                            <td width="50%">&nbsp;</td>
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