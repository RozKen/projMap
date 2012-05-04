/**
 * @brief Brightness Thresholding after Background Subtraction
 * Merging 2 Programs into pipeline;
 * @author Kenichi Yorozu
 * @date 4th May 2012
 */
 
 import processing.video.*;
 
 int numPixels;
 int[] backgroundPixels;
 Capture video;
 
 void setup(){
   size(640, 480, P2D);
   strokeWeight(5);
   
   video = new Capture(this, width, height, 24);
   numPixels = video.width * video.height;
   backgroundPixels = new int[numPixels];
   
   noCursor();
   smooth();
 }
 
 void draw() {
  if (video.available()) {
    video.read();
    video.loadPixels();
    int threshold = 180; // Set the threshold value
    color[] outputPixelData2 = subtractBg(video.pixels, backgroundPixels);
    color[] outputPixelData = BrightnessThresholding(outputPixelData2, threshold);
    
    loadPixels();
    arraycopy(outputPixelData, pixels);
    updatePixels();
    
    // Test a location to see where it is contained. Fetch the pixel at the test
    // location (the cursor), and compute its brightness
    /*int testValue = get(mouseX, mouseY);
    float testBrightness = brightness(testValue);
    if (testBrightness > threshold) { // If the test location is brighter than
      fill(black); // the threshold set the fill to black
    } 
    else { // Otherwise,
      fill(white); // set the fill to white
    }
    ellipse(mouseX, mouseY, 20, 20);
    */
  }
}

void keyPressed(){
  video.loadPixels();
  arraycopy(video.pixels, backgroundPixels);
}
