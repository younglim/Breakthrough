/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package breakthroughgame;

import java.io.Serializable;

/**
 *
 * @author muhammadmk.2012
 */
public class CurrentGame implements Serializable {

    String board;
    char player;
    String botCodeB;
    String botCodeW;
    String userB;
    String userW;
    String status;
    int steps;
    long userBBotCodeID;
    long userWBotCodeID;

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public int getSteps() {
        return steps;
    }

    public void setSteps(int steps) {
        this.steps = steps;
    }

    public String getBoard() {
        return board;
    }

    public void setBoard(String board) {
        this.board = board;
    }

    public char getPlayer() {
        return player;
    }

    public void setPlayer(char player) {
        this.player = player;
    }

    public String getBotCodeB() {
        return botCodeB;
    }

    public void setBotCodeB(String botCodeB) {
        this.botCodeB = botCodeB;
    }

    public String getBotCodeW() {
        return botCodeW;
    }

    public void setBotCodeW(String botCodeW) {
        this.botCodeW = botCodeW;
    }

    public String getUserB() {
        return userB;
    }

    public void setUserB(String userB) {
        this.userB = userB;
    }

    public String getUserW() {
        return userW;
    }

    public void setUserW(String userW) {
        this.userW = userW;
    }

    public void setUserWBotCodeId(Long codeId) {
        this.userWBotCodeID = codeId;
    }

    public void setUserBBotCodeId(Long codeId) {
        this.userBBotCodeID = codeId;
    }

    public Long getUserWBotCodeId() {
        return userWBotCodeID;

    }

    public Long getUserBBotCodeId() {
        return userBBotCodeID;

    }
}
