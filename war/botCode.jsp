<%-- 
    Document   : chart
    Created on : Apr 5, 2014, 3:03:42 PM
    Author     : young
--%>
<%@include file="protect.jsp"%>
<%@page import="java.util.ArrayList"%>
<%@page import="Store.Score"%>
<%@page import="Store.ScoreManager"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <%  BotCode bc = BotCodeManager.getBotCodeById(Long.parseLong(request.getParameter("id")));

            String codeString = "";
            String userString = "";
            String languageString = "";
            String dateString = "";

            if (bc != null) {
                codeString = bc.getBotCode();
                userString = bc.getUser();
                languageString = bc.getLanguage();

            }
        %>
        <title>Bot Code Details</title>
        <link rel="stylesheet" href="//netdna.bootstrapcdn.com/bootstrap/3.0.3/css/bootstrap.min.css"><script src="https://code.jquery.com/jquery-1.10.2.min.js"></script><script src="//netdna.bootstrapcdn.com/bootstrap/3.0.3/js/bootstrap.min.js"></script>
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

            .textarea {
                font-family: inherit;
                font-size: inherit;
            }
        </style>
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
                        <li class="active"><a href="leaderboard.jsp">Leaderboard</a></li>
                        <li><a href="GameStatus.jsp">Game Status</a></li>

                        <li><a href="services/index.jsp">Web Services</a><li><a href="logout.jsp">Logout</a></li>                    
                    </ul>
                </div><!--/.nav-collapse -->
            </div>
        </div>
        <div class="container">
            
            <br/>
        <div class="row">
       
             <a href="winningBots.jsp"><< Back to Winning Bots</a>
        </div>
             
            <br>
            User : <%=userString%>

            <br/><br/>
            Time Submitted : <%=bc.getDate()%>
            <br/><br/>
            Language Submitted : <%=languageString%>
            <br/><br/>

            Bot Code:<br/>
            <textarea rows="10" cols="65" readonly><%=codeString%></textarea>
        </div>
    </body>
</html>
