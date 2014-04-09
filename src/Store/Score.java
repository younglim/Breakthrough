/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package Store;

/**
 *
 * @author young
 */

import com.googlecode.objectify.annotation.Entity;
import com.googlecode.objectify.annotation.Id;
import java.util.Date;

@Entity
public class Score {
   
    @Id Long id;
    String username;
    Long score;
    Date date;
    Long numberOfGames;
    String opponent;
    int win;
    Long botCodeId;
    
    private Score() {}
    
    public Score(String username, String opponent, Long score, Long numberOfGames, int win, Long botCode) {
       this.username = username;
       this.opponent = opponent;
       this.score = score;
       this.date = new Date();
       this.numberOfGames = numberOfGames;
       this.win = win;
       this.botCodeId = botCode;
    }
    
    public String getUser() {
        return username;
    }
    
    public String getOpponent() {
        return opponent;
    }
    
    public Long getScore() {
        return score;
    }
    
    public void updateScore(Long score) {
        this.score = score;
    }
    
    public Date getDate() {
        return date;
    }
    
    public Long getNumberOfGames() {
        return numberOfGames;
    }
    
    public void updateNumberOfGames(Long numberOfGames) {
        this.numberOfGames = numberOfGames;
    }
    
    public String getWin() {
        if (win==1) {
            return "Winner";
        } else if (win==0) {
            return "Draw";
            
        } else return "Loser";
    }
    
    public int getWinInt() {
        return win;
    }
    
    public Long getBotCodeId() {
        return botCodeId;
    }
}
  
