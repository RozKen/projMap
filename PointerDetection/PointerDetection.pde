/**
 @brief Test for Detecting laser-pointing point from Camera Input
 @date 28th March 2012
 @author Kenichi Yorozu
*/

import JMyron.*;

JMyron m;//a camera object
boolean isDebugging = false;
int debugMode = 1;

/**
  @brief set up processing application
 */
void setup(){
  size(640,480);
  m = new JMyron();        //make a new instance of the object
  m.start(width,height);    //start a capture at screen size
  m.trackColor(255, 0, 0, 256-10);  //track red color!!!!!!!!!!!
  m.update();
}

/**
  @brief draw on cambus
 */
void draw(){
  m.update();//update the camera view
  if(isDebugging){
    onDebug(debugMode);
  }else{
    onDraw();
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
  @brief keyboard handler
 */
void keyPressed(){
  switch(key){
    case 'd':
      isDebugging = !isDebugging;
      break;
    case 's':
      if(debugMode == 0){
        debugMode = 1;
      }else if(debugMode == 1){
        debugMode = 2;
      }else if(debugMode == 2){
        debugMode = 0;
      }
      break;
  }
}

/**
  @brief Destructor
 */
public void stop(){
  m.stop();//stop the object
  super.stop();
}

