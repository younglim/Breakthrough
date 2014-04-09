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
        <%  String requestedUser = request.getParameter("requestedUsername");
            ArrayList<Score> scores = ScoreManager.getScoreArray(requestedUser);
            if (scores.size() > 0) {
                int win = 0;
                int draw = 0;
                int lose = 0;
        %>
        <title>ELO Rating of User : <%=requestedUser%></title>
        <script type="text/javascript" src="https://www.google.com/jsapi"></script>
        <script type="text/javascript">
            google.load("visualization", "1", {packages: ["corechart"]});
            google.setOnLoadCallback(drawChart);
            function drawChart() {
                var data = google.visualization.arrayToDataTable([
                    ['Year', 'ELO Rating'],
            <% for (Score sc : scores) {
                    if (sc.getWinInt() == 1) {
                        win += 1;
                    } else if (sc.getWinInt() == 0) {
                        draw += 1;
                    } else if (sc.getWinInt() == -1) {
                        lose += 1;
                    }
            %>
                    ['<%=sc.getDate()%>\n <%=sc.getWin()%>\n Opponent: <%=sc.getOpponent()%>', <%=sc.getScore()%>],
            <%
                }
            %>
                            ]);

                            var options = {
                                title: 'Rating of User <%=requestedUser%> over time'
                            };

                            var chart = new google.visualization.LineChart(document.getElementById('chart_div'));
                            chart.draw(data, options);
                        }
        </script>
        <script type="text/javascript">

            // Set a callback to run when the Google Visualization API is loaded.
            google.setOnLoadCallback(drawChart2);

            // Callback that creates and populates a data table,
            // instantiates the pie chart, passes in the data and
            // draws it.
            function drawChart2() {

                // Create the data table.
                var data = new google.visualization.DataTable();
                data.addColumn('string', 'Stats');
                data.addColumn('number', 'Numbers');
                data.addRows([
                    ['Wins', <%=win%>],
                    ['Loses', <%=lose%>],
                    ['Draws', <%=draw%>]
                ]);

                // Set chart options
                var options = {'title': 'Summary of Wins, Draws, Loses of User <%=requestedUser%>',
                    'width': 600,
                    'height': 500};

                // Instantiate and draw our chart, passing in some options.
                var chart2 = new google.visualization.PieChart(document.getElementById('chart_div2'));
                chart2.draw(data, options);
            }
        </script>
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

                <a href="leaderboard.jsp"><< Back to Leaderboard</a>
            </div>
        </div>
        <div id="chart_div" style="width: 900px; height: 500px;"></div>
        <div id="chart_div2" style="width: 900px; height: 500px;"></div>
        <%} else {%>
        <h4>User <%=requestedUser%> has not played any games.</h4>
        <%}%>
    </body>
</html>
