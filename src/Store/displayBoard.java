/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package Store;

/**
 *
 * @author guishi
 */

public class displayBoard {
    
    public String display(String boardCode){
        
        boardCode = "1wwwwwwww1,2wwwwwwww2,3________3,4________4,5________5,6________6,7bbbbbbbb7,8bbbbbbbb8";
          
        String b = "<img src=\"images/b.png\" alt=\"black\" >";
        String w = "<img src=\"images/w.png\" alt=\"white\" >";
        String bk = "<img src=\"images/blank.png\" alt=\"blank\" >";
        
        String even = "<td class=\"success\">";
        String odd = "<td class=\"active\">";
        
        // remove ","
        boardCode = boardCode.replace(",", "");
        boardCode = boardCode.replace("12345678", "");
        
        boolean cellcolor = true;
      
        String output = "";
        output = output + "<div class=\"table-responsive\"> <table class=\"table table-bordered\" style=\"width: 400px\">";
        int counter = 0;
        for(int i=1; i <= 8; i ++){
            output = output + "<tr>";
            for(int j=1; j<=10; j++){
   
                char input = boardCode.charAt(counter);             
                counter++;

                    //display alternate color cell
                    if(cellcolor){
                        output = output + even;
                        cellcolor = false;
                        if(j==10){
                            cellcolor = true;
                        }
                    }else{
                        output = output + odd;
                        cellcolor = true;
                        if(j==10){
                            cellcolor = false;
                        }
                        
                    }
                    
                   // output = output +  "<p>" +  counter + input + "</p>";
          
                    //input the black,white or blank image
                    if(input == 'w'){
                        output = output + w;
                    }else if(input == 'b'){
                        output = output + b;
                    }else if(j==10 || j==1){
                        output = output + "<p>" + input + "</p>";
                    }else{
                        output = output + bk;
                    }
                    
                    //close cell
                    output = output + "</td>";
                
            }
            //close row
            output = output + "</tr>";
        }
        //close table
        output = output + " </table></div>";
        
        return output;

    }
}
    
