import processing.core.*;

//A. Gabereau 4867815
//February 12, 2007
//CART 363 Assignment 2


// Class that displays a single cell of a checker board
class EZone {
  //parent applet
  private PApplet p;
  private int x;
  private int y;
  private int eRed;
  private int eGreen;
  private int eBlue;
  private int eSize;
  private int eVarSize;
  private int eAlpha;
  private double arousal;
  private int AROUSAL_MAX = 200;
  private double GROWTH_FACTOR;
  private double SIZE_VAR;
  /*----------------------methods------------------*/
  //constructor method
  public EZone(int x, int y, int eRed, int eGreen, int eBlue, int eSize, PApplet parent) {
    p = parent;
    //assign a value to our x property
    this.x = x;
    this.y = y;
    this.eRed = eRed;
    this.eGreen = eGreen;
    this.eBlue = eBlue;
    this.eSize = eSize;
    this.eVarSize = eSize;
    eAlpha = 0;
    arousal = 0;
    GROWTH_FACTOR = p.random(6);
    SIZE_VAR = ((eSize*GROWTH_FACTOR)-eSize)/AROUSAL_MAX;
    
  }


  public boolean checkTouch() {
    if (p.mouseX > x && p.mouseX < x + eSize && p.mouseY > y && p.mouseY < y + eSize) {
      return true;
    } 
    else {
      return false;
    }
  }

  public void touchMe() {
 
    //if the mouse is above this EZone...
    if (checkTouch())
      arouse();

  }

  public void arouse(){
    //increase arousal
    if(arousal<AROUSAL_MAX){
      arousal+=2;
      sizeMe();
      colorMe();
    }

  }

  public void decline(){
    //decrease arousal
    arousal= arousal - arousal/175;
    //maybe there should be a fucntion to decrease aroused state represenation.
    sizeMe();
    colorMe();

  }

  public void sizeMe(){
    //mainpulate size of ellipse in relation to arousal
    //the ellipse can only grow or shrink by 30% of size
    //so arousal levels are between zero and 255.
    //at zero eSize is that which is given in constructor
    //at 255 it is 30% bigger than given size.
  
    eVarSize = (int)(eSize + SIZE_VAR*arousal);
    //p.println(eVarSize);
  }

  public void colorMe(){
    //manipulate alpha value in relation to arousal
    //when arousal is at max alpha value is 255
    eAlpha = (int)arousal;
  }

  //draws the cell. This is public because other objects will need to be able to tell
  //the object to draw itself.
  public void draw() {
    decline();
    p.fill(p.color(eRed, eGreen, eBlue, eAlpha));
    p.ellipse(x,y,eVarSize, eVarSize);
  }
}
