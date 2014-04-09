<%-- 
    Document   : usertest
    Created on : Apr 1, 2014, 5:47:02 PM
    Author     : young
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="Store.User"%>
<%@page import="Store.UserManager"%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <h1>User Test</h1>
        
        <% 
       
        UserManager.addUser("Roxanne","password","String a;");
       
            
        User u = UserManager.getUser("Roxanne");
        u.setBotCode("int x;");
        
        UserManager.modifyUser(u);
        
        User another = UserManager.getUser("Roxanne");
        
        out.println(another.getBotCode());
        %>
    </body>
</html>
