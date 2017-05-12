

import de.bezier.guido.*;
public static int NUM_ROWS = 20;
public static int NUM_COLS = 20;
public static int BOMBS = 75;
public boolean firstClick = true;
public boolean youSuck = false;
public boolean youGreat = false;
//Declare and initialize NUM_ROWS and NUM_COLS = 20
private MSButton[][] buttons; //2d array of minesweeper buttons
private String[] lost = {"","y","o","u","","l","o","s","e"," "};
private String[] won = {"","y","o","u","","w","i","n"," ",""};
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
}
public void setBombs()
{
    int rows = (int)(Math.random()*NUM_ROWS);
    int cols = (int)(Math.random()*NUM_COLS);
    int b = bombs.size();
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
}
public void clearBombs(int row, int col)
{
    for(int r=-1;r<2;r++)
    {
        for(int c=-1;c<2;c++)
        {
            bombs.remove(buttons[row+r][col+c]);
        }
    }
}
public void displayLosingMessage()
{
    for(int r=0;r<buttons.length;r++)
    {
        for(int c=0;c<buttons[r].length;c++)
        {
            buttons[r][c].setLabel(lost[c%(lost.length)]);
        }
    }
}
public void draw()
{
    background(0);
}
public void displayWinningMessage()
{
        for(int r=0;r<buttons.length;r++)
    {
        for(int c=0;c<buttons[r].length;c++)
        {
            buttons[r][c].setLabel(won[c%(won.length)]);
        }
    }
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
    
    public void mousePressed() 
    {
        if(firstClick == true&&mouseButton == LEFT && clicked == false)
        {
            setBombs();
            if(bombs.contains(buttons[r][c])||countBombs(r,c)>0)
            {
                System.out.println("no");
                clearBombs(r,c);
                setBombs();
            }
            firstClick = false;
            System.out.println("yay");
            clearUseless();
            if(firstClick == false)
                mousePressed();
        }
        else if(youSuck==true)
            ;
        else if(mouseButton == LEFT && isMarked() == false&&bombs.contains(buttons[r][c])==true)
        {
            clicked = true;
            youSuck = true;
        }
        else  if(mouseButton == LEFT && isMarked() == false)
        {
            clicked=true;
            String myString = new String();
            if(countBombs(r,c)>0)
            {
                setLabel(myString + countBombs(r,c));//your code here
            }
            else
            {
                setLabel(myString); 
            }
            clearUseless();
        }
        else if(mouseButton == RIGHT && clicked == false)
            marked = !marked;
        }
        public void clearUseless()
    {
             for(int a = -1; a<2; a++){
                for(int b = -1; b<2; b++){
                    if(isValid(r+a,c+b) && countBombs(r,c)==0 && buttons[r+a][c+b].marked==false){
                        if(buttons[r+a][c+b].isClicked() == false){
                            buttons[r+a][c+b].mousePressed();
                        }
                    }
                }
            }
            countCleared();
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
        if(youSuck == true)
        {
            displayLosingMessage();
        }
        if(youGreat==true)
            displayWinningMessage();
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
        for(int i=-1;i<2;i++)
        {
            for(int j=-1;j<2;j++)
            {
                if(isValid(row+i,j+col)==true && bombs.contains(buttons[row+i][col+j])==true)
                    numBombs++;
                }
            }   //your code here
        return numBombs;
    }
    public void countCleared()
    {
        int count = 0;
        for(int r=0;r<buttons.length;r++)
        {
            for(int c=0;c<buttons[r].length;c++)
                {
                    if(buttons[r][c].isClicked()==true)
                        count ++;
                }
        }
        System.out.println(count);
        System.out.println("     "+((NUM_COLS*NUM_ROWS)-BOMBS));
        if(count == ((NUM_COLS*NUM_ROWS)-BOMBS))
            youGreat = true;

        System.out.println(youGreat);
    }
}

//cd c:/users/roshi/documents/apjava/Minesweeper

