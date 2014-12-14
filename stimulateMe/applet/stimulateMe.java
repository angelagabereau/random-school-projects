import processing.core.*; import java.applet.*; import java.awt.*; import java.awt.image.*; import java.awt.event.*; import java.io.*; import java.net.*; import java.text.*; import java.util.*; import java.util.zip.*; public class stimulateMe extends PApplet {//A. Gabereau 4867815
//February 12, 2007
//CART 363 Assignment 2

EZone[] body; 
int zoneCount = 300;
int lastTimeMouseMove=0;
ImageStack iStack;
boolean pushyMouse=false;
PImage titlePage;
PImage backgroundImage;
boolean firstMove = false;

public void setup(){
  titlePage = loadImage("titlepage.gif");
  backgroundImage = loadImage("bkgd.gif");
  size(800,600);
  noStroke();
  ellipseMode(CORNER);

  iStack = new ImageStack(this);
  body = new EZone[zoneCount];
  makeBody();

}

//This function fills an array of Ezone Objects.
public void makeBody(){
  for(int i=0; i<zoneCount; i++)
    body[i] = new EZone((int)random(1100)-200, (int)random(900)-200, (int)random(255), (int)random(255), (int)random(255), (int)random(150), this);

}

public void draw(){
  if(firstMove == false){
    image(titlePage,0,0, 800, 600);
  }
  else{
    //it the user has not pressed mouse button then draw the iStack and EZones to screen
    if(!pushyMouse){
      image(backgroundImage,0,0, 800, 600);
      //iterate throught each EZone object in array and draw to screen.
      for(int i=0; i<zoneCount; ++i)
        body[i].draw();
      //draw the image the image stack
      iStack.drawImageStack(mouseMoving());
    }
    else{
      //the user has pressed the mouse button, so site enters rejection state and screen drawn all black.
      background(0);
    }
  }
}

public void mouseMoved(){

  //if this is the first time the mouse has been moved chance value of firstMove to true.
  firstMove=true;

  //move through array and check if the mouse is stimulating any EZone.
  for(int i=0; i<zoneCount; ++i)
    body[i].touchMe();
  lastTimeMouseMove = millis();

}

//returns a int which signifies type of mouse movment, which is determined by speed.

public int mouseMoving(){

  int interval = millis()-lastTimeMouseMove;

  if (interval<75)
    return 4;//agressive
  else if (interval<200)
    return 3;//fast
  else if (interval<500)
    return 2;//medium
  else if (interval<700)
    return 1;//slow
  else
    return 0;

}

public void mousePressed(){
  pushyMouse=true;
}

public void mouseDragged(){
  pushyMouse=true;
}

static public void main(String args[]) {   PApplet.main(new String[] { "stimulateMe" });}}