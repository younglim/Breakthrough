<%@page import="Store.*"%>

<%
    //Force Browser to invoke the server rather than displaying the cached page
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Cache-Control", "no-store");
    response.setHeader("Pragma", "no-cache");
    response.setDateHeader("Expires", 0);

    String username = (String) session.getAttribute("current_userID");
    if (username == null) {
        RequestDispatcher rd = request.getRequestDispatcher("login.jsp");
        rd.forward(request, response);
        return;
    }
    User user = UserManager.getUser(username);

    if (username == null || user == null) {
        RequestDispatcher rd = request.getRequestDispatcher("login.jsp");
        rd.forward(request, response);
        return;
    }
%>
