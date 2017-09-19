import ddf.minim.*;
import ddf.minim.analysis.*;
 
Minim minim;
AudioPlayer player;
AudioMetaData meta;
BeatDetect beat;
int  r = 225;
float rad = 170;
boolean mode = true;
void setup()
{
  size(displayWidth, displayHeight);
  minim = new Minim(this);
  player = minim.loadFile("4U.mp3");
  meta = player.getMetaData();
  beat = new BeatDetect();
  player.play();
}
 
void draw()
{ 
  beat.detect(player.mix);
  fill(#5b849f, 20);
  noStroke();
  rect(0, 0, width, height);
  translate(width/2, height/2);
  noFill();
  fill(#9b2c42);
  if (beat.isOnset()) rad = rad*0.9;
  else rad = 70;
  ellipse(0, 0, 2*rad, 2*rad);
  stroke(-100, 50);
  strokeWeight(20);
  int bsize = player.bufferSize();

  rotate(PI/2);
  beginShape();
  //noFill();
  stroke(-100, 50);
  for (int i = 0; i < bsize; i+=30)
  {
    //float x2 = (r + player.left.get(i)*100)*cos(i*2*PI/bsize);
    //float y2 = (r + player.left.get(i)*100)*sin(i*2*PI/bsize);
    float x3 = (r + player.left.get(i)*100)*cos(i*PI/bsize);
    float y3 = (r + player.left.get(i)*100)*sin(i*PI/bsize);
    float x4 = (-r + player.left.get(i)*100)*cos(i*PI/bsize);
    float y4 = (-r + player.left.get(i)*100)*sin(i*PI/bsize);
    float x5 = (r + player.left.get(i)*100)*cos(i*PI/bsize);
    float y5 = (r + player.left.get(i)*100)*sin(i*PI/bsize);
    fill(-100, 50);
    stroke(-100, 50);
    //vertex(x2, y2);
    // GOOD ONE vertex(x3, y3);
    
    vertex(y5,x5);
    //stroke(-1);
    stroke(#9b2c42);
    strokeWeight(20);
    //stroke(-100, 50);
    //point(x2, y2);
    //stroke(#9b2c42);
    point(y4, x4);
    //vertex(y4, x4);
  }
  endShape();
  rotate(-PI/2);
  
   boolean flag =true;
   if (flag) showMeta();
   
    strokeWeight(0);
    fill(-100, 50);
    stroke(-100, 50);
    if (mode == false)
    {
      triangle(-260, -220, -260, -190, -230, -205);
      
    }

    if (mode == true)
    {
      
      //pause
      rect(-573, -275, 7, 20);
      rect(-583, -275, 7, 20);
      //forward
      triangle(-553, -275, -553, -255, -533, -265);
      rect(-533, -275, 3, 20);
      //back
      triangle(-596, -275, -596, -255, -616, -265);
      rect(-619, -275, 3, 20);
    }
  }
void keyPressed()
{
  if ( player.isPlaying() )
  {
    player.pause();
    mode = false;
  } else
  {
    player.play();
    mode = true;
  }
}
 
 
 
void showMeta() {
  int time =  meta.length();
  textSize(50);
  textAlign(CENTER);
  text( (int)(time/1000-millis()/1000)/60 + ":"+ (time/1000-millis()/1000)%60, -575, -300);
}