<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8">
        <title>Breakthrough - Login</title>
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
            .container-narrow {
                margin: 3% auto 0 auto;
                max-width: 800px;
            }
        </style>
        
        <jsp:include page="analytics.jsp"></jsp:include>
        
    </head>

    <body>
        <div class="navbar navbar-inverse navbar-fixed-top" role="navigation">
            <div class="container" >
                <div class="navbar-header">
                    <a class="navbar-brand" href="/">IS429 :: Breakthrough</a>
                </div>
            </div>
        </div>
        <div class="container-narrow">
            <div class="introduction">
                <jsp:include page="introLogin.jsp"></jsp:include>
                </div>

                <jsp:include page="facebookShare.html"></jsp:include>
                <div style="width: 400px; height:auto; float:left; padding:0 50px">
                    <h4 align="center">New User Registration</h4><br>
                    <form class="form" id="form" action="Register" method="post">
                        <div class="row form-group">
                            Username:<input class="form-control" name='newusername' type="text" style="width: 300px"/><br>
                            Password:<input class="form-control" name='newpassword' type='password' style="width: 300px"/><br>
                        <%
                            String registrationError = (String) request.getAttribute("registration_error");
                            if (registrationError != null) {
                                out.println("<p style='color:red'>");
                                out.println(registrationError);
                                out.println("</p>");
                            }
                            request.removeAttribute("registration_error");
                        %>
                        <button id="registration-btn" class="btn btn-success">Register</button>
                    </div>
                </form>
            </div>
            <div style="border-left:1px solid #eeeeee; width: 400px; height:auto; float:left; padding:0 50px">
                <h4 align="center">User Login</h4><br>
                <form class="form" id="form" action="Authenticate" method="post">
                    <div class="row form-group">
                        Username:<input class="form-control" name='username' type="text" style="width: 300px"/><br>
                        Password:<input class="form-control" name='password' type='password' style="width: 300px"/><br>
                        <%
                            String loginError = (String) request.getAttribute("log_in_error");
                            if (loginError != null) {
                                out.println("<p style='color:red'>");
                                out.println(loginError);
                                out.println("</p>");
                            }
                            request.removeAttribute("log_in_error");
                        %>
                        <button id="registration-btn" class="btn btn-success">Login</button>
                    </div>
                </form>
            </div><br><br>      
        </div><!-- /.container -->    
    </body>
</html>
