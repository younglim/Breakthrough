<!DOCTYPE html>
<%@include file="protect.jsp"%>
<%@page import="java.util.*, java.text.*" %>
<html lang="en">
    <head>

        <meta charset="utf-8">
        <title>Breakthrough - Home</title>
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

        <div id="page-loading" style="display: none"><div class="centerContent"><br/>Loading<br/>Please wait</div></div> 

    </head>
    <body>
        <div class="navbar navbar-inverse navbar-fixed-top" role="navigation">
            <div class="container">
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
                        <li class="active"><a href="index.jsp">Game Play</a></li>
                        <li><a href="leaderboard.jsp">Leaderboard</a></li>
                        <li><a href="GameStatus.jsp">Game Status</a></li>

                        <li><a href="services/index.jsp">Web Services</a><li><a href="logout.jsp">Logout</a></li>                    
                    </ul>
                </div><!--/.nav-collapse -->
            </div>
        </div>
        <div class="container">
            <br><h4>Welcome, <b><%=username%></b>!</h4>

        <div class="introduction">
            <jsp:include page="introMain.jsp"></jsp:include>
            </div>
        <jsp:include page="facebookShare.html"></jsp:include>
            <hr>

            <h4><jsp:include page="GameStatusWS.jsp?link=1"></jsp:include></h4>
            <form action='/SetSession' method='post' id="submissionForm">
                <div style="width: 500px; height:auto; float:left; padding:0 50px 0 0">


                <%
                    List<BotCode> opponentBotCodes = BotCodeManager.getTopTen(username);
                    List<BotCode> userBotCodes = BotCodeManager.getAllBotCodesUser(username);

                    out.println("<h4>Top Opponents: " + opponentBotCodes.size() + "<small> Bots to choose from</small></h4>");

                    out.println("<select class='form-control' id='botCodeDDL' name='botCodeDDL' style='width:410px' required/>");

                    for (BotCode botCode1 : opponentBotCodes) {
                        String botCodeUser = botCode1.getUser();
                        Long botCodeId = botCode1.getId();
                        String displayAs ="";
                        if (botCode1.getTempScore()!=null) {
                           displayAs = botCodeUser +" ("+botCode1.getTempScore()+" Points)"+ " - " + botCode1.getDate();
                        
                        } else {
                            displayAs = botCodeUser + " - " + botCode1.getDate();
                        
                        }
                        out.println("<option value='" + botCodeId + "'>" + displayAs + "</option>");
                    }
                    out.println("</select><br>");
                %>
                <textarea id="bot1" rows="10" cols="65" readonly></textarea>
            </div>
            <div style="width: 500px; height:auto; float:left; padding:0 50px 0 0">

                <%
                    out.println("<h4>You: " + userBotCodes.size() + "<small> Bots to choose from</small></h4>");
                    out.println("<select class='form-control' id='botCodeDDL2' name='botCodeDDL2' style='width:410px' required/>");

                    for (BotCode botCode2 : userBotCodes) {
                        String botCodeUser = botCode2.getUser();
                        Long botCodeId = botCode2.getId();
                        String displayAs = botCodeUser + " - " + botCode2.getDate();
                        out.println("<option value='" + botCodeId + "'>" + displayAs + "</option>");
                    }
                    out.println("</select><br>");
                %>
                <textarea id="bot2" rows="10" cols="65"></textarea>

                <br/><br/>
                <button id="add-btn" onclick="addBotCode();
                        return false;" class="btn btn-success style='width:100px'">Add / Modify Bot Code</button>
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;

                <button id="play-btn" class="btn btn-success style='width:100px'">Play</button>

                <button id="reset-btn" class="btn btn-failure style='width:100px'">Reset</button>
                <br/>
                &nbsp;
            </div>
        </form>
    </div><!-- /.container -->

    <script>
        $("#botCodeDDL").change(function() {
            var item = $(this);
            getBotCodeById(item.val(), "#bot1");
        });

        $("#botCodeDDL2").change(function() {
            var item = $(this);
            getBotCodeById(item.val(), "#bot2");
        });

        $('#reset-btn').click(function() {
            location.reload();
            return false;
        });

        function getBotCodeById(id, elem) {
            $.ajax({
                url: "botCodeWS.jsp?id=" + id,
                type: 'GET',
                processData: false, // tell jQuery not to process the data
                contentType: false, // tell jQuery not to set contentType
                success: function(data) {
                    $(elem).val(data);
                }
            });
        }

        function addBotCode() {
            $("#page-loading").show();
            var botCodeVal = $("#bot2").val();
            if (botCodeVal != "") {

                $.ajax({
                    type: 'POST',
                    url: 'botCodeAddWS.jsp',
                    data: {
                        'submitUser': '<%=username%>',
                        'submitBotCode': botCodeVal // <-- the $ sign in the parameter name seems unusual, I would avoid it
                    },
                    success: function(data) {

                        if (data.trim() == "success") {
                            alert("Bot Code Added Successfully.\nYou may now pick a bot to play against.");
                            setTimeout("location.reload();", 100);
                            $("#page-loading").hide();
                        } else {

                            alert(data);
                            $("#page-loading").hide();
                        }
                    },
                    error: function(request, status, error) {
                        alert(request.responseText + "\nAn error has occured processing the bot code. Please try again later.");
                        setTimeout("location.reload();", 100);
                    }
                });


            } else {
                alert("Choose a bot from your list, or type a valid Java-language bot.\nFor a start, you can copy your opponents' code.");
            }
        }

        $(document).ready(function() {
            // Handler for .ready() called.
            getBotCodeById($("#botCodeDDL").val(), "#bot1");
            getBotCodeById($("#botCodeDDL2").val(), "#bot2");
        });

    </script>
</body>
</html>