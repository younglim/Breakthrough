/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package Verifier.entity;

import java.net.URLDecoder;
import java.util.List;

/**
 *
 * @author young
 */
public class Response {
    public String solved;
    public String printed;
    public String errors;
    
   
    public List<ResponseResults> results ;
            
    public String getSolved() {
        
        if (solved !=null)
        return solved; else
            return "";
    }
    
    public String getPrinted() {
         if (solved !=null)
        return printed;  else
            return "";
    }
    
    public List<ResponseResults> getResults() {
        return results;
    }
}
