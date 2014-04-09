/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Verifier;

import Verifier.entity.GameResult;
import Verifier.entity.Request;
import Verifier.entity.Response;
import Verifier.entity.VerifierError;
import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.google.gson.JsonParseException;
import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.net.URL;
import java.net.URLConnection;
import java.net.URLEncoder;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author young
 */
public class Verify {

  public Object Verify(String language, Request r) {
    Gson gson = new GsonBuilder().serializeNulls().create();
    String message = gson.toJson(r);
    String result = "";
    //System.out.println("initial message:" + message);

    try {

      message = URLEncoder.encode(message);
            //System.out.println("encoded message:" + message);
      // String message = URLEncoder.encode("");
      String urlParameters = "jsonrequest=" + message;

      //System.out.println("Sending to Server: " + urlParameters);
      URL url = new URL("http://162.222.183.53/" + language);
      URLConnection conn = url.openConnection();

      conn.setDoOutput(true);

      OutputStreamWriter writer = new OutputStreamWriter(conn.getOutputStream());

      writer.write(urlParameters);
      writer.flush();

      String line;
      BufferedReader reader = new BufferedReader(new InputStreamReader(conn.getInputStream()));

      while ((line = reader.readLine()) != null) {
        result = line;
      }

      writer.close();
      reader.close();
     // Thread.sleep(1000);

      //System.out.println("result from server: " + result);

      Response res = gson.fromJson(result, Response.class);

      if (res.printed == null) {

    //    System.out.println("errors found123");
        VerifierError error = gson.fromJson(result, VerifierError.class);
        return error;
      } else {
        return res;
      }
    } catch (JsonParseException e) {
      // Do your Error handling
      VerifierError error = new VerifierError();
      error.setErrors("Unexpected error");
      return error;

    } catch (IOException ex) {
      VerifierError error = new VerifierError();
      error.setErrors("Could not connect to verifier service.");
      return error;

    }

  }

  public GameResult RunVerify(String language, String botCode, String board, char player) {
    // Bot's Code
    String helper = "public char[][] toCharArray(String Sboard) { char[][] returnchar = new char[10]\n" +
"[10];String[] rowStr = Sboard.split(\",\");for (int i = 0; i < rowStr.length; i++) {char\n" +
"[] colchar = rowStr[i].toCharArray();for (int j = 0; j < colchar.length; j++) \n" +
"{returnchar[i][j] = colchar[j];}}return returnchar;}public boolean isMoveValid(String \n" +
"Sboard, char CurrentPlayer, String botMove) {String[] moveList = botMove.split(\",\");int \n" +
"row = Integer.parseInt(moveList[0]);int col = Integer.parseInt(moveList[1]);char move = \n" +
"moveList[2].charAt(0);char player = moveList[3].charAt(0);if (player != CurrentPlayer) \n" +
"{ return false; }System.out.println(Sboard); char[][] board = toCharArray(Sboard);if \n" +
"(player == 'w') {if (board[row][col] == 'w') {if (move == 'f' && board[row + 1][col] == \n" +
"'b') { return false; }switch (move) {case 'f':if (board[row + 1][col] != 'w') {board\n" +
"[row + 1][col] = 'w'; board[row][col] = '_';return true; }return false;case 'r':if \n" +
"((board[row + 1][col - 1] == '_' || board[row + 1][col - 1] == 'b') && board[row + 1]\n" +
"[col - 1] != 'w') { board[row + 1][col - 1] = 'w';board[row][col] = '_'; return true; } \n" +
"return false; case 'l': if ((board[row + 1][col + 1] == '_' || board[row + 1][col + 1] \n" +
"== 'b') && board[row + 1][col + 1] != 'w') { board[row + 1][col + 1] = 'w';board[row]\n" +
"[col] = '_'; return true; } return false;}} else { return false;} } else if (player == \n" +
"'b') {if (board[row][col] == 'b') {if (move == 'f' && board[row - 1][col] == 'w') { \n" +
"return false; } switch (move) {case 'f': if (board[row - 1][col] != 'b') { board[row - \n" +
"1][col] = 'b'; board[row][col] = '_'; return true; } return false; case 'r':if ((board\n" +
"[row - 1][col + 1] == '_' || board[row - 1][col + 1] == 'w') && board[row - 1][col + 1] \n" +
"!= 'b') { board[row - 1][col + 1] = 'b'; board[row][col] = '_'; return true;} return \n" +
"false;case 'l':if ((board[row - 1][col - 1] == '_' || board[row - 1][col - 1] == 'w') \n" +
"&& board[row - 1][col - 1] != 'b') { board[row - 1][col - 1] = 'b'; board[row][col] = \n" +
"'_'; return true; } return false; }} else { return false; } } return false;}";
    
    String solution = helper + botCode;

    String tests = "assertEquals(\"ANYTHING\",playGame(\"" + board + "\",'" + player + "'));";

    Verify v = new Verify();
    Object res = v.Verify("java", new Request(tests, solution));

    String result = "";

    boolean error = false;
    if (res instanceof Response) {
      result = ((Response) res).getResults().get(0).getReceived();
     // System.out.println("result from value: " + result);

    } else {
      VerifierError e = (VerifierError) res;
      result = e.getErrors();
      error = true;
    }
    if (result != null) {
      if (result.charAt(0) == '[' && result.charAt(result.length() - 1) == ']') {
        result = result.substring(1, result.length() - 1);
      }
    }

    return new GameResult(error, result);
  }
}
