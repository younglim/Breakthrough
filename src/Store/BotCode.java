/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Store;

import com.googlecode.objectify.annotation.Entity;
import com.googlecode.objectify.annotation.Id;
import java.util.Date;

/**
 *
 * @author young
 */

@Entity
public class BotCode {

    @Id Long id;
    String botCode;
    String language;
    String user;
    Date date;
    
    private Long tempScore;

    private BotCode() {
    }

    public BotCode(String user, String language, String botCode) {
        this.user = user;
        this.language = language;
        this.botCode = botCode;
        this.date = new Date();
    }

    public String getBotCode() {
        return botCode;
    }

    public String getLanguage() {
        return language;
    }

    public long getId() {
        return id;
    }

    public String getUser() {
        return user;
    }
    
    public Date getDate() {
        return date;
    }
    
    public void setTempScore(long score) {
        this.tempScore = score;
    }
    
    public Long getTempScore() {
        return this.tempScore;
    }
}
