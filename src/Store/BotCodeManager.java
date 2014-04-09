/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Store;

import com.googlecode.objectify.Objectify;
import com.googlecode.objectify.ObjectifyService;
import com.googlecode.objectify.cmd.Query;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.List;

/**
 *
 * @author young
 */
public class BotCodeManager {

    static final String basicBot
            = "String playGame(String board, char player) { \n"
            + "	Random rand = new Random();\n"
            + "\n"
            + "	int row = rand.nextInt(8) + 1;\n"
            + "	int col = rand.nextInt(8) + 1;\n"
            + "	int imove = rand.nextInt(3);\n"
            + "\n"
            + "	char move;\n"
            + "\n"
            + "	if (imove == 1) {\n"
            + "		move = 'f';\n"
            + "	} else if (imove == 0) {\n"
            + "		move = 'l';\n"
            + "	} else {\n"
            + "		move = 'r';\n"
            + "	}\n"
            + "\n"
            + "	String AImove = row + \",\" + col + \",\" + move + \",\" + player; \n"
            + "	return AImove;\n"
            + "}";

    static Objectify ofy = null;

    static {
        ObjectifyService.register(BotCode.class);
        ofy = ObjectifyService.ofy();
    }

    //Method to add BotCode
    public static void addBotCode(String user, String language, String botCode) {
        BotCode bCode = new BotCode(user, language, botCode);
        ofy.save().entities(bCode).now();
    }

    public static void addBasicBotCode(String user, String language) {
        BotCode bCode = new BotCode(user, language, basicBot);
        ofy.save().entities(bCode).now();
    }

    public static void modifyBotCode(BotCode modify) {
        ofy.save().entities(modify).now();
    }

    public static BotCode getBotCode(String user) {
        List<BotCode> botCodes = ofy.load().type(BotCode.class).list();
        BotCode latest = null;
        for (BotCode bc : botCodes) {
            if (bc.getUser().equals(user)) {
                latest = bc;
            }
        }

        return latest;
    }

    public static BotCode getBotCodeById(Long id) {
        return ofy.load().type(BotCode.class).filter("id", id).first().now();

    }

    public static List<BotCode> getAllBotCodes() {
        List<BotCode> botCodes = ofy.load().type(BotCode.class).list();

        Collections.sort(botCodes, new Comparator<BotCode>() {
            @Override
            public int compare(BotCode sc1, BotCode sc2) {

                return sc1.getDate().compareTo(sc2.getDate());
            }
        });

        Collections.reverse(botCodes);

        return botCodes;
    }

    public static List<BotCode> getAllBotCodesUser(String user) {
        List<BotCode> botCodes = getAllBotCodes();
        List<BotCode> filtered = new ArrayList<BotCode>();

        for (BotCode botCode : botCodes) {
            if (botCode.getUser().equals(user)) {
                filtered.add(botCode);
            }

        }

        return filtered;
    }

    public static List<BotCode> getAllBotCodeOpponentTo(String user) {
        List<BotCode> botCodes = getAllBotCodes();
        List<BotCode> filtered = new ArrayList<BotCode>();

        for (BotCode botCode : botCodes) {
            if (!botCode.getUser().equals(user)) {
                filtered.add(botCode);
            }

        }

        return filtered;
    }

    public static String getBasicBot() {
        return basicBot;
    }

    public static List<BotCode> getTopTen(String opponentToUser) {
        List<BotCode> returnedList =new ArrayList<BotCode>();
        
        List<User> users = UserManager.getAllUsers();
        ArrayList<Score> list = new ArrayList<Score>();

        for (User u : users) {
            String ratingUsername = u.getUser();
            Score ratingScore = ScoreManager.getScore(ratingUsername);

            if (ratingScore != null) {
                list.add(ratingScore);

            }
        }
        Collections.sort(list, new Comparator<Score>() {

            public int compare(Score sc1, Score sc2) {

                return sc1.getScore().compareTo(sc2.getScore());
            }
        });

        Collections.reverse(list);

       
        int count = 0;

        for (Score sc : list) {

            if (!sc.getUser().equals(opponentToUser)) {
               
                BotCode bc = BotCodeManager.getBotCode(sc.getUser());
                bc.setTempScore(sc.getScore());
                
                returnedList.add(bc);
                count += 1;

                if (count == 10) {
                    break;
                }
            }

        }

        if (returnedList.isEmpty()) {
            return getAllBotCodeOpponentTo(opponentToUser);
            
        }
        
        return returnedList;
    }

    public static List<BotCode> getTop() {
        List<BotCode> returnedList =new ArrayList<BotCode>();
        
        List<User> users = UserManager.getAllUsers();
        ArrayList<Score> list = new ArrayList<Score>();

        for (User u : users) {
            String ratingUsername = u.getUser();
            Score ratingScore = ScoreManager.getScore(ratingUsername);

            if (ratingScore != null) {
                list.add(ratingScore);

            }
        }
        Collections.sort(list, new Comparator<Score>() {

            public int compare(Score sc1, Score sc2) {

                return sc1.getScore().compareTo(sc2.getScore());
            }
        });

        Collections.reverse(list);
        
        for (Score sc : list) {

                BotCode bc = BotCodeManager.getBotCode(sc.getUser());
                bc.setTempScore(sc.getScore());
                
                returnedList.add(bc);
                

        }

        if (returnedList.isEmpty()) {
            return getAllBotCodes();
            
        }
        
        return returnedList;
    }

}
