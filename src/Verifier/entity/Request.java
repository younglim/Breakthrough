/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package Verifier.entity;

import java.net.URLEncoder;

/**
 *
 * @author young
 */
public class Request {
    public Request(String tests, String solution) {
        this.tests = tests;
        this.solution = solution;
    }
    String tests;
    String solution;
}
