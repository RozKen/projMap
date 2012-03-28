/**
 @brief Test for Detecting laser-pointing point from Camera Input
 @date 28th March 2012
 @author Kenichi Yorozu
*/

import JMyron.*;

JMyron m;//a camera object

/**
  @brief set up processing application
 */
void setup(){
  size(640,480);
  m = new JMyron();        //make a new instance of the object
  m.start(width,height);    //start a capture at screen size
  m.trackColor(255, 0, 0, 256-70);  //track red color!!!!!!!!!!!
  m.update();
}

/**
  @brief draw on cambus
 */
void draw(){
  m.update();//update the camera view
  //onDraw();
  onDebug(1);
}

/**
  @brief Production Mode Display
 */
void onDraw(){
  
}

/**
  @brief Debug Mode Display
 */
void onDebug(int mode){
  //背景を黒で初期化
  background(0);
  
  switch(mode){
    case 0:  //赤色を検出した部分を白色で表示
      int[] f = m.globsImage();
      loadPixels();
      for(int i=0;i<width*height;i++){ //loop through all the pixels
        pixels[i] = f[i];
      }
      updatePixels();
      break;
      
    case 1:  //赤色で検出した部分の中心点を白丸で表示
      //これで，検出したGlobの中心点を得られる．このなかのどこかにレーザーポインタが含まれているはず．
      int[][] p = m.globCenters();  //int[][][2]
      //globの中心点を，20pxの円で描画表現
      for(int i = 0; i < p.length; i++){
        ellipse(p[i][0], p[i][1], 20, 20);
      }
  }
}

/**
  @brief mouse handler
 */
void mousePressed(){
  if(mouseButton == RIGHT){
    m.settings();//click the window to get the settings
  }else if(mouseButton == LEFT){
    //Nothing set
  }
}

/**
  @brief Destructor
 */
public void stop(){
  m.stop();//stop the object
  super.stop();
}

