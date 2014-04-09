/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package Verifier.entity;

/**
 *
 * @author young
 */
public class GameResult {
    boolean error;
    String result;
            
    public GameResult(boolean error, String result) {
        this.error = error;
        this.result = result;
    }
    
    public String getResult() {
        return result;
    }
    
    public boolean getError() {
        return error;
    }
    
    
}
