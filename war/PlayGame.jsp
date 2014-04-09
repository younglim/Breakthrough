<%-- 
    Document   : PlayGame
    Created on : Apr 4, 2014, 12:30:02 PM
    Author     : muhammadmk.2012
--%>

<%@page import="breakthroughgame.CurrentGame"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Play Game</title>
  </head>
  <body>
    <h1>Let's play</h1>
    <%
      
      CurrentGame cg = (CurrentGame) session.getAttribute("currentGame");
      // Board and player
      String board;
      String player;
      String codeB = "";
      String codeW = "";
      String userB = "";
      String userW = "";
      if (cg != null) {
        board = cg.getBoard();
        player = String.valueOf(cg.getPlayer());
        codeB = cg.getBotCodeB();
        codeW = cg.getBotCodeW();
        userB = cg.getUserB();
        userW = cg.getUserW();    
        
      } else {
        board = " 12345678 ,1wwwwwwww1,2wwwwwwww2,3________3,4________4,5________5,6________6,7bbbbbbbb7,8bbbbbbbb8, 12345678 ";
        player = "b";
      }

    %>

    
    <b>Game Parameters:</b>
    <br/>
    Board: <%=board%>
    <br/>
    Current Player: <%=player%>
    <br/>
    <hr/>
    <form action='/SetSession' method='post' id="submissionForm">
      <button type='submit'>Play Game</button>
      <br/>
      <b>Input Challenger: </b>
      <br/>
      <input type="text" name="userB" value="<%=userB%>">
      <br/>
      <textarea rows="10" cols="80" name="botCodeB" form="submissionForm" ><%=codeB%></textarea>
      <br/>
      <br/>
      <b>Input Defender: </b>
      <br/>
      <input type="text" name="userW" value="<%=userW%>">
      <br/>
      <textarea rows="10" cols="80" name="botCodeW" form="submissionForm" ><%=codeW%></textarea>
      <br/>
      <input type="hidden" name="board" value="<%=board%>"/>
      <input type="hidden" name="player" value="<%=player%>"/>
      

    </form>


    <br/>
    <hr/>

    

  </body>
</html>
