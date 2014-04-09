<%-- 
    Document   : DisplayBoard
    Created on : Apr 5, 2014, 6:56:31 PM
    Author     : muhammadmk.2012
--%>
<%@page import="Store.ScoreManager"%>
<%@page import="breakthroughgame.CurrentGame"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="breakthroughgame.GameBoard"%>
<%
    CurrentGame cg = (CurrentGame) session.getAttribute("currentGame");
    String currentBoard = cg.getBoard();
    char player = cg.getPlayer();
    String botCodeB = cg.getBotCodeB();
    String botCodeW = cg.getBotCodeW();
    String userB = cg.getUserB();
    String userW = cg.getUserW();
    String status = cg.getStatus();
    
    GameBoard gb = new GameBoard();

    String board = gb.runGame(currentBoard, player, botCodeB, botCodeW);
    cg.setSteps(cg.getSteps() + 1);

    if (!board.contains("Error")) {
        boolean win = gb.checkWin(board);

        if (win) {
            if (player == 'w') {
                cg.setPlayer(player);
                cg.setBoard(board);
                 cg.setStatus("Opponent Wins, You Lose.");
                session.setAttribute("currentGame", cg);
                out.print("<div style='display:none;'>game_ended</div>");

                ScoreManager.WinGame(userW, userB, cg.getUserWBotCodeId(), cg.getUserBBotCodeId());

            } else if (player == 'b') {
                cg.setPlayer(player);
                cg.setBoard(board);
               
                cg.setStatus("You Win");
                session.setAttribute("currentGame", cg);
                out.print("<div style='display:none;'>game_ended</div>");

                ScoreManager.WinGame(userB, userW, cg.getUserBBotCodeId(), cg.getUserWBotCodeId());

            }
        } else {

            if (cg.getSteps() >= 100) {
                ScoreManager.DrawGame(userW, userB, cg.getUserWBotCodeId(), cg.getUserBBotCodeId());
                out.print("<div style='display:none;'>game_ended</div>");
                cg.setStatus("Draw! More than 100 Moves and game has not ended.");
            } else {
                if (player == 'b') {
                    cg.setPlayer('w');
                } else {
                    cg.setPlayer('b');
                }
                cg.setBoard(board);
                cg.setStatus("No winner yet.");
                
            }
            
            session.setAttribute("currentGame", cg);

        }

        out.println("<h4>Move #" + cg.getSteps() + "</h4>");
        //out.println("Da board in jsp: " + board);
        out.println(gb.display(board));
        out.println("<hr/>");
    } else {
        out.print(board);
    }


%>
