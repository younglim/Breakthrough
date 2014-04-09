<%-- 
    Document   : getAllBotCodes
    Created on : Apr 7, 2014, 12:58:44 PM
    Author     : young
--%><%@page import="Store.BotCodeManager"%><%@page import="java.util.ArrayList"%><%@page import="Store.BotCode"%><%@page import="java.util.List"%><%@page import="com.google.gson.Gson"%><%@page import="Store.UserManager"%><%@page import="Store.User"%><%@page contentType="application/json" pageEncoding="UTF-8"%><%!
    class result {

        String username;
        String status;
        List<BotCode> botCodes;
       

        public result(String username, String status, List<BotCode> botCodes) {
            this.username = username;
            this.status = status;
            this.botCodes = botCodes;

        }
    }

%><%
    String username = request.getParameter("username");
    String password = request.getParameter("password");

    List<BotCode> botCodes = new ArrayList<BotCode>();

    result r = new result(username, "User invalid. Please provide username and password parameters to retrieve ALL bot codes.", botCodes);

    
    try {
        User u = UserManager.getUser(username);
        if (u != null && u.getPassword().equals(password)) {
            List<BotCode> temp = BotCodeManager.getAllBotCodes();

            if (temp == null || temp.isEmpty()) {
                r = new result(username, "There no bots", botCodes);

            } else {
                botCodes = temp;
                r = new result(username, "Successfully retrieved ALL bots.", botCodes);

            }
        }
    } catch (Exception e) {

    }
    Gson gson = new Gson();
    out.println(gson.toJson(r));

%>
