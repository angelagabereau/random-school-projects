class ImageStack{
  
  PImage a,b,c,d,e;
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

  public ImageStack(){
    loadImageStack();


  }

  void setup() {
    size(800,600);
    background(46,137, 136);


  }

  void draw() {
    //while(stackCount<6)
    background(255,255,255);
    drawImageStack();
    growCount = millis()/20000;
    println("x, y    "+ x+"   ,    "+y);

  }

  public void loadImageStack(){
    a = loadImage("1.gif");
    b = loadImage("4.gif");
    c = loadImage("5.gif");
    d = loadImage("3.gif");
    e = loadImage("2.gif");
  }

  public void drawImageStack(){

    switch(stackCount){
    case 0:
      se();
      break;
    case 1:
      sd();
      break;
    case 2:
      sc();
      break;
    case 3:
      sb();
      break;
    case 4:
      sa();
      break;

    }

  }

  private void se(){

    image(a,0,0, stackWidth, stackHeight);
    image(b,0,0, stackWidth, stackHeight);
    image(c,0,0, stackWidth+1, stackHeight);
    //image(d,0,0, stackWidth-2, stackHeight-2);
    image(e, x, y, topWidth, topHeight); 
    x+=2;
    y-=5;
    valueIncrement();
  }

  private void sd(){

    image(a, 0, 0, stackWidth, stackHeight);
    image(b, 0, 0, stackWidth-1, stackHeight);
    image(c, 0, 0, stackWidth, stackHeight+1); 
    //image(d, x, y, topWidth, topHeight);  
    x-=6;
    y-=6;
    valueIncrement();
  }

  private void sc(){

    image(a, 0, 0, stackWidth+1, stackHeight);
    image(b, 0, 0, stackWidth+1, stackHeight-1); 
    image(c, x, y, topWidth, topHeight); 
    x-=6;
    y-=4;
    valueIncrement();
  }


  private void sb(){

    image(a, 0, 0, stackWidth, stackHeight+1);
    image(b, x, y, topWidth, topHeight);
    x-=2;
    y-=2;
    valueIncrement(); 

  }


  private void sa(){
    image(a, x, y, topWidth, topHeight);
    valueIncrement();  

  }

  private void valueIncrement(){
    //println("grow = " +growCount+ " stack = " + stackCount);
    if (stackCount<growCount){
      //reset values and move to next image in stack.
      topWidth = stackWidth;
      topHeight = stackHeight;
      x=0;
      y=0;
      stackCount++; 
      widthSpeed--;
      heightSpeed--;
      println("move to next im" + stackCount);
    }
    else{
      //println("increasing");
      topWidth+=5;
      topHeight+=5;
      stackWidth++;
      stackHeight++;
    }

  }

}
