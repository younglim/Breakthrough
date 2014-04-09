/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Store;

import com.googlecode.objectify.Objectify;
import com.googlecode.objectify.ObjectifyService;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.HashMap;
import java.util.Iterator;
import java.util.LinkedHashMap;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;

/**
 *
 * @author young
 */
public class ScoreManager {

    static Objectify ofy = null;

    static {
        ObjectifyService.register(Score.class);
        ofy = ObjectifyService.ofy();
    }

    //Method to add Score
    public static void addScore(String username, String opoonent, Long score, Long numGames, int win, Long botCodeId) {

        Score sc = new Score(username, opoonent, score, numGames, win, botCodeId);

        ofy.save().entities(sc).now();
    }

    public static void modifyScore(Score modify) {
        ofy.save().entities(modify).now();
    }

    public static void WinGame(String winnerUser, String loserUser, Long winUserBotCodeID, Long loseUserBotCodeID) {
        Score winner = getScore(winnerUser);
        Score loser = getScore(loserUser);

        if (winner == null) {
            winner = new Score(winnerUser, loserUser, 1200L, 0L, 0, 0L);

        }

        if (loser == null) {
            loser = new Score(loserUser, winnerUser, 1200L, 0L, 0, 0L);

        }

        Long previousScore = winner.getScore();
        Long newScore = ((previousScore * winner.getNumberOfGames()) + loser.getScore() + 400L) / (winner.getNumberOfGames() + 1);

        addScore(winnerUser, loserUser, newScore, winner.getNumberOfGames() + 1, 1, winUserBotCodeID);

        previousScore = loser.getScore();
        newScore = ((previousScore * loser.getNumberOfGames()) + winner.getScore() - 400L) / (loser.getNumberOfGames() + 1);

        addScore(loserUser, winnerUser, newScore, loser.getNumberOfGames() + 1, -1, loseUserBotCodeID);

    }

    public static void DrawGame(String player1, String player2, Long player1BotCodeID, Long player2BotCodeID) {
        Score user1 = getScore(player1);
        Score user2 = getScore(player2);

        if (user1 == null) {
            user1 = new Score(player1, player2, 1200L, 0L, 0, 0L);

        }

        if (user2 == null) {
            user2 = new Score(player2, player1, 1200L, 0L, 0, 0L);

        }

        Long previousScore = user1.getScore();
        Long newScore = ((previousScore * user1.getNumberOfGames()) + user2.getScore() + 200L) / (user1.getNumberOfGames() + 1);

        addScore(player1, player2, newScore, user1.getNumberOfGames() + 1, 1, player1BotCodeID);

        previousScore = user2.getScore();
        newScore = ((previousScore * user2.getNumberOfGames()) + user1.getScore() + 200L) / (user2.getNumberOfGames() + 1);

        addScore(player2, player1, newScore, user2.getNumberOfGames() + 1, -1, player2BotCodeID);

    }

    public static Score getScore(String user) {
        List<Score> scores = ofy.load().type(Score.class).list();
        Score latest = null;

        for (Score sc : scores) {
            if (sc.getUser().equals(user) && (latest == null || sc.getDate().after(latest.getDate()))) {
                latest = sc;
            }
        }

        return latest;
    }

    public static ArrayList<Score> getScoreArray(String user) {
        List<Score> scores = ofy.load().type(Score.class).list();
        ArrayList<Score> filtered = new ArrayList<Score>();

        for (Score sc : scores) {
            if (sc.getUser().equals(user)) {
                filtered.add(sc);
            }
        }

        Collections.sort(filtered, new Comparator<Score>() {
            @Override
            public int compare(Score sc1, Score sc2) {

                return sc1.getDate().compareTo(sc2.getDate());
            }
        });

        
        return filtered;
    }

    public static List<Score> getAllScores() {
        List<Score> users = ofy.load().type(Score.class).list();
        return users;
    }
    
   public static HashMap<Long,Long> getBestBotCodes() {
       
       List<Score> scores = getAllScores();
       HashMap<Long,Long> winningBots = new HashMap<Long,Long>();
       
       for (Score sc : scores) {
           if (sc.getWinInt()==1) {
                 Long botCodeId = sc.getBotCodeId();
          
                Long count = winningBots.get(botCodeId);
                if (count == null) {
                    winningBots.put(botCodeId, 1L);
                } else {
                    winningBots.put(botCodeId, count+1L);
                }
           }
        
        }
       
      HashMap<Long, Long> map = sortByValues(winningBots); 
       
    return map;   
   }
   
   private static HashMap sortByValues(HashMap map) { 
       List list = new LinkedList(map.entrySet());
       // Defined Custom Comparator here
       Collections.sort(list, new Comparator() {
            public int compare(Object o1, Object o2) {
               return ((Comparable) ((Map.Entry) (o1)).getValue())
                  .compareTo(((Map.Entry) (o2)).getValue());
            }
       });
       
       Collections.reverse(list);

       // Here I am copying the sorted list in HashMap
       // using LinkedHashMap to preserve the insertion order
       HashMap sortedHashMap = new LinkedHashMap();
       for (Iterator it = list.iterator(); it.hasNext();) {
              Map.Entry entry = (Map.Entry) it.next();
              sortedHashMap.put(entry.getKey(), entry.getValue());
       } 
       return sortedHashMap;
  }
   


}
