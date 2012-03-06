import processing.opengl.*;

import saito.objloader.*;

OBJModel model ;

float rotX, rotY;
float posX = 0, posY = 0;
float zoom = 0;

void setup()
{
    size(800, 800, OPENGL);
    frameRate(30);
    //model = new OBJModel(this, "dma.obj", "absolute", TRIANGLES);
    model = new OBJModel(this, "Gate2melt.obj", "absolute", POLYGON);
    //model = new OBJModel(this, "Gate2melt.obj", "absolute", TRIANGLES);
    model.enableDebug();

    model.scale(1);
    model.translateToCenter();

    stroke(255);
    noStroke();
}



void draw()
{
    background(129);
    lights();
    pushMatrix();
    translate(width/2, height/2, 0);
    rotateX(rotY);
    rotateY(rotX);
    translate(posX, posY, zoom);
    
    //camera(0, 0, 50.0, 0.0, 0.0, 0.0, 0.0, 1.0, 0.0);
    float fov = radians(80);  //視野角を設定
    //perspective(fov, float(width)/ float(height), 1.0, 2000.00);
    //ortho(-60, 60, -60, 60, -60, 60);

    model.draw();

    popMatrix();
}

boolean bTexture = false;
boolean bStroke = false;

void keyPressed()
{
    if(key == 't') {
        if(!bTexture) {
            model.enableTexture();
            bTexture = true;
        } 
        else {
            model.disableTexture();
            bTexture = false;
        }
    }

    if(key == 's') {
        if(!bStroke) {
            stroke(255);
            bStroke = true;
        } 
        else {
            noStroke();
            bStroke = false;
        }
    }

    else if(key=='1')
        model.shapeMode(POINTS);
    else if(key=='2')
        model.shapeMode(LINES);
    else if(key=='3')
        model.shapeMode(POLYGON);
        //model.shapeMode(TRIANGLES);
}

void mouseDragged()
{
  if (mouseButton == LEFT){
    rotX += (mouseX - pmouseX) * 0.01;
    rotY -= (mouseY - pmouseY) * 0.01;
  }else if(mouseButton == CENTER){
    zoom += ((mouseX - pmouseX) - (mouseY - pmouseY)) * 0.1;
  }else if(mouseButton == RIGHT){
    posX += (mouseX - pmouseX) * 0.1;
    posY += (mouseY - pmouseY) * 0.1;
  };
}

