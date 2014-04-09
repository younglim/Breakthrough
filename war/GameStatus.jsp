<%-- 
    Document   : GameStatus
    Created on : Apr 5, 2014, 6:23:43 PM
    Author     : muhammadmk.2012
--%>
<%@page import="breakthroughgame.CurrentGame"%>
<!DOCTYPE html>
<%@include file="protect.jsp"%>
<html lang="en">
    <head>
        <meta charset="utf-8">
        <title>Breakthrough - Game Progress</title>
        <%@page import=" java.util.*, java.text.*, java.sql.*" %>
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta name="description" content="">
        <meta name="author" content="">
        <!-- Bootstrap core CSS -->
        <link rel="stylesheet" href="//netdna.bootstrapcdn.com/bootstrap/3.0.3/css/bootstrap.min.css"><script src="https://code.jquery.com/jquery-1.10.2.min.js"></script><script src="//netdna.bootstrapcdn.com/bootstrap/3.0.3/js/bootstrap.min.js"></script>
        
        <!-- Custom styles for this template -->
        <style>
            /* app css stylesheet */
            body {
                padding-top: 50px;
            }
            .starter-template {
                padding: 40px 15px;
                text-align: center;
            }
            #page-loading {
                position: fixed;
                height: 100%;
                width: 100%;
                top: 0; left: 0;
                z-index: 999999; 
                opacity:0.8;
                background-color: black;
                text-align: center;
                color: white;
            }
            .centerContent {
                position: absolute;
                top: 50%;
                left: 50%;
                margin-top: -50px;
                margin-left: -50px;
                width: 100px;
                height: 100px;
            }
        </style>
        <jsp:include page="analytics.jsp"></jsp:include>
        </head>
        <body>
            <div class="navbar navbar-inverse navbar-fixed-top" role="navigation">
                <div class="container" >
                    <div class="navbar-header">
                        <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse">
                            <span class="sr-only">Toggle navigation</span>
                            <span class="icon-bar"></span>
                            <span class="icon-bar"></span>
                            <span class="icon-bar"></span>
                        </button>
                        <a class="navbar-brand" href="/">IS429 :: Breakthrough</a>
                    </div>
                    <div class="collapse navbar-collapse">
                        <ul id="navbar" class="nav navbar-nav">
                            <li><a href="index.jsp">Game Play</a></li>
                            <li><a href="leaderboard.jsp">Leaderboard</a></li>
                            <li class="active"><a href="GameStatus.jsp">Game Status</a></li>

                            <li><a href="services/index.jsp">Web Services</a><li><a href="logout.jsp">Logout</a></li>                    
                        </ul>
                    </div><!--/.nav-collapse -->
                </div>
            </div>
            <div class="container">
            <br><jsp:include page="facebookShare.html"></jsp:include><br>

            <%  CurrentGame cg = (CurrentGame) session.getAttribute("currentGame");
                if (cg != null) {
                    out.println("<h4>Game in Progress... <small><br>Please do not leave this page, else game play will pause.<br>Otherwise, you may choose to <a href='GameStatusWS.jsp?endGame=1&redirect=1'>(Abort Current Game)</a></small></h4>");
                    out.println("<ul><li>Opponent (White) : " + cg.getUserW());
                    out.println("</li><li>You (Black) : " + cg.getUserB());
                    out.println("</ul>");
            %>
            <div id="gameProgress">

            </div>
            <br/>&nbsp<br/>
        </div>
        <script>
            /*
             var refreshIntervalId = setInterval('getNewBoard()', 5000); // 60 seconds
             
             function stopRefresh() {
             clearInterval(refreshIntervalId);
             
             }
             */
            var getNewBoard = function() {

                $.ajax({
                    url: "DisplayBoard.jsp",
                    type: 'GET',
                    processData: false, // tell jQuery not to process the data
                    contentType: false, // tell jQuery not to set contentType
                    success: function(data) {

                        $("#gameProgress").append(data);

                        if (data.indexOf("game_ended") > -1) {

                            $.ajax({
                                url: "GameStatusWS.jsp?endGame=1",
                                type: 'GET',
                                processData: false, // tell jQuery not to process the data
                                contentType: false, // tell jQuery not to set contentType
                                success: function(data) {
                                    $("#gameProgress").append("<h4>" + data + "</h4>");
                                }
                            });

                            // stopRefresh();
                        }
                        else {

                            getNewBoard();
                        }
                        window.scrollTo(0, document.body.scrollHeight);
                    },
                    error: function(request, status, error) {
                        alert(request.responseText + "\nYou have paused the game or the game server is unreachable at the moment.\nClick 'Game Status' to return to the game.");
                    }
                });
            }

            getNewBoard();

        </script>

        <%} else {
        %>
        <h4>No Games in Progress.
            <br/>
            <small>Go back to <a href="index.jsp">main page</a> and select an opponent and your bot and click "Play".
            </small>
        </h4>

        <%
            }%>
    </body>
</html>
