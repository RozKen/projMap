/**
  @brief Transform image to fit surface projected on
  @author Kenichi Yorozu
  @date 22nd February 2012
 */

import java.awt.image.BufferedImage;

int width = 800;
int height = 600;
int d = (int)sqrt(width * width + height * height);  //対角線
float alpha = 50.0f;  //視角度
int z = (int)((float)(d / 2) / Math.tan(alpha / 2.0f));

float[] projector = {0, 0, -z};    //projector pos
float[] projectorTarget = {0, 0, 0};  //projectorの注視点

PImage img;    //表示したい画像
PImage proj;   //投影する画像

void setup(){
 size(800 * 2, 600);
 img = loadImage("ox_car.jpg");
 proj = new PImage(800, 600);
 
 PerspectiveFilter pf = new PerspectiveFilter();
 pf.setCorners(0,0, 500,0, 500, 600, 0, 600);
 pf.setEdgeAction(pf.ZERO);
 
 proj = new PImage(pf.filter((BufferedImage)img.getImage(), null));
 
 //投影画像を生成
/* img.loadPixels();
 proj.loadPixels();
 for(int i = 0; i < 800 * 600; i++){
   if(i % 800 < 400){  //左半分
     
   }else{  //右半分
     
   }
    proj.pixels[i] = -img.pixels[i];
  }
 proj.updatePixels();
 */
}

void draw(){
  image(img, 0, 0);
  image(proj, 800, 0);
  save("proj.jpeg");
}

PImage cutImage(PImage img, int startX, int startY, int endX, int endY){
  for(int y = startY; y < endY; y++){
    for(int x = 
  }
}
