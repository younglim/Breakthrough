<%-- 
    Document   : playGame
    Created on : Apr 7, 2014, 1:05:39 PM
    Author     : young
--%><%@page import="Store.ScoreManager"%><%@page import="breakthroughgame.GameBoard"%><%@page import="Store.BotCodeManager"%><%@page import="Store.BotCode"%><%@page import="com.google.gson.Gson"%><%@page import="Store.UserManager"%><%@page import="Store.User"%><%@page import="Store.User"%><%@page import="java.util.ArrayList"%><%@page import="breakthroughgame.CurrentGame"%><%@page import="java.util.List"%><%@page contentType="application/json" pageEncoding="UTF-8"%><%!

    class result {

        String username;

        String status;

        List<CurrentGame> moves;

        public result(String username, String status, List<CurrentGame> moves) {
            this.username = username;
            this.status = status;
            this.moves = moves;
        }
    }


%><%
    String username = request.getParameter("username");
    String password = request.getParameter("password");

    List<CurrentGame> moves = new ArrayList<CurrentGame>();

    result r = new result(username, "User invalid. Please provide username, password, botCodeWhite and botCodeBlack (as Long Ids of Bot Codes) parameters to play the game.", moves);

    try {
        User u = UserManager.getUser(username);
        if (u != null && u.getPassword().equals(password)) {

            BotCode black = BotCodeManager.getBotCodeById(Long.parseLong(request.getParameter("botCodeBlack")));
            BotCode white = BotCodeManager.getBotCodeById(Long.parseLong(request.getParameter("botCodeWhite")));

            String board = " 12345678 ,1wwwwwwww1,2wwwwwwww2,3________3,4________4,5________5,6________6,7bbbbbbbb7,8bbbbbbbb8, 12345678 ";

            String Splayer = (String) "w";
            String botCodeB = (String) black.getBotCode();
            String botCodeW = (String) white.getBotCode();
            String userB = (String) black.getUser();
            String userW = (String) white.getUser();
            String status = (String) request.getParameter("status");

            CurrentGame cg = new CurrentGame();
            cg.setBoard(board);
            cg.setBotCodeB(botCodeB);
            cg.setBotCodeW(botCodeW);
            cg.setPlayer(Splayer.charAt(0));
            cg.setUserB(userB);
            cg.setUserW(userW);

            cg.setUserWBotCodeId(white.getId());
            cg.setUserBBotCodeId(black.getId());

            if (status == null) {
                cg.setStatus("No status Yet");
            } else {
                cg.setStatus(status);
            }

            moves.add(cg);

            String statusText = "Error occured during game play";

            for (int i = 0; i < 101; i++) {
                cg = new CurrentGame();

                CurrentGame previousMove = moves.get(i);

                cg.setBoard(previousMove.getBoard());
                cg.setBotCodeB(previousMove.getBotCodeB());
                cg.setBotCodeW(previousMove.getBotCodeW());
                cg.setPlayer(previousMove.getPlayer());
                cg.setStatus(previousMove.getStatus());
                cg.setSteps(previousMove.getSteps());
                cg.setUserB(previousMove.getUserB());
                cg.setUserBBotCodeId(previousMove.getUserBBotCodeId());
                cg.setUserW(previousMove.getUserW());
                cg.setUserWBotCodeId(previousMove.getUserWBotCodeId());

                String currentBoard = cg.getBoard();
                char player = cg.getPlayer();
                botCodeB = cg.getBotCodeB();
                botCodeW = cg.getBotCodeW();
                userB = cg.getUserB();
                userW = cg.getUserW();
                status = cg.getStatus();

                GameBoard gb = new GameBoard();

                board = gb.runGame(currentBoard, player, botCodeB, botCodeW);
                cg.setSteps(cg.getSteps() + 1);

                if (!board.contains("Error")) {
                    boolean win = gb.checkWin(board);

                    if (win) {
                        if (player == 'w') {
                            cg.setPlayer(player);
                            cg.setBoard(board);
                            cg.setStatus("White wins.");

                            moves.add(cg);

                            statusText = "Game Ended, " + "White Wins, " + cg.getUserW() + " wins.";

                            ScoreManager.WinGame(userW, userB, cg.getUserWBotCodeId(), cg.getUserBBotCodeId());

                            r = new result(username, statusText, moves);
                            break;

                        } else if (player == 'b') {
                            cg.setPlayer(player);
                            cg.setBoard(board);

                            cg.setStatus("Black wins.");
                            moves.add(cg);

                            statusText = "Game Ended, " + "Black Wins, " + cg.getUserB() + " wins.";

                            ScoreManager.WinGame(userB, userW, cg.getUserBBotCodeId(), cg.getUserWBotCodeId());
                            r = new result(username, statusText, moves);
                            break;

                        }
                    } else {

                        if (cg.getSteps() >= 100) {
                            ScoreManager.DrawGame(userW, userB, cg.getUserWBotCodeId(), cg.getUserBBotCodeId());
                            cg.setStatus("Draw! More than 100 Moves and game has not ended.");

                            moves.add(cg);

                            statusText = "Game Ended, " + cg.getStatus()+" its a Draw!";
                            r = new result(username, statusText, moves);
                            break;

                        } else {
                            if (player == 'b') {
                                cg.setPlayer('w');
                            } else {
                                cg.setPlayer('b');
                            }
                            cg.setBoard(board);
                            cg.setStatus("No winner yet.");

                            moves.add(cg);

                        }

                    }
                }
            }
        }
    } catch (Exception e) {

    }
    Gson gson = new Gson();
    out.println(gson.toJson(r));

%>
