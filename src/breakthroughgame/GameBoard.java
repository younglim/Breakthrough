/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package breakthroughgame;

import Verifier.Verify;
import Verifier.entity.GameResult;

/**
 *
 * @author muhammadmk.2012
 */
public class GameBoard {

    public String runGame(String board, char player, String botCodeB, String botCodeW, int tries) {
        BreakThroughGame btg = new BreakThroughGame();
        boolean check;
        boolean moveNotMade = true;
        Verify v = new Verify();
        GameResult result = null;
        int count = 0;

        if (player == 'x') {
            while (moveNotMade) {
                if (count == tries) {
                    break;
                }
                result = v.RunVerify("java", botCodeB, board, player);
                String botMove = result.getResult();
                if (botMove == null) {
                    return "Error: JavaServer is down please restart the instance.";
                } else if (result.getError()) {
                    return "Error: Code is not compilable. \n\nDetails:\n" + result.getResult();
                }
                check = btg.checkMove(botMove, player);
                if (check) { // check whether the code is valid
                    String outcome = btg.executePlay(board, player, botMove);
                    if (!outcome.contains("Error")) { // check whether the move is valid
                        return outcome;
                    }//check board
                }// check verifier
                count++;
            } //While loop
        } else if (player == 'y') {
            while (moveNotMade) {
                if (count == 100) {
                    break;
                }
                result = v.RunVerify("java", botCodeW, board, player);
                String botMove = result.getResult();
                check = btg.checkMove(botMove, player);
                if (check) { // check whether the code is valid
                    String outcome = btg.executePlay(board, player, botMove);
                    if (!outcome.contains("Error")) { // check whether the move is valid
                        return outcome;
                    }// check board
                }// check verifier
                count++;
            }// while loop
        }
       
            return "Error: Dumb Bot \nThe bot has exceeded the maximum number of tries to make a valid move.";

       
    }
    
    public String runGame(String board, char player, String botCodeB, String botCodeW) {
        return runGame(board, player, botCodeB, botCodeW, 100);
       
    }

    public boolean checkWin(String board) {
        BreakThroughGame btg = new BreakThroughGame();
        return btg.checkWin(board);
    }

    public String display(String boardCode) {

        //boardCode = "1wwwwwwww1,2wwwwwwww2,3________3,4________4,5________5,6________6,7bbbbbbbb7,8bbbbbbbb8";
       // System.out.println("Display: " + boardCode);

        String b = "<img src=\"images/b.png\" alt=\"black\" >";
        String w = "<img src=\"images/w.png\" alt=\"white\" >";
        String bk = "<img src=\"images/blank.png\" alt=\"blank\" >";

        String even = "<td class=\"success\">";
        String odd = "<td class=\"active\">";

        // remove ","
        boardCode = boardCode.replace(",", "");
        boardCode = boardCode.replace("12345678", "");
        boardCode = boardCode.replace(" ", "");

        boolean cellcolor = true;

        String output = "";
        output = output + "<div class=\"table-responsive\"> <table class=\"table table-bordered\" style=\"width: 400px\">";
        int counter = 0;
        for (int i = 1; i <= 8; i++) {
            output = output + "<tr>";
            for (int j = 1; j <= 10; j++) {

                char input = boardCode.charAt(counter);
                counter++;

                //display alternate color cell
                if (cellcolor) {
                    output = output + even;
                    cellcolor = false;
                    if (j == 10) {
                        cellcolor = true;
                    }
                } else {
                    output = output + odd;
                    cellcolor = true;
                    if (j == 10) {
                        cellcolor = false;
                    }

                }

                   // output = output +  "<p>" +  counter + input + "</p>";
                //input the black,white or blank image
                if (input == 'w') {
                    output = output + w;
                } else if (input == 'b') {
                    output = output + b;
                } else if (j == 10 || j == 1) {
                    output = output + "<p>" + input + "</p>";
                } else {
                    output = output + bk;
                }

                //close cell
                output = output + "</td>";

            }
            //close row
            output = output + "</tr>";
        }
        //close table
        output = output + " </table></div>";

        return output;

    }

}
