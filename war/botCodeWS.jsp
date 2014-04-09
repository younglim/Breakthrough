<%@page import="Store.BotCodeManager,Store.BotCode,java.util.ArrayList,Store.Score,Store.ScoreManager"%><%  BotCode bc = BotCodeManager.getBotCodeById(Long.parseLong(request.getParameter("id")));
    if (bc != null) {
        out.println(bc.getBotCode());
    }
%>