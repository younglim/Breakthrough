/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Verifier;

import Verifier.entity.GameResult;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author muhammadmk.2012
 */
public class ProcessVerification extends HttpServlet {

  /**
   * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
   * methods.
   *
   * @param request servlet request
   * @param response servlet response
   * @throws ServletException if a servlet-specific error occurs
   * @throws IOException if an I/O error occurs
   */
  protected void processRequest(HttpServletRequest request, HttpServletResponse response)
          throws ServletException, IOException {
    response.setContentType("text/html;charset=UTF-8");
    try (PrintWriter out = response.getWriter()) {
      RequestDispatcher view = request.getRequestDispatcher("test.jsp");
      //String language = request.getParameter("language");
      //String board = request.getParameter("board");
      //String Splayer = request.getParameter("player");
      String board = " 12345678 ,1wwwwwwww1,2wwwwwwww2,3________3,4________4,5________5,6________6,7bbbbbbbb7,8bbbbbbbb8, 12345678 ";
      String Splayer = "b";
      char player = 0;
      if (Splayer != null) {
        player = Splayer.charAt(0);
      }

      String botCode = request.getParameter("botCode");

      Verify v = new Verify();
      GameResult result = v.RunVerify("java", botCode, board, player);

      String output = "";
      String validity = null;
      if (result.getError() == true) {
        output = "Code has error: <br/> " + result.getResult();
      } else {
        output = "Player's result: <br/> " + result.getResult();

        String verifiedResult = result.getResult();
        try {
          boolean isValid = true;
          String[] check = verifiedResult.split(",");
          int row = Integer.parseInt(check[0]);
          int col = Integer.parseInt(check[1]);
          char move = check[2].charAt(0);
          char Cplayer = check[3].charAt(0);
          if (!(row > 0 && row < 9)) {
            isValid = false;
          }
          if (!(col > 0 && col < 9)) {
            isValid = false;
          }
          if (!(move == 'l' || move == 'f' || move == 'r')) {
            isValid = false;
          }
          if (Cplayer != player) {
            isValid = false;
          }

          if (isValid) {
            validity = "SUCCESS!! You have a valid output";
          } else {
            validity = "Your output is NOT valid";
          }

        } catch (Exception e) {
          validity = "Your output has the wrong format. It has to be in a String: row, column, direction, player e.g. \"2,4,f,b\"";
        }

      }

      request.setAttribute("validity", validity);
      request.setAttribute("output", output);
      request.setAttribute("PrevCode", botCode);
      view.forward(request, response);

    }
  }

  // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
  /**
   * Handles the HTTP <code>GET</code> method.
   *
   * @param request servlet request
   * @param response servlet response
   * @throws ServletException if a servlet-specific error occurs
   * @throws IOException if an I/O error occurs
   */
  @Override
  protected void doGet(HttpServletRequest request, HttpServletResponse response)
          throws ServletException, IOException {
    processRequest(request, response);
  }

  /**
   * Handles the HTTP <code>POST</code> method.
   *
   * @param request servlet request
   * @param response servlet response
   * @throws ServletException if a servlet-specific error occurs
   * @throws IOException if an I/O error occurs
   */
  @Override
  protected void doPost(HttpServletRequest request, HttpServletResponse response)
          throws ServletException, IOException {
    processRequest(request, response);
  }

  /**
   * Returns a short description of the servlet.
   *
   * @return a String containing servlet description
   */
  @Override
  public String getServletInfo() {
    return "Short description";
  }// </editor-fold>

}
