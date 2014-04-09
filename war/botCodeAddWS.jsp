<%@page import="breakthroughgame.GameBoard"%>
<%@page import="java.util.List"%>
<%@page import="Store.User"%><%@page import="Store.UserManager"%><%@page import="Store.BotCodeManager,Store.BotCode"%><%
    String botCode = request.getParameter("submitBotCode");
    String userOfCode = request.getParameter("submitUser");
    String botCodeLanguage = "java";

    User u = UserManager.getUser(userOfCode);

    if (u != null && !botCode.isEmpty()) {

        List<BotCode> existingBots = BotCodeManager.getAllBotCodesUser(userOfCode);

        for (BotCode b : existingBots) {
            if (b.getBotCode().trim().equals(botCode.trim())) {
                out.println("You are not allowed to create duplicate bots.\nPlease modify your bot code to add another.");
                return;
            }
        }

        GameBoard gb = new GameBoard();

        String board = gb.runGame(" 12345678 ,1wwwwwwww1,2wwwwwwww2,3________3,4________4,5________5,6________6,7bbbbbbbb7,8bbbbbbbb8, 12345678 ", 'b', botCode, BotCodeManager.getBasicBot(), 5);

        if (board.contains("Error")) {
            out.println("An error was found:\n" + board);
            return;
        } else {
            BotCodeManager.addBotCode(userOfCode, "java", botCode);
            out.println("success");
        }

    } else {
        out.println("User invalid or Bot Code cannot be mepty.");
    }
%>