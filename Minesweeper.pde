

import de.bezier.guido.*;
public static int NUM_ROWS = 20;
public static int NUM_COLS = 20;
public static int BOMBS = 30;
//Declare and initialize NUM_ROWS and NUM_COLS = 20
private MSButton[][] buttons; //2d array of minesweeper buttons
private ArrayList <MSButton> bombs = new ArrayList <MSButton>(); //ArrayList of just the minesweeper buttons that are mined
void setup ()
{
    size(400, 400);
    textAlign(CENTER,CENTER);
    // make the manager
    Interactive.make( this );
    buttons = new MSButton[NUM_ROWS][NUM_COLS];
    //your code to declare and initialize buttons goes here
    for(int i = 0;i<NUM_COLS;i++)
    {
        for(int j = 0; j < NUM_ROWS;j++)
            buttons[j][i]= new MSButton(j,i);
    }
    setBombs();
}
public void setBombs()
{
    int rows = (int)(Math.random()*NUM_ROWS);
    int cols = (int)(Math.random()*NUM_COLS);
    int b = 0;
    while(b<BOMBS)//your code
    {
        if(!bombs.contains(buttons[rows][cols]))
            {
                bombs.add(buttons[rows][cols]);
                rows = (int)(Math.random()*NUM_ROWS);
                cols = (int)(Math.random()*NUM_COLS);
                b++;
            }
        else
        {
            rows = (int)(Math.random()*NUM_ROWS);
            cols = (int)(Math.random()*NUM_COLS); 
        }    
    }
    System.out.println(bombs.size());
}

public void draw ()
{
    background( 0 );
    if(isWon())
        displayWinningMessage();
}
public boolean isWon()
{
    //your code here
    return false;
}
public void displayLosingMessage()
{
    //your code here
}
public void displayWinningMessage()
{
    //your code here
}

public class MSButton
{
    private int r, c;
    private float x,y, width, height;
    private boolean clicked, marked;
    private String label;
    
    public MSButton ( int rr, int cc )
    {
        width = 400/NUM_COLS;
        height = 400/NUM_ROWS;
        r = rr;
        c = cc; 
        x = c*width;
        y = r*height;
        label = "";
        marked = clicked = false;
        Interactive.add( this ); // register it with the manager
    }
    public boolean isMarked()
    {
        return marked;
    }
    public boolean isClicked()
    {
        return clicked;
    }
    // called by manager
    
    public void mousePressed () 
    {
        clicked = true;
        String myString = new String();
        if(countBombs(r,c)>0)
        {
            setLabel(myString + countBombs(r,c));//your code here
        }
        else{
            setLabel(myString); 
        }
    }

    public void draw () 
    {    
        if (marked)
            fill(0);
        else if(clicked && bombs.contains(this)) 
            fill(255,0,0);
        else if(clicked)
            fill( 200 );
        else 
            fill( 100 );

        rect(x, y, width, height);
        fill(0);
        text(label,x+width/2,y+height/2);
    }
    public void setLabel(String newLabel)
    {
        label = newLabel;
    }
    public boolean isValid(int r, int c)
    {
        if(r<NUM_ROWS && c < NUM_COLS && r >=0 && c >=0)
            return true;//your code here
        return false;
    }
    public int countBombs(int row, int col)
    {
        int numBombs = 0;
        for(int i = row-1;i<row+2;i++)
        {
            for(int j = col-1;j<col+2;j++)
            {
                if(bombs.contains(buttons[i][j])==true && isValid(i,j)==true)
                    numBombs++;
                }
            }   //your code here
        }
        return numBombs;
    }
}



