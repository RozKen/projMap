import controlP5.*; // Slider
ControlP5 cp5;
PImage img;
int sumcolor;
int unit = 20; // Unit size
int ucolor[][]; // Unit array for average color

void setup(){
  cp5 = new ControlP5(this);// Add slider field to controle unit size
  cp5.addSlider("unit").setPosition(30,20).setSize(150,15).setRange(1,40);
  size(640, 480);
  img = loadImage("image.jpg"); // Load image
  img.filter(GRAY); // Filter image to gray scale
  noStroke();
}

void draw(){
  mozaik(img, unit);
}

void mozaik(PImage image, int unit) {
  // Initialize pixel unit color array
  int[][] ucolor = new int[width/unit][height/unit];
  for (int i = 0; i<width/unit; i++){
    for (int j = 0; j<height/unit; j++){
      sumcolor = 0;
      int lt = width*unit*j + unit*i; // Left Top corner of a unit
      for (int t = 0; t<unit; t++){
        for (int s = 0; s<unit; s++){
          int number = lt + t + s*width; // Iterate for all pixels in a unit
          sumcolor += image.pixels[number] & 0xFF; // Load pixel color
        }
      }
      ucolor[i][j] = sumcolor/(unit*unit); // Set color average into unit array
    }
  }
  for (int i = 0; i<width/unit; i++){
    for (int j = 0; j<height/unit; j++){
      fill(ucolor[i][j]);
      rect(unit*i,unit*j,unit,unit); // Draw rectangles
    }
  }
}