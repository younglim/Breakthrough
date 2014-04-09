<%-- 
    Document   : addBotCode
    Created on : Apr 7, 2014, 12:24:31 PM
    Author     : young
--%><%@page import="breakthroughgame.GameBoard"%><%@page import="Store.BotCodeManager"%><%@page import="Store.BotCode"%><%@page import="java.util.List"%><%@page import="java.util.List"%><%@page import="com.google.gson.Gson"%><%@page import="Store.UserManager"%><%@page import="Store.User"%><%@page contentType="application/json" pageEncoding="UTF-8"%><%!
    class result {

        String username;
        String status;
        Long botCodeId;

        public result(String username, String status, Long botCodeId) {
            this.username = username;
            this.status = status;
            this.botCodeId = botCodeId;

        }
    }
%><%

    String username = request.getParameter("username");
    String password = request.getParameter("password");
    String botCode = request.getParameter("botCode");
    String botCodeLanguage = "java";

    result r = new result(username, "User invalid or Bot Code cannot be mepty. Please specify username and password parameters.", 0L);

    try {
        User u = UserManager.getUser(username);

        if (u != null && u.getPassword().equals(password) && !botCode.isEmpty()) {

            List<BotCode> existingBots = BotCodeManager.getAllBotCodesUser(username);

            for (BotCode b : existingBots) {
                if (b.getBotCode().trim().equals(botCode.trim())) {
                    r = new result(username, "You are not allowed to create duplicate bots.\nPlease modify your bot code to add another.", 0L);
                    break;
                }
            }

            GameBoard gb = new GameBoard();

            String board = gb.runGame(" 12345678 ,1wwwwwwww1,2wwwwwwww2,3________3,4________4,5________5,6________6,7bbbbbbbb7,8bbbbbbbb8, 12345678 ", 'b', botCode, BotCodeManager.getBasicBot(), 5);

            if (board.contains("Error")) {
                r = new result(username, "An error was found:\n" + board, 0L);

            } else {
                BotCodeManager.addBotCode(botCode, "java", botCode);
                BotCode nbc = BotCodeManager.getBotCode(username);
                Long id = nbc.getId();

                r = new result(username, "Successfully created bot.", id);

            }

        }
    } catch (Exception e) {

    }
    Gson gson = new Gson();
    out.println(gson.toJson(r));

%>