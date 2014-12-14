// Note: requires Carnivore Library for Processing v2.2 (http://r-s-g.org/carnivore)
//
// + Windows people:  first install winpcap (http://winpcap.org)
// + Mac people:      first open a Terminal and execute this commmand: sudo chmod 777 /dev/bpf*
//                    (must be done each time you reboot your mac)
//
// "offline" demo mode requires a log file created by CarnivorePE (see below) 
//

import java.util.Iterator;
import java.util.Date;
import org.rsg.carnivore.*;
import org.rsg.carnivore.net.*;
import org.rsg.carnivore.net.IPAddress;
import krister.Ess.*;


/////////////////////////////////////////////////////////////////////////////////
// For offline mode must have log file in sketch's "data" folder  
// You can make your own log file in CarnivorePE using the "headers only" channel 
// Flag for online/offline modes.
boolean isOnline = true;

String log_file = "Log_06Dec8b.txt";
//String log_file = "test1.txt";
//////////////////////////////////////////////////////////////////////////////////



HashMap paKets = new HashMap();

String packets[];
boolean inColor = true;
int offLineCount = 0;

color color1  = color(0, 0, 0, 170); 	        //0x000000 black	unknown
color color2  = color(153, 0, 204, 170); 	//0x9900CC purple	ftp
color color3  = color(51, 51, 204, 170); 	//0x3333CC darkblue   	itunes
color color4  = color(102, 102, 255, 170); 	//0x6666FF blue		http
color color5  = color(51, 102, 102, 170); 	//0x336666 darkgreen  	email
color color6  = color(102, 153, 0, 170); 	//0x669900 green	aim
color color7  = color(204, 255, 102, 170); 	//0xCCFF66 lightgreen 	Network Time Protocol
color color8  = color(0, 51, 51, 170); 	//0xFFCC00 teal		telnet/ssh
color color9  = color(255, 153, 0, 170); 	//0xFF9900 orange	BOOTP client
color color10 = color(153, 102, 102, 170); 	//0xFF6666 pink		netbios
color color11 = color(102, 102, 51, 170); 	        //0xCC0000 beige		name-domain server

PFont fontA;

void setup() {

  size(400, 850);
  background(250);
  frameRate(5);
  smooth();
  ellipseMode(CENTER);

    //online mode
  if(isOnline) {
    CarnivoreP5 c = new CarnivoreP5(this);  
     c.setVolumeLimit(3);
  //offline mode
  } else {
    packets = loadStrings(log_file); // Need CarnivorePE "minivore" log file in "data" folder 
  }
  
  //start sound engine
  Ess.start(this);

}

class PaKet{

  ///////////////////////////////////////////////
  
  /*----------------------properties--------------*/

  //position
  float x;
  float y;

  //target position
  private  float targetX;
  private  float targetY;
  private float deltaSpeed;
  private int pColor;
  private int pSize;
  private int pStroke;
  private int pAlpha;
  private String pString;
  private float pTextSize;

  private float diameter;
  private float shrinkSpeed = 0.9;
  
  String date;
  IPAddress senderIP;
  IPAddress recieverIP;
  int port;

  /*----------------------methods--------------*/
  //constructor method
  public PaKet(String date, IPAddress senderIP, IPAddress recieverIP, int port, String pString) {

    this.date = date;
    this.senderIP = senderIP;
    this.recieverIP = recieverIP;
    this.port = port;
    this.pString = pString;

    this.x = getXfromIP(senderIP);
    this.y = getYfromIP(senderIP);
    this.setTarget(getXfromIP(recieverIP), getXfromIP(recieverIP));

    
    this.pColor = port2color(port);
    

    this.pStroke = this.pColor;
    this.pAlpha = 20;
  
    this.deltaSpeed = random(10,30);
    
    if(isOnline)
      this.diameter = 5*pString.length();
    else
      this.diameter = random(50,1500);
      
    sonify(port,(int) diameter, x, y, targetX, targetY, senderIP.octet1(),senderIP.octet2(), recieverIP.octet1(), recieverIP.octet2());
  println("port: " +this.port);

  }

  //draws the cell. This is public because other objects will need to be able to tell
  //the object to draw itself.
  public void draw() {
    fill(pColor, pAlpha);
    stroke(pStroke);
    //stroke(0,0,0,100); // Circle rim
    ellipse(x, y, diameter, diameter);

  }

 public void move()
  {
          this.draw();
          this.shrink();
	  float dx = targetX-x;
	  float dy = targetY-y;

	  //ease toward the point
	  float stepx = dx/50;
	  float stepy = dy/50;

	  //set the new rect position
	  x = x+stepx;
	  y = y+stepy;
          
  }
  
 
  
   void shrink() {
      diameter = diameter * shrinkSpeed; 
  }

  /*
   This is a function to set new values for some of the object's variables.
   A function like this is often called a "mutator function" or "mutator method".
   */
   public void setTarget(float x, float y){
    targetX = x;
    targetY = y;
  }
  
  color port2color(int port) {
    if(port == 21)   { return color2  ; }   //ftp
    if(port == 22)   { return color8  ; }   //ssh
    if(port == 25)   { return color5  ; }   //smtp
    if(port == 53)   { return color11 ; }   //name-domain server
    if(port == 5353) { return color11 ; }   //name-domain server
    if(port == 68)   { return color9  ; }   //BOOTP client
    if(port == 69)   { return color9  ; }   //BOOTP client
    if(port == 80)   { return color4  ; }   //http
    if(port == 8020) { return color4  ; }   //http
    if(port == 443)  { return color4  ; }   //https
    if(port == 110)  { return color5  ; }   //pop3
    if(port == 123)  { return color7  ; }   //Network Time Protocol
    if(port == 137)  { return color10 ; }   //NETBIOS
    if(port == 138)  { return color10 ; }   //NETBIOS
    if(port == 139)  { return color10 ; }   //NETBIOS
    if(port == 427)  { return color3  ; }   //itunes?
    if(port == 5190) { return color6  ; }   //aim
     switch((int)random(15)){
      case 1:
        return color2;
      case 2:
        return color3; 
      case 3: 
        return color4;
      case 4: 
        return color10;
      case 5: 
        return color6;
      case 6:
        return color8;
      default: 
        return color1;
     }

  }
  int getXfromIP(IPAddress ip) {
  // Use last two IP address bytes for x/y coords
  //int splitter = ip.lastIndexOf(".");
 // int y = int(ip.substring(splitter+1)) * height / 255; // Scale to applet size
  //String tmp = ip.substring(0,splitter);
 // splitter = tmp.lastIndexOf(".");
  int x = ip.octet3() * width / 255; // Scale to applet size
  return x;
}

int getYfromIP(IPAddress ip) {
  // Use last two IP address bytes for x/y coords
  //int splitter = ip.lastIndexOf(".");
  int y = ip.octet4() * height / 255; // Scale to applet size
  return y;
}

float getDiameter(){
  return diameter;
}
}


void draw() {
  //redraw the background color on the screen
   background(250);
   
     if(!isOnline) {
       
       //println("offline simulation");
      // Simulate incoming packets
      if(random(100) < 15) {
        String packet = packets[int(random(packets.length))]; // Get random packet from array of all packets
        // println(packet);
        String from_and_to = packet.substring(packet.indexOf(" ")+1);
        String from_ip = fromIPfromFromTo(from_and_to);
        int from_port = fromPortfromFromTo(from_and_to);
        String to_ip = toIPfromFromTo(from_and_to);
        IPAddress s = new IPAddress(from_ip);
        IPAddress r = new IPAddress(to_ip);
  
  
        //if(packet.ascii().length()!=0)
        String date = Integer.toString(offLineCount);
         //println("key" +date);
          paKets.put(date, new PaKet(date,s,r, from_port, (packet+packet+packet)));
         ++offLineCount;
     
       }
     }
  drawPaKets(); 
}

// This is the callback for the online mode, i.e. Carnivore library triggers this method
synchronized void packetEvent(CarnivorePacket packet){
  if(isOnline) {
   // println("[PDE] packetEvent: " /*+ packet*/);

    // Make Node objects and add them to the hashmap 
    if(packet.ascii().length()!=0)
      paKets.put(packet.dateStamp().toString(), new PaKet(packet.dateStamp(), packet.senderAddress, packet.receiverAddress, packet.senderPort, packet.ascii()));

  }
}

void drawPaKets() {
  
  //println("drawing Packets");
  Iterator it = paKets.keySet().iterator();
  //println("size" +paKets.size());
  while(it.hasNext()){
    String ip = (String)it.next();
    PaKet p = (PaKet) paKets.get(ip);
   // println("diam" +p.getDiameter());
    
    if(p.getDiameter()<1){
      paKets.remove(it);
      deleteSound();
      //println("deleteing node");
    }else{
      p.move();
    }

  }  
}

void deleteSound(){

  SineWave wave;
  Reverb reverb =new Reverb();;
  Envelope envelope;
  AudioChannel channel = new AudioChannel(); ;
  
  EPoint[] env=new EPoint[4];
  env[0]=new EPoint(0,0);
  env[1]=new EPoint(.05,0.8);
  env[2]=new EPoint(.1,0.1);
  env[3]=new EPoint(1,0);
  envelope=new Envelope(env);
  
  int harmonic = (int)random(1,6);
  
  wave=new SineWave(480*harmonic,.2);
  
  channel.initChannel(channel.frames(1200));
  wave.generate(channel,0,channel.frames(1100));

  reverb.filter(channel,harmonic/10);
  envelope.filter(channel);
  // play
  channel.play();
}

void sonify(int port, int dim, float x1, float y1, float x2, float y2, int a, int b, int c, int d){
  println("audio channel recieves port:" +  port);
  AudioChannel channel;
  float sum = x1+y1+x2+y2;
  switch(port){
    case 21://ftp
      channel=sine(x1+x2);
      break;
    case 22://ssh
      channel=sine(y1+y2);
      break;
    case 53://name-domain server
     channel=square((x1 + y1)/3);
      break;
    case 5353://name-domain server
      channel=sine(sum);
      break;
    case 68://BOOTP client
      channel=saw(x2);
      break;
    case 69://BOOTP client
     channel=saw(y1);
      break;
    case 80://http
      channel=sine(sum);
      break;
    case 8020://http
       channel=sine(sum);
      break;
    case 443://https
       channel=sine(sum);
      break;
    case 110://pop3
      channel=tri(sum/2);
      break;
    case 123://Network Time Protocol
      channel=tri(sum/3);
      break;
    case 137://NETBIOS
      channel=wnoise();;
      break;
    case 138://NETBIOS
      channel=wnoise();
      break;
    case 139://NETBIOS
       channel=wnoise();
      break;
    case 427://itunes?
       channel=pnoise();
      break;
    case 5190://aim
      channel=pnoise();
      break;
    default:
      switch((int)random(6)){
      case 1:
        channel=sine(sum);
        break;
      case 2:
        channel=square((x2 + y2)/4); 
        break;
      case 3: 
        channel=pnoise();
        break;
      case 4: 
        channel=wnoise();
        break;
      case 5: 
        channel=tri(sum/2);
        break;
      case 6:
       channel=saw(y1); 
        break;
      default: 
        channel=saw(x2);
        break;
     }

      break;
      
      
  }

  // play
  channel.play();
  
}

AudioChannel sine(float fund){

  AudioChannel channel=new AudioChannel();
    // our waves
  SineWave wave=new SineWave(fund,.2);

  // our effects
  Reverb reverb=new Reverb();
  Envelope envelope;

    // apply a 3 point envelope
  EPoint[] env=new EPoint[6];
  env[0]=new EPoint(0,0);
  env[1]=new EPoint(.25,0.3);
  env[2]=new EPoint(.5,0.5);
  env[3]=new EPoint(1,0.4);
  env[4]=new EPoint(3,0.2);
  env[5]=new EPoint(5,0);
  
  envelope=new Envelope(env);

  // set the channel size to 5 seconds
  channel.initChannel(channel.frames(5000));

  wave.generate(channel,0,channel.frames(5000));

  reverb.filter(channel,0.1);
  envelope.filter(channel);

  return channel;
}

AudioChannel pnoise(){

  AudioChannel channel=new AudioChannel();
  PinkNoise pnoise =new PinkNoise(.3);
  Envelope envelope;

  EPoint[] env=new EPoint[6];
  env[0]=new EPoint(0,0);
  env[1]=new EPoint(.25,0.3);
  env[2]=new EPoint(.5,0.5);
  env[3]=new EPoint(1,0.4);
  env[4]=new EPoint(3,0.2);
  env[5]=new EPoint(5,0);
  
  envelope=new Envelope(env);
  channel.initChannel(channel.frames(5000));
  pnoise.generate(channel,0,channel.frames(5000));

  envelope.filter(channel);
  
  return channel;
}

AudioChannel wnoise(){
  AudioChannel channel=new AudioChannel();
  WhiteNoise wnoise=new WhiteNoise(.05);
  
  Envelope envelope;

  EPoint[] env=new EPoint[6];
  env[0]=new EPoint(0,0);
  env[1]=new EPoint(.25,0.3);
  env[2]=new EPoint(.5,0.5);
  env[3]=new EPoint(1,0.4);
  env[4]=new EPoint(3,0.2);
  env[5]=new EPoint(5,0);
  
  envelope=new Envelope(env);
  channel.initChannel(channel.frames(5000));
  wnoise.generate(channel,0,channel.frames(5000));

  envelope.filter(channel);
  return channel;
}

AudioChannel saw(float freq){
  AudioChannel channel=new AudioChannel();
  SawtoothWave wave=new SawtoothWave(freq, 0.3);
  
  Envelope envelope;

  EPoint[] env=new EPoint[6];
  env[0]=new EPoint(0,0);
  env[1]=new EPoint(.25,0.3);
  env[2]=new EPoint(.5,0.5);
  env[3]=new EPoint(1,0.4);
  env[4]=new EPoint(3,0.2);
  env[5]=new EPoint(5,0);
  
  envelope=new Envelope(env);
  channel.initChannel(channel.frames(5000));
  wave.generate(channel,0,channel.frames(5000));

  envelope.filter(channel);
  return channel;
}

AudioChannel square(float freq){
  AudioChannel channel=new AudioChannel();
  SquareWave wave=new SquareWave(freq, 0.3);
  
  Envelope envelope;

  EPoint[] env=new EPoint[6];
  env[0]=new EPoint(0,0);
  env[1]=new EPoint(.25,0.3);
  env[2]=new EPoint(.5,0.5);
  env[3]=new EPoint(1,0.4);
  env[4]=new EPoint(3,0.2);
  env[5]=new EPoint(5,0);
  
  envelope=new Envelope(env);
  channel.initChannel(channel.frames(5000));
  wave.generate(channel,0,channel.frames(5000));

  envelope.filter(channel);
  return channel;
}

AudioChannel tri(float freq){
  AudioChannel channel=new AudioChannel();
  TriangleWave wave=new TriangleWave(freq, 0.3);
  
  Envelope envelope;

  EPoint[] env=new EPoint[6];
  env[0]=new EPoint(0,0);
  env[1]=new EPoint(.25,0.3);
  env[2]=new EPoint(.5,0.5);
  env[3]=new EPoint(1,0.4);
  env[4]=new EPoint(3,0.2);
  env[5]=new EPoint(5,0);
  
  envelope=new Envelope(env);
  channel.initChannel(channel.frames(5000));
  wave.generate(channel,0,channel.frames(5000));

  envelope.filter(channel);
  return channel;
}



void audioChannelDone(AudioChannel ch) {
  //println("AudioChannel "+ch+" is done playing.");
  ch.destroy();
}

////////////////////////////////////////////////////////////////////////////
// Helper methods 
int getXfromIP(String ip) {
  // Use last two IP address bytes for x/y coords
  int splitter = ip.lastIndexOf(".");
  int y = int(ip.substring(splitter+1)) * height / 255; // Scale to applet size
  String tmp = ip.substring(0,splitter);
  splitter = tmp.lastIndexOf(".");
  int x = int(tmp.substring(splitter+1)) * width / 255; // Scale to applet size
  return x;
}

int getYfromIP(String ip) {
  // Use last two IP address bytes for x/y coords
  int splitter = ip.lastIndexOf(".");
  int y = int(ip.substring(splitter+1)) * height / 255; // Scale to applet size
  return y;
}


String fromIPfromFromTo(String from_and_to) {
  String from         = from_and_to.substring(0, from_and_to.indexOf(" > "));
  String to           = from_and_to.substring(from_and_to.indexOf(" > ")+3);
  String from_ip      = from.substring(0, from.indexOf(":"));
  return from_ip;
}

int fromPortfromFromTo(String from_and_to) {
  String from         = from_and_to.substring(0, from_and_to.indexOf(" > "));
  String to           = from_and_to.substring(from_and_to.indexOf(" > ")+3);
  String from_ip      = from.substring(0, from.indexOf(":"));
  String from_port    = from.substring(from.indexOf(":")+1);
  return int(from_port);
}

String toIPfromFromTo(String from_and_to) {
  String from         = from_and_to.substring(0, from_and_to.indexOf(" > "));
  String to           = from_and_to.substring(from_and_to.indexOf(" > ")+3);
  String from_ip      = from.substring(0, from.indexOf(":"));
  String from_port    = from.substring(from.indexOf(":")+1);
  String to_ip        = to.substring(0, to.indexOf(":"));
  return to_ip;
}

int toPortfromFromTo(String from_and_to) {
  String from         = from_and_to.substring(0, from_and_to.indexOf(" > "));
  String to           = from_and_to.substring(from_and_to.indexOf(" > ")+3);
  String from_ip      = from.substring(0, from.indexOf(":"));
  String from_port    = from.substring(from.indexOf(":")+1);
  String to_ip        = to.substring(0, to.indexOf(":"));
  String to_port      = to.substring(to.indexOf(":")+1);  
  return int(to_port);
}

boolean eitherPortMatches(String from_and_to, int p) {
  int from_port = fromPortfromFromTo(from_and_to);
  int to_port   = toPortfromFromTo(from_and_to);
  if((from_port == p) || (to_port == p)) {
    return true;
  }
  return false;
}



