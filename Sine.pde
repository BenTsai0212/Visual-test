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
int seg = 10;
int segCount = 0;


void setup() {
  size(1280, 1024);
  
  minim = new Minim(this);
  bell = minim.loadFile("Dinner_Chimes.mp3");
  background = minim.loadFile("Cytus-Bloody Purity.ampg.mp3");
  
  if(mouseX == 0 && mouseY == 0)
  trigger = 0;
  //background.loop();
}
void draw() {
  frameRate(20);
  float R = 100f;
  background(0);
 
   
  if(mousePressed) {
    //bell.rewind();
    //bell.play();
    
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
  
  
    for(float i = 0; i <= 2*PI; i+=0.1)
    {
      if(trigger == 1)
      for(int j=0;j<sum;j++) {
      //line(R*cos(i)+random(-5,5)+sx[j],R*sin(i)+random(-5,5)+sy[j],R*cos(i+1)+random(-5,5)+sx[j],R*sin(i+1)+random(-5,5)+sy[j]);   
      }
      //line(R*cos(i)+random(-5,5)+mouseX,R*sin(i)+random(-5,5)+mouseY,R*cos(i+1)+random(-5,5)+mouseX,R*sin(i+1)+random(-5,5)+mouseY);   
    }
    
    for(int i=0;i<sum;i++) {
      for(int j=i;j<sum;j++) {
         stroke(((255*7)/sx[i]),255,255,64);
      line(sx[i],sy[i],sx[j],sy[j]);
      }
    }
    
    if(sum>=1);
    for(int i=1;i<sum;i++) {
      //fill(102);
      for(int j=1;j<=seg;j++) {
        ellipse(sx[i-1]+(sx[i]-sx[i-1])*j/seg,sy[i-1]+(sy[i]-sy[i-1])*j/seg,18,18);
        //delay(10);
      }
    }
    //trigger = 0;

 // angle += 0.02;
}