import processing.core.*;

//A. Gabereau 4867815
//February 12, 2007
//CART 363 Assignment 2

class ImageStack{
  private PApplet p;
  private PImage a,b,c,d,e;
  private int stackCount = 0;
  private int stackWidth = 800;
  private int stackHeight = 600;
  private int topWidth  = 800;
  private int topHeight = 600;
  private int growCount = 0;
  private int x = 0;
  private int y = 0;
  private int widthSpeed = 5;
  private int heightSpeed = 5;
  private int count = 0;
  private int opacity = 200;

  public ImageStack(PApplet parent){
    p=parent;
    loadImageStack();
  }

  public void loadImageStack(){
    a = p.loadImage("1.gif");
    b = p.loadImage("4.gif");
    c = p.loadImage("5.gif");
    d = p.loadImage("3.gif");
    e = p.loadImage("2.gif");
  }

  public void drawImageStack(int speed){

    switch(stackCount){
    case 0:
      se(speed);
      break;
    case 1:
      sd(speed);
      break;
    case 2:
      sc(speed);
      break;
    case 3:
      sb(speed);
      break;
    case 4:
      sa(speed);
      break;

    }
    if(speed>0){
      growCount = count/200;
      count=count+speed;
    }

  }

  private void se(int speed){

    p.image(a,0,0, stackWidth, stackHeight);
    p.image(b,0,0, stackWidth, stackHeight);
    p.image(c,0,0, stackWidth+1, stackHeight);
   // p.image(d,0,0, stackWidth-2, stackHeight-2);
    p.image(e, x, y, topWidth, topHeight); 
    if(speed>0){
      x+=(speed/4);
      y-=(speed/4);
      valueIncrement();
    }
  }

  private void sd(int speed){

    p.image(a, 0, 0, stackWidth, stackHeight);
    p.image(b, 0, 0, stackWidth-1, stackHeight);
    p.image(c, 0, 0, stackWidth, stackHeight+1); 
   // p.image(d, x, y, topWidth, topHeight);  
    if(speed>0){
      x-=(speed/4);
      y-=(speed/4);
      valueIncrement();
    }
  }

  private void sc(int speed){

    p.image(a, 0, 0, stackWidth+1, stackHeight);
    p.image(b, 0, 0, stackWidth+1, stackHeight-1); 
    p.image(c, x, y, topWidth, topHeight); 
    if(speed>0){
      x-=(speed/3);
      y-=(speed/3);
      valueIncrement();
    }
  }


  private void sb(int speed){

    p.image(a, 0, 0, stackWidth, stackHeight+1);
    p.image(b, x, y, topWidth, topHeight);
    if(speed>0){
      x-=(speed/2);
      y-=(speed/2);
      valueIncrement();
    } 

  }


  private void sa(int speed){
    p.image(a, x, y, topWidth, topHeight);
    if(speed>0)
      valueIncrement();  

  }

  private void valueIncrement(){
    //println("grow = " +growCount+ " stack = " + stackCount);
    if (stackCount<growCount&&stackCount!=4){
      //reset values and move to next image in stack.
      topWidth = stackWidth;
      topHeight = stackHeight;
      x=0;
      y=0;
      stackCount++; 
      widthSpeed--;
      heightSpeed--;
      //println("move to next im" + stackCount);
    }
    else{
      //println("increasing");
      topWidth+=(widthSpeed);
      topHeight+=(heightSpeed);
      stackWidth++;
      stackHeight++;
    }

  }

}
