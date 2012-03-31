/**
 *	
 * SoundParticle
 * by grandbleukai
 *  
 */

import ddf.minim.analysis.*;
import ddf.minim.*;
import JMyron.*;
////////////////For Light Detection////////////////////
JMyron m;//a camera object
boolean isDebugging = false;
int debugMode = 1;

///////////////For Sound Analyzation///////////////////
Minim minim;
AudioPlayer jingle;
FFT fft;
String windowName;
int soundLevel;
//////////////For Particle Effects/////////////
int counter;    // カウンタ
PImage[]  tex;  // テクスチャ配列
PVector[] pos;  // パーティクル位置ベクトル
PVector[] vel;  // パーティクル速度ベクトル

final int NUM_PARTICLES  = 300;  // パーティクル数
final float ACCELERATION = 0.01;  // 加速度


void setup()
{
  background(0);
  size(640, 480);

  ///Camera Settings
  m = new JMyron();        //make a new instance of the object
  m.start(width,height);    //start a capture at screen size
  m.trackColor(255, 0, 0, 256-10);  //track red color!!!!!!!!!!!
  m.update();
  
  // Setting FFT
  minim = new Minim(this);
//  jingle = minim.loadFile("RockTheBeat.mp3", 2048);
  jingle = minim.loadFile("Season.mp3", 2048);
  jingle.loop();
  fft = new FFT(jingle.bufferSize(), jingle.sampleRate());
  windowName = "None";

  //Defining texture, position, velosity
  tex = new PImage[NUM_PARTICLES];
  pos = new PVector[NUM_PARTICLES];
  vel = new PVector[NUM_PARTICLES];
  counter = 0;

  // パーティクルのテクスチャを配列に格納
  colorMode(HSB, NUM_PARTICLES, 100, 100);
  for(int i = 0; i < tex.length; i++) {
    tex[i] = getParticleTexture(color(i, 80, 50));
    pos[i] = new PVector(0, height * 2);
    vel[i] = new PVector();
  }

}

void draw()
{
  m.update();//update the camera view
  if(isDebugging){
    onDebug(debugMode);
  }else{
    onDraw();
  }
}

/**
  @brief Production Mode Display
 */
void onDraw(){
  	noStroke();
	fill(0,10);
	rect(0, 0, width, height);
	
	// perform a forward FFT on the samples in jingle's left buffer
  // note that if jingle were a MONO file, this would be the same as using jingle.right or jingle.left
  fft.forward(jingle.mix);

	//Sam of Sound Level
	soundLevel = 0;
  for (int i = 0; i<fft.specSize(); i++){
		soundLevel += fft.getBand(i);
  }
	
	
  // カウンタ更新
  if (++counter >= NUM_PARTICLES) counter = 0;
  
  // ずれ量（初期位置にノイズを加える）
  float noiseAmount = tex[counter].width/4.0;
  
  if (mousePressed && (mouseButton == LEFT)) {
    pos[counter].x = width/2 + random(-noiseAmount, noiseAmount);
    pos[counter].y = height * 9/10 + random(-noiseAmount, noiseAmount);
  } else {
    int[][] p = m.globCenters();
    if(p.length == 0){
     pos[counter].x = mouseX;
     pos[counter].y = mouseY;
    }else{
      pos[counter].x = p[0][0];
      pos[counter].y = p[0][1];
    }
  };

  
  // 初速度の設定
  vel[counter].x = random(-1, 1);
  vel[counter].y = random(-1, 1);
  
  
  // パーティクルの更新
  for(int i = 0; i < NUM_PARTICLES; i++) {
    if(pos[i].y < height+tex[i].height && pos[i].y>-tex[i].height) {
      // パーティクル描画 加算合成にするのがポイント
      blend(tex[i], 0, 0, 
            tex[i].width, tex[i].height,
            (int)pos[i].x, (int)pos[i].y,
            tex[i].width, tex[i].height, ADD);
    }

    // 位置・速度更新
			pos[i].x += sin(NUM_PARTICLES*i/PI)*soundLevel/700;
			pos[i].y += cos(NUM_PARTICLES*i/PI)*soundLevel/700;

//			pos[i].x += fft.getBand(i)/5+vel[i].x;
//			pos[i].y += fft.getBand(i)/5+vel[i].y;
//    	vel[i].x += random(-0.1, 0.1);
//    	vel[i].y += random(-0.1, 0.1);
  }
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

// ==============================================
// 指定した色のパーティクル用テクスチャを生成する
// 引数 c : パーティクルの色
// ==============================================
PImage getParticleTexture(color c) {
  // 画像サイズとパーティクルの半径
  final int   IMG_SIZE        = 15;
  final float PARTICLE_RADIUS = 0.5f * IMG_SIZE - 2;
  
  // colorMode(RGB, 255, 255, 255);
  // 画像を作成
  PImage img = createImage(IMG_SIZE, IMG_SIZE, RGB);
  img.loadPixels();
  for(int i = (int)PARTICLE_RADIUS; i > 0; i--) {
    // グラデーション作成
    int a = (int)(0xFF*(float)(PARTICLE_RADIUS-i)/PARTICLE_RADIUS);
    int fg = c;
    int fR = (0x00FF0000 & fg) >>> 16;
    int fG = (0x0000FF00 & fg) >>> 8;
    int fB =  0x000000FF & fg; 
    int rR = (fR * a) >>> 8;
    int rG = (fG * a) >>> 8;
    int rB = (fB * a) >>> 8;
     fg = 0xFF000000 | (rR << 16) | (rG << 8) | rB;
    // パーティクル用テクスチャ作成
    for(int y = 0; y < img.height; y++) {
      for(int x = 0; x < img.width; x++) {
        float yDistance = (y-img.height/2.0)*(y-img.height/2.0);
        float xDistance = (x-img.width/2.0)*(x-img.width/2.0);
        if(yDistance + xDistance <= i*i) {
          img.pixels[y * img.width + x] = fg;
        }
      }
    }
  }
  img.updatePixels();
  img.filter(BLUR);
  return img;
}

/**
  @brief Destructor
 */
void stop()
{
  // always close Minim audio classes when you finish with them
  jingle.close();
  minim.stop();
  
  m.stop();//stop the object
  
  super.stop();
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
