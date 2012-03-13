/**
  @file _3DCameraManipulation
  @brief This program handles 3D Manipulation of Camera via Mouse.
  Mouse Left Button : Rotate
  Mouse Right Button : Translate
  Mouse Center Button : Zoom
  @author Kenichi Yorozu
  @date 13th March 2012
 */

import processing.opengl.*;

float boxSize = 400;
color boxFill;

//Camera Properties
float camZoom = 130.0f;
float camRotX = 0.0f;
float camRotY = 0.0f;
float camTX = 0.0f;
float camTY = 0.0f;
//Mouse Properties
int lastX = 0;
int lastY = 0;
boolean[] Buttons = {false, false, false};

void setup(){
  size(800, 800, P3D);      //Use processing 3D
  //size(800, 800, OPENGL);  //Use OpenGL
  
}

void draw(){
  background(0);
  //Update Camera
  translate(camTX + width/2, camTY + height/2, -camZoom);
  rotateX(camRotX);
  rotateY(camRotY);
  //Rotate Object
  rotateY(frameCount * 0.01);
  //set Color
  boxFill = color(255, 10, 100, 100);
  fill(boxFill);
  //DrawBox
  box(boxSize, boxSize, boxSize);
  rotateY(-frameCount * 0.01);
}

void mousePressed(){
  lastX = mouseX;
  lastY = mouseY;
  
  if(mouseButton == LEFT){
    Buttons[0] = true;
  }else{
    Buttons[0] = false;
  }
  if(mouseButton == CENTER){
    Buttons[1] = true;
  }else{
    Buttons[1] = false;
  }
  if(mouseButton == RIGHT){
    Buttons[2] = true;
  }else{
    Buttons[2] = false;
  }
  
}

void mouseDragged(){
  int diffX = mouseX - lastX;
  int diffY = mouseY - lastY;
  lastX = mouseX;
  lastY = mouseY;
  
  if( Buttons[1] ){
    camZoom -= (float) 0.5f * diffY;
  }else if(Buttons[0] ){
    camRotX -= (float) 0.01f * diffY;
    camRotY += (float) 0.01f * diffX;
  }else if( Buttons[2] ){
    camTX += (float) 0.1f * diffX;
    camTY += (float) 0.1f * diffY;
  }
}
