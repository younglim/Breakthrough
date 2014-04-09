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

@Entity
public class User {
   
    @Id String username;
    String password;
  
    private User() {}
    
    public User(String username, String password, String botCode) {
        this.username = username;
        this.password = password;
        
        if (!botCode.isEmpty()) {
            BotCodeManager.addBotCode(username,"java", botCode);
       
        }
         
    }
    
    public String getUser() {
        return username;
    }
    
    public String getPassword() {
        return password;
    }
    
    public String getBotCode() {
        return BotCodeManager.getBotCode(this.username).getBotCode();
    }
    
    public void setBotCode(String language, String newBotCode) {
        BotCodeManager.addBotCode(this.username, language, newBotCode);
    }
    
    public void setBotCode(String botCode) {
        setBotCode("java",botCode);
    }
    
}
  
