/**
  @file CubeRotate
  @brief Cube on which Mouse Pointer is, rotates.
  @author Kenichi Yorozu
  @date 13th March 2012
 */

import processing.opengl.*;

float boxSize = 40;
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

void setup(){
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

void draw(){
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
      if(i == nowX / column && j == nowY / row){
        //print('i:' + i + ', nowX/column:' + nowX/column + 'nowY/row:' + nowY/row + '\n');
        //set Color
        boxFill = color(150, 150, 150, 255);
        fill(boxFill);
        switch(mode){
          case 0:
            rotateY(frameCount * 0.1);
            box(boxSize, boxSize, boxSize);
            rotateY(-frameCount * 0.1);
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
            rotateY(frameCount * 0.1 * value);
            box(boxSize, boxSize, boxSize);
            rotateY(-frameCount * 0.1 * value);
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

void keyPressed(){
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

void mouseMoved(){
  nowX = mouseX - width / 2;
  nowY = mouseY - height / 2;
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
