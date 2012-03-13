import processing.opengl.*;

float boxSize = 100;
float margin = boxSize*2;
float depth = 400;
color boxFill;

void setup() {
  size(640, 360, P3D);
  //size(640, 360, OPENGL);
  noStroke();
}

void draw() {
  background(255);
  
  // Center and spin grid
  translate(width/2, height/2, -depth);
  rotateY(1.0);

  // Build grid using multiple translations 
  for (float i =- depth/2+margin; i <= depth/2-margin; i += boxSize){
    pushMatrix();
    for (float j =- height+margin; j <= height-margin; j += boxSize){
      pushMatrix();
      for (float k =- width+margin; k <= width-margin; k += boxSize){
        // Base fill color on counter values, abs function 
        // ensures values stay within legal range
        boxFill = color(abs(i), abs(j), abs(k), 100);
        pushMatrix();
        translate(k, j, i);
        rotateY(frameCount * 0.01);
        //rotateX(frameCount * 0.01);
        fill(boxFill);
        box(boxSize, boxSize, boxSize);
        rotateY(-frameCount * 0.01);
       // rotateX(-frameCount * 0.01);
        popMatrix();
      }
      popMatrix();
    }
    popMatrix();
  }
}
