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
      break;
      
    case 2:  //ビデオ画像
      int[] img = m.differenceImage(); //get the normal image of the camera
      int[] f2 = m.globsImage(); //get the normal image of the camera
      int[] cam = m.cameraImage();
      loadPixels();
      for(int i=0;i<width*height;i++){ //loop through all the pixels
        if(f2[i] < 50){
          pixels[i] = img[i]; //draw each pixel to the screen
        }else{
          pixels[i] = cam[i];
        }
      }
      updatePixels();
      break;
  }
}
