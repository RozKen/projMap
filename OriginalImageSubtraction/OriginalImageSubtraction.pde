/**
  @brief Original Image Subtraction
  @author Kenichi Yorozu
  @date 22nd February 2012
 */
PImage bgImg;        //背景にある画像
PImage invImg;      //背景画像の反転画像
PImage img;          //表示したい画像
PImage compositeImg;  //合成された画像

int movieLength = 10;
PImage[] movie = new PImage[movieLength];      //連番画像
int frame = 0;
boolean forward = true;

void setup(){
  //colorMode(RGB, 255);
  size(600 * 2, 600 * 2);
  bgImg = loadImage("facade.jpg");
  invImg = new PImage(600, 600);
  img = loadImage("yasuda600.jpg");
  compositeImg = new PImage(600, 600);
  
  int offset = 75;
  
  //反転画像を生成
  invImg.loadPixels();
  bgImg.loadPixels();
  for(int i = 0; i < 600 * 600; i++){
    invImg.pixels[i] = cSubtract(color(255 - offset, 255 - offset, 255 - offset), bgImg.pixels[i]);
  }
  invImg.updatePixels();
  
  //足し合わせ画像を生成
  compositeImg.loadPixels();
  img.loadPixels();
  invImg.loadPixels();
  for(int i = 0; i < 600 * 600; i++){
    compositeImg.pixels[i] = cAdd(img.pixels[i], invImg.pixels[i]);
  }
  compositeImg.updatePixels();
  
  //for Movie
  frameRate(5);
  for(int i = 0; i < movieLength; i++){
    //String url = "movie/cube/門型cube000" + str(i) + ".jpg";
   String url = "movie/original/門型000" + str(i) + ".jpg";
    movie[i] = loadImage(url);
    movie[i].loadPixels();
    invImg.loadPixels();
    for(int j = 0; j < 600 * 600; j++){
      movie[i].pixels[j] = cAdd(movie[i].pixels[j], invImg.pixels[j]);
    }
    movie[i].updatePixels();
  }
}

void draw(){
  //背景画像を表示
  image(bgImg, 0, 600); // Displays the image from point (0,0) 
  
  //背景反転画像を表示
  image(invImg, 0, 0);
  
  //表示画像を表示
  image(img, 600, 600);
  
  //合成画像を表示
  image(compositeImg, 600, 0);
  save("composite.jpg");
  
  image(movie[frame], 0, 0);
  if( forward ){
    frame++;
    if(frame > movieLength - 1){
      forward = false;
      frame--;
    }
  }else{
    frame--;
    if(frame < 0){
      forward = true;
      frame++;
    }
  }
  
}

color cAdd(color A, color B){
  float[] tmp = new float[3];
  tmp[0] = red(A) + red(B);
  tmp[1] = green(A) + green(B);
  tmp[2] = blue(A) + blue(B);
  for(int i = 0; i < 3; i++){
    if(tmp[i] < 0){
      tmp[i] = 0;
    }else if(tmp[i] > 255.0){
      tmp[i] = 255.0;
    }
  }
  color result = color(tmp[0], tmp[1], tmp[2]);
  return result;
}

color cSubtract(color A, color B){
  float[] tmp = new float[3];
  tmp[0] = red(A) - red(B);
  tmp[1] = green(A) - green(B);
  tmp[2] = blue(A) - blue(B);
  for(int i = 0; i < 3; i++){
    if(tmp[i] < 0){
      tmp[i] = 0;
    }else if(tmp[i] > 255.0){
      tmp[i] = 255.0;
    }
  }
  color result = color(tmp[0], tmp[1], tmp[2]);
  return result;
}

