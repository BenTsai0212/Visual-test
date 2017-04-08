/**
 * Sine. 
 * 
 * Smoothly scaling size with the sin() function. 
 */
import ddf.minim.*;

Minim minim;
AudioPlayer bell;
AudioPlayer background;

 
int limit = 40;
int[] sx = new int[limit];
int[] sy = new int[limit];
int trigger;
int sum = 0; //sum
int index = 0;

//track
int seg = 100; //linear interpolation
int segCount = 0; 
int trackObject = 0; //record who is tracking now 

void setup() {
  size(1280, 1024);
  
  minim = new Minim(this);
  bell = minim.loadFile("Dinner_Chimes.mp3");
  background = minim.loadFile("Cytus-Bloody Purity.ampg.mp3");
  
  if(mouseX == 0 && mouseY == 0)
  trigger = 0;
//  background.loop();
}
void draw() {
  frameRate(20);
  background(0);
 
   
  mouseDetect();
  
  drawCircle(100f);
  drawTracking();
  drawLine();
  RandomMove();
    
    //trigger = 0;

 // angle += 0.02;
}
void RandomMove()
{  
  for(int i = 0; i < sum; i++)
  {
    float randX = random(2)-1;
    float randY = random(2)-1;
    
    if((sx[i] + randX) < 1280 && (sx[i] + randX) > 0)
    {sx[i] += randX;}
    if((sy[i] + randY) < 1024 && (sx[i] + randY) > 0) {sx[i] += randY;}
  }
}

void drawLine()
{
  for(int i=0;i<sum;i++) {
      for(int j=i;j<sum;j++) {
         stroke(((255*7)/sx[i]),255,255,64);
      line(sx[i],sy[i],sx[j],sy[j]);
      }
    }
}
void drawTracking()
{
  if(sum>=1)
  {
    if(trackObject+1 <= sum) //if the next object is exist 
    {
      
      //decide who tracking who
      int dest;
      if(trackObject == limit) dest = 0; //if next is first one
      else dest = trackObject+1;
      //draw path
        color(0,192,192,128);
        ellipse(sx[trackObject]+(sx[dest]-sx[trackObject])*segCount/seg,sy[trackObject]+(sy[dest]-sy[trackObject])*segCount/seg,20,20);
     //calculate seg index
        if(segCount+1 <= seg) segCount++;
        else 
        {
          trackObject++;
          segCount = 0;  
        }
    }
    else trackObject = 0;
  }  
}

void mouseDetect()
{
  if(mousePressed) {
    bell.rewind();
    bell.play();
    
    if(index < limit) {
      sx[index] = mouseX;
      sy[index++] = mouseY;
      trigger = 1;
       delay(20);
      if(sum < limit)
        sum++;
      }
    else {
      index = 0;
    }
   }
}
void drawCircle(float R)
{
   for(float i = 0; i <= 2*PI; i+=0.1)
    {
      if(trigger == 1)
      for(int j=0;j<sum;j++) {
      line(R*cos(i)+random(-5,5)+sx[j],R*sin(i)+random(-5,5)+sy[j],R*cos(i+1)+random(-5,5)+sx[j],R*sin(i+1)+random(-5,5)+sy[j]);   
      }
      line(R*cos(i)+random(-5,5)+mouseX,R*sin(i)+random(-5,5)+mouseY,R*cos(i+1)+random(-5,5)+mouseX,R*sin(i+1)+random(-5,5)+mouseY);   
    }
}