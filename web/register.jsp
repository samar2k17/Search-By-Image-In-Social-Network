

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
    "http://www.w3.org/TR/html4/loose.dtd">

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" >        
        <title>Register - Secure Data Storage in Cloud</title>
        <link href="css/style.css" rel="stylesheet" type="text/css">
        <script type="text/javascript" src="js/scw.js"></script>
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
                if(email.value.trim() == "" ){
                    alert('Please enter your email id.');
                    email.focus();
                    return false;                    
                }
                
                var filter = /^([a-zA-Z0-9_\.\-])+\@(([a-zA-Z0-9\-])+\.)+([a-zA-Z0-9]{2,4})+$/;
                if (!filter.test(email.value)) {
                    alert('Please provide a valid email address');
                    email.focus;
                    return false;
                }
                
                var contno = document.getElementById('txtcontno');
                if(contno.value.trim() == ""){
                    alert('Please select your contact no.');
                    contno.focus();
                    return false;                    
                }
                
                // password validation
                var pwd = document.getElementById('txtpwd');
                if(pwd.value.trim() == ""){
                    alert('Please enter your password');
                    pwd.focus();
                    return false;                    
                }
                var cpwd = document.getElementById('txtcpwd');
                if(cpwd.value.trim() == ""){
                    alert('Please enter your retype password');
                    cpwd.focus();
                    return false;                    
                }
                if(pwd.value.trim() != cpwd.value.trim()){
                    alert('Your retype password does not matched with password.');
                    cpwd.focus();
                    return false;                     
                }
            }
            //check for integer
            function CheckInteger(i)
            {
                if(i.value.length>0)
                {
                    i.value = i.value.replace(/[^\d]+/g, '');

                }
            }
            
            
        </script>
    </head>
    <body>
        <table  cellspacing="0" cellpadding="0" align="center" border="0" class="body_content">          

            <%@include file="header.html" %>
            <tr>
                <td width="950"  height="500" valign="top" style="padding-left: 10px;padding-right: 10px;">
                    <table style="padding-left: 10px;" cellpadding="5" cellspacing="0" width="100%">
                        <tr>
                            <td>
                                <h1>Register</h1>
                            </td>
                        </tr>
                        <tr>
                            <td valign="top">
                                <form action="register" method="post">
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
                                        <tr>                                            
                                            <td width="20%">
                                                <b>First Name:</b>
                                            </td>
                                            <td>
                                                <input type="text" name="txtfname" id="txtfname" class="inputbox"/>
                                            </td>  
                                            <td width="20%">
                                                <b>Last Name:</b>
                                            </td>
                                            <td>
                                                <input type="text" name="txtlname" id="txtlname" class="inputbox"/>
                                            </td>
                                        </tr>
                                        <tr>
                                           
                                            <td width="20%">
                                                <b>Username <span class="mandetory"> *</span>:</b>
                                            </td>
                                            <td>
                                                 <input type="text" name="txtusername"  class="inputbox"/>
                                            </td>                                            
                                        </tr>
                                        <tr>
                                            <td width="20%">
                                                <b>Email&nbsp;ID:</b>
                                            </td>
                                            <td>
                                                <input type="text" name="txtemail" id="txtemail" class="inputbox"/>
                                            </td>
                                            <td width="20%">
                                                <b>Contact No.:</b>
                                            </td>
                                            <td>
                                                <input type="text" name="txtcontno" id="txtcontno" class="inputbox"onkeyup="CheckInteger(this)"/>
                                            </td>                                            
                                        </tr>

                                        <tr>
                                            <td width="20%" valign="top">
                                                <b>Location:</b>
                                            </td>
                                            <td>
                                                <input type="text" class="inputbox" name="txtlocation" id="txtlocation"/>
                                            </td> 
                                            
                                        </tr>                                        
                                        
                                        <tr>
                                            <td colspan="4">
                                                All fields are mandatory.
                                            </td>
                                        </tr>
                                        <tr>

                                            <td colspan="4" align="center">
                                                <input type="submit" name="btnsubmit" id="btnsubmit" value="Submit" onclick="return checkform();" class="button"/>
                                                <input type="reset" name="btnreset" id="btnreset" value="Reset" class="button"/>
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
