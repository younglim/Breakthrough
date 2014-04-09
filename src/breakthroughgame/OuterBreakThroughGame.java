/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package breakthroughgame;

import Verifier.Verify;
import Verifier.entity.GameResult;
import com.google.gson.JsonObject;
import java.util.*;
import java.util.logging.Level;
import java.util.logging.Logger;

public class OuterBreakThroughGame {

    public String board;
    public char player;
    public String botCode;
    private final String USER_AGENT = "Mozilla/5.0";
    JsonObject json = null;

    public static void main(String[] args) {
        OuterBreakThroughGame o = new OuterBreakThroughGame("This will be the board", 'w', "String playGame(String board, char player) {    Random rand = new Random();    int row = rand.nextInt(8) + 1;  int col = rand.nextInt(8) + 1;    int imove = rand.nextInt(2);   String move = null;    if (imove == 1) {      move = \"f\";    } else if (imove == 0) {      move = \"l\";    } else {      move = \"r\";    }    String AImove = row + \",\" + col + \",\" + move + \",\" + player;    return AImove;  }");

    }

    public OuterBreakThroughGame(String board, char player, String botCode) {
        this.board = board;
        this.player =player;
        this.botCode = botCode;

        Verify v = new Verify();
        GameResult result = null;
        
        try {

            /*
             String board ="board";
             String player ="white";
        
             public String play_game(board, player) {
             return player + " " + board;
             }
             */
            botCode = " String playGame(String board, char player) {Random rand = new Random();int row = rand.nextInt(9) + 1;int col = rand.nextInt(9) + 1;int imove = rand.nextInt(3);String move = null;if (imove == 1) {move = \"f\";} else if (imove == 0) {move = \"l\";} else {move = \"r\";}String AImove = row + \",\" + col + \",\" + move + \",\" + player;return AImove;}";

            result = v.RunVerify("java", botCode, board, player);
            
        } catch (Exception ex) {
            Logger.getLogger(OuterBreakThroughGame.class.getName()).log(Level.SEVERE, null, ex);
        }
        
        if ( result != null && result.getError() == false) {
            System.out.println("Returned from bot code : "+result.getResult());
        } else if (result != null) {
            System.out.println("Error in bot code : "+ result.getResult());
        } else {
            System.out.println("Something went wrong");
        }

    }
    
    String playGame(String board, char player) {

        Random rand = new Random();

        int row = rand.nextInt(8) + 1;
        int col = rand.nextInt(8) + 1;
        int imove = rand.nextInt(3);
        String move = null;

        if (imove == 1) {
            move = "f";
        } else if (imove == 0) {
            move = "l";
        } else {
            move = "r";
        }

        String AImove = row + "," + col + "," + move + "," + player;

        return AImove;

    }
}
