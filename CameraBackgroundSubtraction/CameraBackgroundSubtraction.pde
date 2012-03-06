/**
 This is a JMyron Camera Test for background subtraction
 @author Kenichi Yorozu
*/

import JMyron.*;

JMyron m;//a camera object

//variables to maintain the floating green circle
float objx = 160;
float objy = 120;
float objdestx = 160;
float objdesty = 120;

void setup(){
  size(640,480);
  m = new JMyron();//make a new instance of the object
  m.start(width,height);//start a capture at 320x240
  m.trackColor(255,255,255,256*3-100);//track white
  m.update();
  m.adaptivity(0);
  m.adapt();// immediately take a snapshot of the background for differencing
  println("Myron " + m.version());
  rectMode(CENTER);
  noStroke();
}


void draw(){
  m.update();//update the camera view
  drawCamera();
}

void drawCamera(){
  int[] img = m.differenceImage(); //get the normal image of the camera
  loadPixels();
  for(int i=0;i<width*height;i++){ //loop through all the pixels
    pixels[i] = img[i]; //draw each pixel to the screen
  }
  updatePixels();
}

void mousePressed(){
  if(mouseButton == RIGHT){
    m.settings();//click the window to get the settings
  }else if(mouseButton == LEFT){
    m.adapt();// immediately take a snapshot of the background for differencing
  }
}

public void stop(){
  m.stop();//stop the object
  super.stop();
}

