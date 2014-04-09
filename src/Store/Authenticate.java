package Store;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class Authenticate extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        // get attributes from login.jsp (login page)
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        HttpSession session = request.getSession(true);
        RequestDispatcher view = request.getRequestDispatcher("login.jsp");

        if (username == null || password == null || username.isEmpty() || password.isEmpty()) {
            request.setAttribute("log_in_error", "Invalid username/password!");
            view.forward(request, response);
        }

        User user = UserManager.getUser(username);

        if (user != null && user.getPassword().equals(password)) {
            session.setAttribute("current_userID", username);
            response.sendRedirect("index.jsp?username=" + username);

        } else {
            request.setAttribute("log_in_error", "Invalid username/password!");
            view.forward(request, response);
        } // end if-else
    }
}
