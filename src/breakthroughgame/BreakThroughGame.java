/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package breakthroughgame;

/**
 *
 * @author muhammadmk.2012
 */
import java.util.Scanner;
import java.util.Random;

public class BreakThroughGame {

  //Random rand = new Random();
  public String createNewGame() {
    char[][] board = new char[][]{{' ', '1', '2', '3', '4', '5', '6', '7', '8', ' '},
    {'1', 'w', 'w', 'w', 'w', 'w', 'w', 'w', 'w', '1'},
    {'2', 'w', 'w', 'w', 'w', 'w', 'w', 'w', 'w', '2'},
    {'3', '_', '_', '_', '_', '_', '_', '_', '_', '3'},
    {'4', '_', '_', '_', '_', '_', '_', '_', '_', '4'},
    {'5', '_', '_', '_', '_', '_', '_', '_', '_', '5'},
    {'6', '_', '_', '_', '_', '_', '_', '_', '_', '6'},
    {'7', 'b', 'b', 'b', 'b', 'b', 'b', 'b', 'b', '7'},
    {'8', 'b', 'b', 'b', 'b', 'b', 'b', 'b', 'b', '8'},
    {' ', '1', '2', '3', '4', '5', '6', '7', '8', ' '}};

    return boardToString(board);
  }

  public boolean checkMove(String input, char player) {
    boolean isValid = true;
    if (input.length() > 8) { //check to see whether it passed the verifier or not
      return false;
    }

    try {
      String[] check = input.split(",");
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

    } catch (Exception e) {
      isValid = false;
    }
    return isValid;
  }

  public String executePlay(String Sboard, char CurrentPlayer, String botMove) {

    String[] moveList = botMove.split(",");
    int row = Integer.parseInt(moveList[0]);
    int col = Integer.parseInt(moveList[1]);
    char move = moveList[2].charAt(0);
    char player = moveList[3].charAt(0);

    if (player != CurrentPlayer) {
      return "Error: Not the correct player";
    }
    //System.out.println(Sboard);
    char[][] board = toCharArray(Sboard);

    if (player == 'w') {
      if (board[row][col] == 'w') {
        if (move == 'f' && board[row + 1][col] == 'b') {
          //System.out.println("Can't move there, try again");
          return "Error: Can't attack here";
        }
        switch (move) {
          case 'f':
            if (board[row + 1][col] != 'w') {
              board[row + 1][col] = 'w';
              board[row][col] = '_';
              return boardToString(board);
            }
            return "Error: Can't move here";
          case 'r':
            if ((board[row + 1][col - 1] == '_' || board[row + 1][col - 1] == 'b') && board[row + 1][col - 1] != 'w') {
              board[row + 1][col - 1] = 'w';
              board[row][col] = '_';
              return boardToString(board);
            }
            //System.out.println("Can't move there, try again");
            return "Error: Can't move here";
          case 'l':
            if ((board[row + 1][col + 1] == '_' || board[row + 1][col + 1] == 'b') && board[row + 1][col + 1] != 'w') {
              board[row + 1][col + 1] = 'w';
              board[row][col] = '_';
              return boardToString(board);
            }
            //System.out.println("Can't move there, try again");
            return "Error: Can't move here";
        }
      } else {
        //System.out.println("Invalid position, try again");
        return "Error: Invalid position";
      }
    } else if (player == 'b') {

      if (board[row][col] == 'b') {
        if (move == 'f' && board[row - 1][col] == 'w') {
          //System.out.println("Can't move there, try again");
          return "Error: Can't attack here";
        }
        switch (move) {
          case 'f':
            if (board[row - 1][col] != 'b') {
              board[row - 1][col] = 'b';
              board[row][col] = '_';
              return boardToString(board);
            }
            return "Error: Can't move here";
          case 'r':
            if ((board[row - 1][col + 1] == '_' || board[row - 1][col + 1] == 'w') && board[row - 1][col + 1] != 'b') {
              board[row - 1][col + 1] = 'b';
              board[row][col] = '_';
              return boardToString(board);
            }
            //System.out.println("Can't move there, try again");
            return "Error: Can't move here";
          case 'l':
            if ((board[row - 1][col - 1] == '_' || board[row - 1][col - 1] == 'w') && board[row - 1][col - 1] != 'b') {
              board[row - 1][col - 1] = 'b';
              board[row][col] = '_';
              return boardToString(board);
            }
            //System.out.println("Can't move there, try again");
            return "Error: Can't move here";
        }
      } else {
        //System.out.println("Invalid position, try again");
        return "Error: Invalid position";
      }

    }

    return "Error: Da Heck happened?!";

  }

  public String boardToString(char[][] board) {
    String boardStr = "";
    for (int i = 0; i < board.length; i++) {
      for (int j = 0; j < board[i].length; j++) {
        boardStr += board[i][j];
      }
      if (i != board.length - 1) {
        boardStr += ",";
      }

    }
    return boardStr;
  }

  public char[][] toCharArray(String boardstr) {
    char[][] returnchar = new char[10][10];
    String[] rowStr = boardstr.split(",");
    for (int i = 0; i < rowStr.length; i++) {
      char[] colchar = rowStr[i].toCharArray();
      for (int j = 0; j < colchar.length; j++) {
        returnchar[i][j] = colchar[j];
      }
    }
    return returnchar;
  }

  public boolean checkWin(String Sboard) {
    //code goes here

    char[][] board = toCharArray(Sboard);

    for (int i = 1; i < board[1].length; i++) {
      char checkWside = board[1][i];
      char checkBside = board[8][i];
      if (checkWside == 'b') { //black wins
        return true;
      } else if (checkBside == 'w') { //white wins
        return true;
      }
    }
    if (!Sboard.contains("b")) {
      return true;
    }
    if (!Sboard.contains("w")) {
      return true;
    }
    return false;
  }

  public void printBoard(char[][] board) {
    for (int row = 0; row <= 9; row++) {
      for (int column = 0; column <= 9; column++) {
        System.out.print(board[row][column] + " ");
      }
      System.out.println();
    }

    System.out.println(boardToString(board));

  }

  /*
   public static void main(String[] args) {
   Scanner in = new Scanner(System.in);
   BreakThroughGame obj = new BreakThroughGame();
   boolean gameover = true;

   do {
   obj.printBoard();
   System.out.println("Enter row position");
   int row = in.nextInt();
   System.out.println("Enter column position");
   int col = in.nextInt();
   System.out.println("Enter move direction");
   String move = in.next();

   boolean x = obj.userMove(row, col, move);
   System.out.println(x);
   if (obj.checkWin()) {
   obj.printBoard();
   System.out.println("YOU HAVE WON!!!! CONGRATULATIONS!");
   gameover = false;
   }

   if (x) {
   boolean executeAI;
   do {
   executeAI = obj.playGame();
   } while (executeAI == false);
   }

   } while (gameover);
   }
   */
}
