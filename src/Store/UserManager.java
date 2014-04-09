/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Store;

import com.googlecode.objectify.Key;
import com.googlecode.objectify.Objectify;
import com.googlecode.objectify.ObjectifyService;
import com.googlecode.objectify.Result;
import java.util.List;

/**
 *
 * @author young
 */
public class UserManager {

    static Objectify ofy = null;

    
    static {
        ObjectifyService.register(User.class);
        ofy = ObjectifyService.ofy();
    }

    //Method to add User with email, password, name, school, group, ksDollar.
    public static void addUser(String username, String password, String botCode) {
        User user = new User(username, password, botCode);
        ofy.save().entities(user).now();
        
        BotCodeManager.addBasicBotCode(username, "java");
    }

    public static void modifyUser(User modify) {
        ofy.save().entities(modify).now();
    }

    public static User getUser(String username) {
        Result<User> result = ofy.load().key(Key.create(User.class, username));  // Result is async
        User fetched1 = result.now();    // Materialize the async value
        return fetched1;
    }
    
    public static List<User> getAllUsers() {
        List<User> users = ofy.load().type(User.class).list();
        return users;
    }
   

}
