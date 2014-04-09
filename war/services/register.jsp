<%-- 
    Document   : register
    Created on : Apr 7, 2014, 12:15:45 PM
    Author     : young
--%><%@page import="com.google.gson.Gson"%><%@page import="Store.UserManager"%><%@page import="Store.User"%><%@page contentType="application/json" pageEncoding="UTF-8"%><%!
    class result {

        String username;
        String status;

        public result(String username, String status) {
            this.username = username;
            this.status = status;

        }
    }

    public boolean isAlphaNumeric(String s) {
        String pattern = "^[a-zA-Z0-9]*$";
        if (s.matches(pattern)) {
            return true;
        }
        return false;
    }
%><%
    String username = request.getParameter("username");
    String password = request.getParameter("password");

    result r = new result(username, "An unknown error has occured. Please specify username and password parameters.");

    if (username == null || password == null || username.isEmpty() || password.isEmpty() || !isAlphaNumeric(username) || username.length() < 5 || password.length() < 6) {
        r = new result(username, "Please ensure username is alphanumeric and at least 4 characters long, and Password is at least 6 characters long.");

    } else {
        try {
            User user = UserManager.getUser(username);

            if (user == null) {
                UserManager.addUser(username, password, "");
                r = new result(username, "Successfully registered user.");

            } else {
                r = new result(username, "Username is already taken.");

            } // end if-else
        } catch (Exception e) {

        }
    }

    Gson gson = new Gson();
    out.println(gson.toJson(r));

%>