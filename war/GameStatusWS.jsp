<%-- 
    Document   : GameStatusWS
    Created on : Apr 6, 2014, 7:33:15 PM
    Author     : young
--%>
<%@page import="breakthroughgame.CurrentGame"%>
<%CurrentGame cg = (CurrentGame) session.getAttribute("currentGame");

    if (cg != null) {
        out.println("Ongoing Game: " + cg.getStatus());
    }

    if (request.getParameter("link") != null) {

        if (session.getAttribute("currentGame") instanceof CurrentGame) {
            out.println("<a href='GameStatus.jsp'>Go Back to Ongoing Game</a>");

            if (!cg.getStatus().equals("game_ended")) {
                out.println("/ <a href='GameStatusWS.jsp?endGame=1&redirect=1'>Abort Current Game</a>");

            }

        }
    }

    if (request.getParameter("endGame") != null) {
        session.removeAttribute("currentGame");
%> 
<br/>Game has ended.
<%
    }

    if (request.getParameter("redirect") != null) {
%>
<script>
    window.location = "index.jsp";
</script>
<%
    }
%>
