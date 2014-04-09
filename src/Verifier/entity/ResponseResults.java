/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package Verifier.entity;

import java.net.URLDecoder;

/**
 *
 * @author young
 */
public class ResponseResults {
    public String call;
    public String correct;
    public String received;
    
    public ResponseResults() {
        call ="";
        correct ="";
        received="";
    }
    
    public String getReceived() {
        return received;
    }
    public String getCall() {
        return call;
    }
    
    public String getCorrect() {
        return correct;
    }
}
