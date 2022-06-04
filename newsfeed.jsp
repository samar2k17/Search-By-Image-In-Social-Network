

<%@page import="java.sql.PreparedStatement"%>
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
        <!-- Lets load up prefixfree to handle CSS3 vendor prefixes -->
        <script src="http://thecodeplayer.com/uploads/js/prefixfree.js" type="text/javascript"></script>
        <!-- You can download it from http://leaverou.github.com/prefixfree/ -->
        <!-- Time for jquery action -->
        <script src="http://thecodeplayer.com/uploads/js/jquery-1.7.1.min.js" type="text/javascript"></script>
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

                    <div style="height: 500px; width: 100%;overflow: auto;">


                        <%                                int i = 0;
                            try {
                                conn = DB.Connect.openConnection();
                                String query = "select fuserid,userid from tblfriends where status='Accepted' and  (userid='" + id + "' or fuserid='" + id + "')";
                                System.out.println("query=" + query);
                                PreparedStatement st1 = conn.prepareStatement(query);
                                result = st1.executeQuery(query);
                                String temp_search = "";
                                int count = 0;
                                while (result.next()) {
                                    String search_userid = result.getString("fuserid");
                                    if (search_userid.equals(id)) {
                                        search_userid = result.getString("userid");
                                    }
                                    if (count == 0) {
                                        temp_search = search_userid + " or " + id;
                                    } else {
                                        temp_search = temp_search + " or " + temp_search;
                                    }
                                    count++;

                                }

                                String query1 = "SELECT * FROM tblstatus WHERE  userid=" + temp_search + " order by rdate desc";
                                System.out.println("" + query1);
                                st = conn.prepareStatement(query1);
                                result = st.executeQuery(query1);
                                while (result.next()) {
                                    String sid = result.getString(1);
                                    String status = result.getString(2);
                                    String image = result.getString(3);
                                    String rdate = result.getString("rdate");
                                    String fuserid = result.getString("userid");
                                    System.out.println("image=" + image);
                                    i++;
                        %>


                        <script type="text/javascript">
                            $(document).ready(function () {

                                var native_width = 0;
                                var native_height = 0;

                                //Now the mousemove function
                                $(".magnify<%=sid%>").mousemove(function (e) {
                                    //When the user hovers on the image, the script will first calculate
                                    //the native dimensions if they don't exist. Only after the native dimensions
                                    //are available, the script will show the zoomed version.
                                    if (!native_width && !native_height)
                                    {
                                        //This will create a new image object with the same image as that in .small
                                        //We cannot directly get the dimensions from .small because of the 
                                        //width specified to 200px in the html. To get the actual dimensions we have
                                        //created this image object.
                                        var image_object = new Image();
                                        image_object.src = $(".small<%=sid%>").attr("src");

                                        //This code is wrapped in the .load function which is important.
                                        //width and height of the object would return 0 if accessed before 
                                        //the image gets loaded.
                                        native_width = image_object.width;
                                        native_height = image_object.height;
                                    } else
                                    {
                                        //x/y coordinates of the mouse
                                        //This is the position of .magnify with respect to the document.
                                        var magnify_offset = $(this).offset();
                                        //We will deduct the positions of .magnify from the mouse positions with
                                        //respect to the document to get the mouse positions with respect to the 
                                        //container(.magnify)
                                        var mx = e.pageX - magnify_offset.left;
                                        var my = e.pageY - magnify_offset.top;

                                        //Finally the code to fade out the glass if the mouse is outside the container
                                        if (mx < $(this).width() && my < $(this).height() && mx > 0 && my > 0)
                                        {
                                            $(".large<%=sid%>").fadeIn(100);
                                        } else
                                        {
                                            $(".large<%=sid%>").fadeOut(100);
                                        }
                                        if ($(".large<%=sid%>").is(":visible"))
                                        {
                                            //The background position of .large will be changed according to the position
                                            //of the mouse over the .small image. So we will get the ratio of the pixel
                                            //under the mouse pointer with respect to the image and use that to position the 
                                            //large image inside the magnifying glass
                                            var rx = Math.round(mx / $(".small<%=sid%>").width() * native_width - $(".large").width() / 2) * -1;
                                            var ry = Math.round(my / $(".small<%=sid%>").height() * native_height - $(".large").height() / 2) * -1;
                                            var bgp = rx + "px " + ry + "px";

                                            //Time to move the magnifying glass with the mouse
                                            var px = mx - $(".large<%=sid%>").width() / 2;
                                            var py = my - $(".large<%=sid%>").height() / 2;
                                            //Now the glass moves with the mouse
                                            //The logic is to deduct half of the glass's width and height from the 
                                            //mouse coordinates to place it with its center at the mouse coordinates

                                            //If you hover on the image now, you should see the magnifying glass in action
                                            $(".large<%=sid%>").css({left: px, top: py, backgroundPosition: bgp});
                                        }
                                    }
                                })
                            })
                        </script>
                        <style>
                            /*Some CSS*/
                            /*                            * {margin: 0; padding: 0;}*/
                            .magnify<%=sid%> {width: 200px; margin: 50px auto; position: relative;}

                            /*Lets create the magnifying glass*/
                            .large<%=sid%> {
                                width: 175px; height: 175px;
                                position: absolute;
                                border-radius: 100%;

                                /*Multiple box shadows to achieve the glass effect*/
                                box-shadow: 0 0 0 7px rgba(255, 255, 255, 0.85), 
                                    0 0 7px 7px rgba(0, 0, 0, 0.25), 
                                    inset 0 0 40px 2px rgba(0, 0, 0, 0.25);

                                /*Lets load up the large image first*/
                                background: url('uploadfiles/<%=image%>') no-repeat;

                                /*hide the glass by default*/
                                display: none;
                            }

                            /*To solve overlap bug at the edges during magnification*/
                            .small<%=sid%> { display: block; }
                        </style>
                        <!-- Lets make a simple image magnifier -->
                        <div class="magnify<%=sid%>">

                            <!-- This is the magnifying glass which will contain the original/large version -->
                            <div class="large<%=sid%>"></div>

                            <!-- This is the small image -->
                            <img class="small<%=sid%>" src="uploadfiles/<%=image%>" width="200"/>

                        </div>
                            <table style="width: 100%">
                                <tr>
                                    <td>
                                              <p style="color: #22749f; font-size: large;float: left  " > <%=status%></p>
                       
                                    </td>
                                    <td>
                                              <p style="color: #22749f; font-size: large;float: right  " > <%=rdate%></p>
                       
                                    </td>
                                      <td>
                                          <p style="color: #22749f; font-size: large;float: right  " >    <form action='useraccount.jsp' method=post> <input type=hidden name=fuserid value="<%=fuserid%>"><input type=submit  value="View User"></form>
                                    </p>
                       
                                    </td>
                                </tr>
                            </table>
                            

                        

                        <%    }

                            } catch (Exception e) {
                                e.printStackTrace();
                            }

                        %>

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