/**
 * Background Subtraction 
 * by Golan Levin. 
 * 
 * Detect the presence of people and objects in the frame using a simple
 * background-subtraction technique. To initialize the background, press a key.
 */


import processing.video.*;

int numPixels;
int[] backgroundPixels;
Capture video;

void setup() {
  // Change size to 320 x 240 if too slow at 640 x 480
  size(640, 480, P2D); 
  
  video = new Capture(this, width, height, 24);
  numPixels = video.width * video.height;
  // Create array to store the background image
  backgroundPixels = new int[numPixels];
  // Make the pixels[] array available for direct manipulation
  loadPixels();
}

void draw() {
  if (video.available()) {
    video.read(); // Read a new video frame
    video.loadPixels(); // Make the pixels of video available
    
    //Subtract Background
    color[] outputPixelData = subtractBg(video.pixels, backgroundPixels);
    
    arraycopy(outputPixelData, pixels);
    
    updatePixels(); // Notify that the pixels[] array has changed
  }
}

// When a key is pressed, capture the background image into the backgroundPixels
// buffer, by copying each of the current frame’s pixels into it.
void keyPressed() {
  video.loadPixels();
  arraycopy(video.pixels, backgroundPixels);
}

