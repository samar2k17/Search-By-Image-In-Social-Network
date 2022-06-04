<%
    String utype = null;
    utype = (String) session.getAttribute("UTYPE");


%>

<div class="arrowgreen">
    <ul style="line-height: 20px;list-style: none;font-size: 14px;">


        <%            if (utype.equals("admin")) {
        %>           
        <li><a href="uploadfile_pro.jsp">Upload Prohibited Files</a></li>
        <li><a href="userlist.jsp">User List</a></li>
        <li><a href="adfilelists.jsp">File List</a></li>


        <%        } else if (utype.equals("user")) {
        %>         
        <li><a href="newsfeed.jsp">News Feed</a></li>
        <li><a href="likes.jsp">Likes</a></li>
             <li><a href="uploadfile.jsp">Status Update</a></li>
             <li><a href="profile.jsp">Profile</a></li>
        <li><a href="myaccount.jsp">Update Account</a></li>
   
        <li><a href="friendLists.jsp">Friend List</a></li>
        <li><a href="searchfriends.jsp">Search New Friends</a></li>
        <li><a href="searchfriendsByImage.jsp">Search Friends By Image</a></li>
        <li><a href="messages.jsp">Chat</a></li>



        <%            } 
        %>         
       
        <li><a href="changepwd.jsp">Change Password</a></li>
        <li><a href="logout">Logout</a></li>
    </ul>    
</div>