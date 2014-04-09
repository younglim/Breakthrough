<div class="alert alert-info alert-dismissable" style="margin-top:25px">
    <button onclick="$(this).parent('div').hide();" type="button" class="close" data-dismiss="alert" aria-hidden="true">&times;</button>
    <h4><b>Introduction to Breakthrough</b></h4>
    <p>Breakthrough is a game played on an 8x8 chessboard. Two rows of <b>WHITE</b> pieces on top and two rows of <b>BLACK</b> pieces below. Pieces can move one step forward or diagonally at a time. <b>WHITE</b> pieces move down while <b>BLACK</b> pieces move up the board. Only one piece is permitted on a square at a time. Capture your opponent's pieces diagonally. The winner is the first player to advance one of its pieces to the opposite end of the board.</p><br>

    <h4><b>How to Play</b></h4>
    <p>An empty <code>board</code> is represented by the string <code>" 12345678 ,1wwwwwwww1,2wwwwwwww2,3________3,4________4,5________5,6________6,7bbbbbbbb7,8bbbbbbbb8, 12345678 "</code> (excluding quotation marks, including spaces), every part separated by the comma represents one row of the board.</p>
    <p>Create a brand new bot or improve someone else's bot with a <code>String playGame(board, player)</code> function to determine the next <code>move</code> on the current board.
        <br/> (Parameter #1, with default name '<code>board</code>') and your player mark ('<code>b</code>' or '<code>w</code>')(Parameter #2, with default name '<code>player</code>').
        <br/>Return the <code>AImove</code>, as a <code>String</code> object, with the format <code>"row,col,move,player"</code> (excluding quotation marks) where <code>row</code> and <code>col</code> is the coordinates of the piece to-be-moved (1 to 8), <code>move</code> is the direction as a single character: <code>l</code> (left) , <code>f</code> (front), <code>r</code> (right) and <code>player</code> is your current player ('b' or 'w'). Example: <code>"7,1,f,b"</code> (excluding quotation marks) moves piece at (7,1) forward.
        <br/>
        Note: your code should work for both sides of the board.
        <br/><br/>

    <h4><b><font color="red">New: </font> Helper Methods</b></h4>
  
    <ul>
        <li>Convert <code>board</code> String object to char Array representation of board: <code>char[][] boardArray = toCharArray(board);</code><br/></li>
        <li>Check if a move is valid: <code>boolean moveValid = isMoveValid(board, player, AImove);</code> where 
            <ul>
                <li><code>board</code> is a <code>String</code></li>
                <li><code>player</code> is a <code>char</code> of either '<code>b</code>' or '<code>w</code>'</li>
                <li><code>AImove</code> is a <code>String</code> of <code>row,col,move,player</code>.</li>
            </ul>
        </li>
    </ul>
    

    <p><br/>Once you have selected your opponent bot and improved your's, hit the "<b>Play</b>" button to watch each steps taken.</p><br>
    <p><i>P.S. Currently, only Java is supported, more language options will be added soon.</i></p>
</div>