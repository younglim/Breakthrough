package Store;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class Register extends HttpServlet {

    public boolean isAlphaNumeric(String s) {
        String pattern = "^[a-zA-Z0-9]*$";
        if (s.matches(pattern)) {
            return true;
        }
        return false;
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        // get attributes from login.jsp (login page)
        String username = request.getParameter("newusername");
        String password = request.getParameter("newpassword");

        if (username == null || password == null || username.isEmpty() || password.isEmpty() || !isAlphaNumeric(username) || username.length() < 5 || username.length()>12 || password.length() < 6) {
            HttpSession session = request.getSession(true);
            RequestDispatcher view = request.getRequestDispatcher("login.jsp");

            request.setAttribute("registration_error", "Please ensure username is alphanumeric and at least 4 characters long, and Password is at least 6 characters long.");
            view.forward(request, response);
        } else {

            User user = UserManager.getUser(username);
            HttpSession session = request.getSession(true);
            RequestDispatcher view = request.getRequestDispatcher("login.jsp");

            if (user == null) {

                UserManager.addUser(username, password, "");
                session.setAttribute("current_userID", username);
                response.sendRedirect("index.jsp?username=" + username);
            } else {
                request.setAttribute("registration_error", "Please choose another username!");
                view.forward(request, response);
            } // end if-else
        }

    }
}
