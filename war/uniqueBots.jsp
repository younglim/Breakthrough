<!DOCTYPE html>
<%@include file="protect.jsp"%>
<html lang="en">
    <head>
        <meta charset="utf-8">
        <title>Breakthrough - Unique Bots</title>
        <%@page import="Store.*, java.util.*, java.text.*, java.sql.*" %>
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

            .container-narrow {
                margin: 3% auto 0 auto;
                max-width: 800px;
            }
        </style>
        <jsp:include page="analytics.jsp"></jsp:include>
        
      
        
        <%            List<BotCode> botCodes = BotCodeManager.getAllBotCodes();
            HashMap<String, Integer> uniqueBotCodes = new HashMap<String, Integer>();
            HashMap<String, ArrayList<String>> users = new HashMap<String, ArrayList<String>>();

            for (BotCode bc : botCodes) {
                if (uniqueBotCodes.get(bc.getBotCode()) == null) {
                    uniqueBotCodes.put(bc.getBotCode(), 1);
                    ArrayList<String> botUsers = new ArrayList<String>();
                    botUsers.add(bc.getUser());

                    users.put(bc.getBotCode(), botUsers);

                } else {
                    uniqueBotCodes.put(bc.getBotCode(), uniqueBotCodes.get(bc.getBotCode()) + 1);
                    users.get(bc.getBotCode()).add(bc.getUser());
                }

            }

			  int total = uniqueBotCodes.size();
			  
        %>
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
        <div class="container-narrow">
            <h4>Unique Bots and Users</h4><br/>
            <jsp:include page="facebookShare.html"></jsp:include>
                <br><br/>    
                <a href="leaderboard.jsp">Back to Leaderboard</a>
                <br/><br/>

				<h5>Number of Unique Bots: <%=total%></h5>
                <table class="table table-hover">
                    <tr>
                        <th>Bot Code</th>
                        <th>Number of Users</th>
                        <th>User List</th>

                    </tr>
                <%    Iterator it = uniqueBotCodes.entrySet().iterator();

                    while (it.hasNext()) {
                        Map.Entry pairs = (Map.Entry) it.next();
                        String code = (String) pairs.getKey();
                        int numbers = (Integer) pairs.getValue();

                        it.remove(); // avoids a ConcurrentModificationException

                        ArrayList<String> botUser = users.get(code);
                        String userList = "";

                        for (String u : botUser) {
                            userList += u + "<br/>";
                        }


                %>
                <tr>
                    <td><%=code.replaceAll("\n", "<br/>").replaceAll("\t", "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;")%></td>
                    <td><%=numbers%></td>
                    <td><%=userList%></td>

                </tr>
                <%  }
                %>
            </table>
            <br/>

        </div><!-- /.container -->
    </body>
</html>
