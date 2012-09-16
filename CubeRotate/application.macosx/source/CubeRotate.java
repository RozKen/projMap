import processing.core.*; 
import processing.xml.*; 

import processing.opengl.*; 

import java.applet.*; 
import java.awt.Dimension; 
import java.awt.Frame; 
import java.awt.event.MouseEvent; 
import java.awt.event.KeyEvent; 
import java.awt.event.FocusEvent; 
import java.awt.Image; 
import java.io.*; 
import java.net.*; 
import java.text.*; 
import java.util.*; 
import java.util.zip.*; 
import java.util.regex.*; 

public class CubeRotate extends PApplet {

/**
  @file CubeRotate
  @brief Cube on which Mouse Pointer is, rotates.
  @author Kenichi Yorozu
  @date 13th March 2012
 */



float boxSize = 40;  ///Size of Box : w, h, d
int boxFill;    /// Color of Box.

//Camera Properties
float camZoom = 130.0f;
float camRotX = 0.0f;
float camRotY = 0.0f;
float camTX = 0.0f;
float camTY = 0.0f;
//Mouse Properties
int lastX = 0;
int lastY = 0;
int nowX = 0;
int nowY = 0;
boolean[] Buttons = {false, false, false};
/**
 * @brief mode of interaction
 * 0 : Y-rotation
 * 1 : Z-translation
 * default : 1
 */
int mode = 1;

/// Number of Columns of box array
int column = 32;
/// Number of Rows of box array
int row = 24;
/**
  @brief Values of each Boxes
  values are gray colors. : 0-255
 */
int[][] values = new int[column][row];

public void setup(){
  int i = 2;
  size(640 * i, 480 * i, P3D);      //Use processing 3D
  //size(640, 480, OPENGL);  //Use OpenGL
  //hint(ENABLE_DEPTH_SORT);  //Too Heavy
  noStroke();
  int index = 0;
  for(int k = 0; k < column; k++){
    for(int j = 0; j < row; j++){
      values[k][j] = ++index;
      if(index > 255){
        index = 0;
      }
    }
  }
}

public void draw(){
  background(0);
  lights();
  //Update Camera
  translate(camTX + width/2, camTY + height/2, -camZoom);
  rotateX(camRotX);
  rotateY(camRotY);
  
  //About Lights - See http://r-dimension.xsrv.jp/classes_j/5_interactive3d/
  //lights();  //Normal Light
  //directionalLight(200, 200, 200, -1, 0, -1);
  //pointLight(200, 200, 200, 0, 0, 0);
  spotLight(200, 200, 200, 400, -400, 400, -1, 1, -1, PI/4, 10);
  //shininess(5.0);
  
  //DrawBoxes
  for(int i = 0; i < column; i++){
    translate( ( i - column / 2 ) * boxSize, 0, 0);
    for(int j = 0; j < row; j++){
      translate(0, ( j - row / 2 ) * boxSize, 0);
      //Modify Object
      if(i == nowX / (width / column) && j == nowY / (height / row)){
        //set Color
        boxFill = color(150, 150, 150, 255);
        fill(boxFill);
        switch(mode){
          case 0:
            rotateY(frameCount * 0.1f);
            box(boxSize, boxSize, boxSize);
            rotateY(-frameCount * 0.1f);
            break;
          case 1:
            translate(0, 0, frameCount);
            box(boxSize, boxSize, boxSize);
            translate(0, 0, -frameCount);
            break;
          default:
            break;
        }
      }else{
        int value = values[i][j];
        //set Color
        boxFill = color(value, value, value, 255);
        fill(boxFill);
        switch(mode){
          case 0:
            rotateY(frameCount * 0.1f * value);
            box(boxSize, boxSize, boxSize);
            rotateY(-frameCount * 0.1f * value);
            break;
          case 1:
            translate(0, 0, value);
            box(boxSize, boxSize, boxSize);
            translate(0, 0, -value);
            break;
          default:
            break;
        }
      }
      translate(0, -( j - row / 2 ) * boxSize, 0);
    }
    translate(- ( i - column / 2 ) * boxSize, 0, 0);
  }
//  translate(0, 0, boxSize);
//  fill(100, 100, 100, 255);
//  box(boxSize * 2, boxSize * 2, boxSize * 2);
}

public void keyPressed(){
  switch(key){
    case '0':  /// Spin Mode
      mode = 0;
      break;
    case '1':  /// Move Mode
      mode = 1;
      break;
    default:
      break;
  }
}

public void mousePressed(){
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

public void mouseMoved(){
  nowX = mouseX;
  nowY = mouseY;
}

public void mouseDragged(){
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
  static public void main(String args[]) {
    PApplet.main(new String[] { "--present", "--bgcolor=#666666", "--stop-color=#cccccc", "CubeRotate" });
  }
}
