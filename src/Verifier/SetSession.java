/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Verifier;

import Store.BotCode;
import Store.BotCodeManager;
import breakthroughgame.CurrentGame;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.ObjectOutputStream;
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
public class SetSession extends HttpServlet {

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
      /* TODO output your page here. You may use following sample code. */
      //RequestDispatcher view = request.getRequestDispatcher("GameStatus.jsp");
      RequestDispatcher view = request.getRequestDispatcher("GameStatus.jsp");
      //String language = request.getParameter("language");
      HttpSession session = request.getSession();
      
      
      BotCode black = BotCodeManager.getBotCodeById(Long.parseLong(request.getParameter("botCodeDDL2")));
      BotCode white = BotCodeManager.getBotCodeById(Long.parseLong(request.getParameter("botCodeDDL")));
        
      String board= " 12345678 ,1wwwwwwww1,2wwwwwwww2,3________3,4________4,5________5,6________6,7bbbbbbbb7,8bbbbbbbb8, 12345678 ";
     
      String Splayer = (String) "w";
      String botCodeB = (String) black.getBotCode();
      String botCodeW = (String) white.getBotCode();
      String userB = (String) black.getUser();
      String userW = (String) white.getUser();
      String status = (String) request.getParameter("status");
      /*
      System.out.println(board);
      System.out.println(Splayer);
      System.out.println(botCodeB);
      System.out.println(botCodeW);
      System.out.println(userB);
      System.out.println(userW);
      System.out.println(status);
      */
      //setting the session.
      CurrentGame cg = new CurrentGame();
      cg.setBoard(board);
      cg.setBotCodeB(botCodeB);
      cg.setBotCodeW(botCodeW);
      cg.setPlayer(Splayer.charAt(0));
      cg.setUserB(userB);
      cg.setUserW(userW);
      
      cg.setUserWBotCodeId(white.getId());
      cg.setUserBBotCodeId(black.getId());
      
      if (status == null) {
        cg.setStatus("No status Yet");
      } else {
        cg.setStatus(status);
      }

      session.removeAttribute("currentGame");
      session.setAttribute("currentGame", cg);
      //view.forward(request, response);
      response.sendRedirect("GameStatus.jsp");
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
