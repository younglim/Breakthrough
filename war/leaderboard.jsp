<!DOCTYPE html>
<%@include file="protect.jsp"%>
<html lang="en">
    <head>
        <meta charset="utf-8">
        <title>Breakthrough - Leaderboard</title>
        <%@page import="Store.*, java.util.*, java.text.*, java.sql.*" %>
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta name="description" content="">
        <meta name="author" content="">
        <!-- Bootstrap core CSS -->
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

            .container-narrow {
                margin: 3% auto 0 auto;
                max-width: 800px;
            }
        </style>
        <jsp:include page="analytics.jsp"></jsp:include>
        <%            List<User> users = UserManager.getAllUsers();
        				int totalUsers = users.size();
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
            <h4>Users Ranking</h4><br>
            <jsp:include page="facebookShare.html"></jsp:include>
                <br/><br/>
                 <a href="winningBots.jsp">View Winning Bots</a>
                 <br/><br/>
            	<a href="uniqueBots.jsp">View Unique Bots</a>
                 <br/><br/>
                 
                 <h5>Total Number of Users Signed Up: <%=totalUsers%></h5>
                 
                <table class="table table-hover">
                    <tr>
                    	<th>Ranking #</th>
                        <th>User</th>
                        <th>ELO Rating</th>
                        <th>Number of Games Played</th>
                        <th>Trend</th>
                    </tr>
                <%
                    ArrayList<Score> list = new ArrayList<Score>();

					
                    for (User u : users) {
                        String ratingUsername = u.getUser();
                        Score ratingScore = ScoreManager.getScore(ratingUsername);

                        if (ratingScore != null) {
                            list.add(ratingScore);

                        }
                    }
                    Collections.sort(list, new Comparator<Score>() {
                       
                        public int compare(Score sc1, Score sc2) {

                            return sc1.getScore().compareTo(sc2.getScore());
                        }
                    });
                    
                    Collections.reverse(list);

					int c =1;
					
                    for (Score ratingScore : list) {
                        String ratingUsername = ratingScore.getUser();
                        Long userNumberOfGames = ratingScore.getNumberOfGames();
                        Long userScore = ratingScore.getScore();
                        c += 1;
                %>
                <tr>
                	<td><%=c%></td>
                    <td><%=ratingUsername%></td>
                    <td><%=userScore%></td>
                    <td><%=userNumberOfGames%></td>
                    <td><a href="chart.jsp?requestedUsername=<%=ratingUsername%>">View Trend</a></td>
                </tr>
                <% }
                %>
            </table>
            <br/>
           
        </div>
    </body>
</html>
